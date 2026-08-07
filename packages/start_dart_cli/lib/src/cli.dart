import 'dart:convert';
import 'dart:io';

import 'process_runner.dart';
import 'template.dart';

typedef OutputWriter = void Function(String message);

final class StartDartCli {
  StartDartCli({
    ProcessRunner? processRunner,
    OutputWriter? stdoutWriter,
    OutputWriter? stderrWriter,
    Directory? workingDirectory,
  }) : _processRunner = processRunner ?? const SystemProcessRunner(),
       _stdoutWriter = stdoutWriter ?? stdout.writeln,
       _stderrWriter = stderrWriter ?? stderr.writeln,
       _workingDirectory = workingDirectory ?? Directory.current;

  final ProcessRunner _processRunner;
  final OutputWriter _stdoutWriter;
  final OutputWriter _stderrWriter;
  final Directory _workingDirectory;

  Future<int> run(List<String> arguments) async {
    final jsonOutput = arguments.contains('--json');
    final args = arguments.where((item) => item != '--json').toList();
    try {
      if (args.isEmpty ||
          args.first == 'help' ||
          args.first == '--help' ||
          args.first == '-h') {
        _writeSuccess(jsonOutput, const {'message': _usage});
        return 0;
      }
      return switch (args.first) {
        'create' => await _create(args.skip(1).toList(), jsonOutput),
        'doctor' => await _doctor(jsonOutput),
        'add' => await _add(args.skip(1).toList(), jsonOutput),
        _ => throw CliException('Unknown command: ${args.first}', usage: true),
      };
    } on CliException catch (error) {
      _writeError(jsonOutput, error.message, usage: error.usage);
      return error.exitCode;
    } on FileSystemException catch (error) {
      _writeError(jsonOutput, error.message);
      return 1;
    } on ProcessException catch (error) {
      _writeError(jsonOutput, error.message);
      return 1;
    }
  }

  Future<int> _create(List<String> args, bool jsonOutput) async {
    final parsed = _parseOptions(
      args,
      allowed: {'output', 'org', 'description', 'local-framework'},
    );
    if (parsed.positionals.length != 1) {
      throw const CliException(
        'create expects exactly one project name.',
        usage: true,
      );
    }
    final name = _validateDartName(parsed.positionals.single, kind: 'project');
    final organization = parsed.options['org'] ?? 'com.example';
    final description =
        parsed.options['description'] ?? 'AI-native Flutter application.';
    if (!RegExp(
      r'^[a-z][a-z0-9]*(\.[a-z][a-z0-9]*)+$',
    ).hasMatch(organization)) {
      throw const CliException(
        'Organization must use reverse-domain notation, for example com.example.',
      );
    }
    final output = _resolvePath(parsed.options['output'] ?? name);
    if (await FileSystemEntity.type(output) != FileSystemEntityType.notFound) {
      throw CliException('Destination already exists: $output');
    }

    final parent = Directory(_parentOf(output));
    await parent.create(recursive: true);
    final staging = await parent.createTemp('.start_dart_${name}_');
    var promoted = false;
    try {
      final generatedRoot = _join(staging.path, name);
      final result = await _processRunner.run('flutter', [
        'create',
        '--platforms=android,ios',
        '--org=$organization',
        '--project-name=$name',
        '--description=$description',
        generatedRoot,
      ]);
      if (result.exitCode != 0) {
        throw CliException(
          'Flutter project creation failed: ${_processMessage(result)}',
        );
      }
      final localFramework =
          parsed.options['local-framework'] ?? _workspaceFrameworkPath();
      if (localFramework != null &&
          await FileSystemEntity.type(_resolvePath(localFramework)) !=
              FileSystemEntityType.directory) {
        throw CliException(
          'Local framework directory does not exist: $localFramework',
        );
      }
      await TemplateWriter(
        root: Directory(generatedRoot),
        projectName: name,
        localFrameworkPath: localFramework == null
            ? null
            : _resolvePath(localFramework),
      ).write();
      final analyze = await _processRunner.run('flutter', [
        'pub',
        'get',
      ], workingDirectory: generatedRoot);
      if (analyze.exitCode != 0) {
        throw CliException(
          'Dependency resolution failed: ${_processMessage(analyze)}',
        );
      }
      await Directory(generatedRoot).rename(output);
      promoted = true;
      _writeSuccess(jsonOutput, {
        'command': 'create',
        'name': name,
        'path': output,
      });
      return 0;
    } finally {
      if (!promoted && await staging.exists()) {
        await staging.delete(recursive: true);
      } else if (await staging.exists()) {
        await staging.delete(recursive: true);
      }
    }
  }

  Future<int> _doctor(bool jsonOutput) async {
    final checks = <Map<String, Object>>[];
    for (final executable in ['dart', 'flutter', 'git']) {
      try {
        final output = await _processRunner.run(executable, ['--version']);
        checks.add({
          'tool': executable,
          'ok': output.exitCode == 0,
          'version': _processMessage(output).split('\n').first,
        });
      } on ProcessException {
        checks.add({'tool': executable, 'ok': false, 'version': 'not found'});
      }
    }
    final healthy = checks.every((check) => check['ok'] == true);
    if (jsonOutput) {
      _stdoutWriter(
        jsonEncode({'ok': healthy, 'command': 'doctor', 'checks': checks}),
      );
    } else {
      for (final check in checks) {
        _stdoutWriter(
          '${check['ok'] == true ? '✓' : '✗'} ${check['tool']}: ${check['version']}',
        );
      }
    }
    return healthy ? 0 : 1;
  }

  Future<int> _add(List<String> args, bool jsonOutput) async {
    final parsed = _parseOptions(args, allowed: {'project'});
    if (parsed.positionals.length < 2) {
      throw const CliException(
        'add expects a type and its arguments.',
        usage: true,
      );
    }
    final type = parsed.positionals.first;
    final project = Directory(
      _resolvePath(parsed.options['project'] ?? _workingDirectory.path),
    );
    if (!await File(_join(project.path, 'pubspec.yaml')).exists()) {
      throw CliException('Not a Flutter project: ${project.path}');
    }
    late final String name;
    switch (type) {
      case 'feature':
        if (parsed.positionals.length != 2) {
          throw const CliException(
            'add feature expects exactly one name.',
            usage: true,
          );
        }
        name = _validateDartName(parsed.positionals[1], kind: type);
        await TemplateWriter.addFeature(project, name);
      case 'model':
        if (parsed.positionals.length != 3) {
          throw const CliException(
            'add model expects a feature and a model name.',
            usage: true,
          );
        }
        final feature = _validateDartName(
          parsed.positionals[1],
          kind: 'feature',
        );
        name = _validateDartName(parsed.positionals[2], kind: type);
        await TemplateWriter.addModel(project, feature, name);
      default:
        throw CliException(
          'Unsupported add type: $type. Expected feature or model.',
        );
    }
    _writeSuccess(jsonOutput, {
      'command': 'add',
      'type': type,
      'name': name,
      'path': project.path,
    });
    return 0;
  }

  ParsedArguments _parseOptions(
    List<String> args, {
    required Set<String> allowed,
  }) {
    final positionals = <String>[];
    final options = <String, String>{};
    for (var index = 0; index < args.length; index++) {
      final item = args[index];
      if (!item.startsWith('-')) {
        positionals.add(item);
        continue;
      }
      final normalized = item == '-o' ? '--output' : item;
      if (!normalized.startsWith('--')) {
        throw CliException('Unknown option: $item');
      }
      final parts = normalized.substring(2).split('=');
      final key = parts.first;
      if (!allowed.contains(key)) {
        throw CliException('Unknown option: --$key');
      }
      if (parts.length == 2) {
        options[key] = parts.last;
      } else if (index + 1 < args.length && !args[index + 1].startsWith('-')) {
        options[key] = args[++index];
      } else {
        throw CliException('Option --$key requires a value.');
      }
    }
    return ParsedArguments(positionals: positionals, options: options);
  }

  String _validateDartName(String value, {required String kind}) {
    final valid =
        RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value) && !value.endsWith('_');
    if (!valid || _dartKeywords.contains(value)) {
      throw CliException(
        'Invalid $kind name "$value". Use lowercase_with_underscores.',
      );
    }
    return value;
  }

  String _resolvePath(String path) {
    if (path.startsWith('/')) return _normalize(path);
    return _normalize(_join(_workingDirectory.absolute.path, path));
  }

  String? _workspaceFrameworkPath() {
    final starts = <Directory>[
      _workingDirectory.absolute,
      Directory.current.absolute,
      File.fromUri(Platform.script).parent.absolute,
    ];
    for (final start in starts) {
      var candidate = start;
      while (candidate.parent.path != candidate.path) {
        final workspacePackage = Directory(
          _join(candidate.path, 'packages/start_dart'),
        );
        if (File(_join(workspacePackage.path, 'pubspec.yaml')).existsSync()) {
          return workspacePackage.path;
        }
        final siblingPackage = Directory(
          _join(candidate.path, '../start_dart'),
        );
        if (File(_join(siblingPackage.path, 'pubspec.yaml')).existsSync()) {
          return siblingPackage.absolute.path;
        }
        candidate = candidate.parent;
      }
    }
    return null;
  }

  void _writeSuccess(bool jsonOutput, Map<String, Object> payload) {
    _stdoutWriter(
      jsonOutput
          ? jsonEncode({'ok': true, ...payload})
          : (payload['message'] ?? _humanize(payload)).toString(),
    );
  }

  void _writeError(bool jsonOutput, String message, {bool usage = false}) {
    _stderrWriter(
      jsonOutput
          ? jsonEncode({'ok': false, 'error': message})
          : '$message${usage ? '\n\n$_usage' : ''}',
    );
  }

  String _humanize(Map<String, Object> payload) => switch (payload['command']) {
    'create' => 'Created ${payload['name']} at ${payload['path']}',
    'add' => 'Added ${payload['type']} ${payload['name']}',
    _ => payload.toString(),
  };
}

final class ParsedArguments {
  const ParsedArguments({required this.positionals, required this.options});
  final List<String> positionals;
  final Map<String, String> options;
}

final class CliException implements Exception {
  const CliException(this.message, {this.exitCode = 64, this.usage = false});
  final String message;
  final int exitCode;
  final bool usage;
}

String _processMessage(ProcessOutput output) {
  final message = output.stdout.trim().isNotEmpty
      ? output.stdout.trim()
      : output.stderr.trim();
  return message.isEmpty
      ? 'process exited with code ${output.exitCode}'
      : message;
}

String _join(String left, String right) =>
    '${left.replaceAll(RegExp(r'[/\\]+$'), '')}${Platform.pathSeparator}${right.replaceAll(RegExp(r'^[/\\]+'), '')}';
String _parentOf(String path) => File(path).parent.path;
String _normalize(String path) => Directory(path).absolute.path;

const _dartKeywords = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'of',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'sealed',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};

const _usage = '''START.DART — AI-native Flutter application toolkit

Usage:
  startdart create <name> [--output <path>] [--org <domain>] [--description <text>] [--local-framework <path>] [--json]
  startdart doctor [--json]
  startdart add feature <name> [--project <path>] [--json]
  startdart add model <feature> <name> [--project <path>] [--json]''';
