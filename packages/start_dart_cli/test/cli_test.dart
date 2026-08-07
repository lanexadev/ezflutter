import 'dart:convert';
import 'dart:io';

import 'package:start_dart_cli/start_dart_cli.dart';
import 'package:test/test.dart';

void main() {
  late Directory sandbox;
  late List<String> output;
  late List<String> errors;

  setUp(() async {
    sandbox = await Directory.systemTemp.createTemp('start_dart_cli_test_');
    output = [];
    errors = [];
  });

  tearDown(() async {
    if (await sandbox.exists()) await sandbox.delete(recursive: true);
  });

  StartDartCli cli(ProcessRunner runner) => StartDartCli(
    processRunner: runner,
    workingDirectory: sandbox,
    stdoutWriter: output.add,
    stderrWriter: errors.add,
  );

  test('prints machine-readable help', () async {
    final exitCode = await cli(
      const SuccessfulRunner(),
    ).run(['help', '--json']);

    expect(exitCode, 0);
    expect(jsonDecode(output.single), containsPair('ok', true));
  });

  test('reports healthy developer tools', () async {
    final exitCode = await cli(
      const SuccessfulRunner(),
    ).run(['doctor', '--json']);

    expect(exitCode, 0);
    expect(jsonDecode(output.single), containsPair('ok', true));
  });

  test('rejects invalid project names without writing files', () async {
    final exitCode = await cli(
      const SuccessfulRunner(),
    ).run(['create', '../Unsafe']);

    expect(exitCode, 64);
    expect(await sandbox.list().toList(), isEmpty);
  });

  test(
    'creates an Android and iOS project from the application template',
    () async {
      final exitCode = await cli(
        const SuccessfulRunner(),
      ).run(['create', 'sample_app']);
      final project = Directory('${sandbox.path}/sample_app');

      expect(exitCode, 0);
      expect(
        await File(
          '${project.path}/lib/features/home/presentation/home_screen.dart',
        ).exists(),
        isTrue,
      );
      expect(await File('${project.path}/AGENTS.md').exists(), isTrue);
    },
  );

  test(
    'does not expose a partial project when dependency resolution fails',
    () async {
      final exitCode = await cli(
        const FailingPubGetRunner(),
      ).run(['create', 'sample_app']);

      expect(exitCode, 64);
      expect(await Directory('${sandbox.path}/sample_app').exists(), isFalse);
    },
  );

  test('adds a feature atomically', () async {
    await File(
      '${sandbox.path}/pubspec.yaml',
    ).writeAsString('name: sample_app\n');

    final exitCode = await cli(
      const SuccessfulRunner(),
    ).run(['add', 'feature', 'profile']);

    expect(exitCode, 0);
    expect(
      await File(
        '${sandbox.path}/lib/features/profile/presentation/profile_screen.dart',
      ).exists(),
      isTrue,
    );
  });

  test('adds a serializable model', () async {
    await File(
      '${sandbox.path}/pubspec.yaml',
    ).writeAsString('name: sample_app\n');
    await Directory(
      '${sandbox.path}/lib/features/profile',
    ).create(recursive: true);

    final exitCode = await cli(
      const SuccessfulRunner(),
    ).run(['add', 'model', 'profile', 'user_profile']);

    expect(exitCode, 0);
    expect(
      await File(
        '${sandbox.path}/lib/features/profile/domain/models/user_profile.dart',
      ).readAsString(),
      contains('class UserProfile'),
    );
  });

  test('refuses to overwrite an existing feature', () async {
    await File(
      '${sandbox.path}/pubspec.yaml',
    ).writeAsString('name: sample_app\n');
    await Directory(
      '${sandbox.path}/lib/features/profile',
    ).create(recursive: true);

    final exitCode = await cli(
      const SuccessfulRunner(),
    ).run(['add', 'feature', 'profile']);

    expect(exitCode, 1);
    expect(errors.single, contains('Feature already exists'));
  });
}

final class SuccessfulRunner implements ProcessRunner {
  const SuccessfulRunner();

  @override
  Future<ProcessOutput> run(
    String executable,
    List<String> arguments, {
    String? workingDirectory,
  }) async {
    if (executable == 'flutter' && arguments.first == 'create') {
      final root = Directory(arguments.last);
      await File(
        '${root.path}/android/app/build.gradle.kts',
      ).create(recursive: true);
      await File(
        '${root.path}/android/app/build.gradle.kts',
      ).writeAsString('android {\n    buildTypes {\n    }\n}\n');
      await File(
        '${root.path}/ios/Runner.xcodeproj/project.pbxproj',
      ).create(recursive: true);
      await File(
        '${root.path}/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme',
      ).create(recursive: true);
      await File(
        '${root.path}/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme',
      ).writeAsString(
        '<Scheme><LaunchAction buildConfiguration = "Debug" />'
        '<ArchiveAction buildConfiguration = "Release" /></Scheme>',
      );
      await File(
        '${root.path}/pubspec.yaml',
      ).writeAsString('name: placeholder\n');
      await File('${root.path}/test/widget_test.dart').create(recursive: true);
    }
    return const ProcessOutput(exitCode: 0, stdout: 'ok', stderr: '');
  }
}

final class FailingPubGetRunner implements ProcessRunner {
  const FailingPubGetRunner();

  @override
  Future<ProcessOutput> run(
    String executable,
    List<String> arguments, {
    String? workingDirectory,
  }) async {
    if (executable == 'flutter' && arguments.first == 'create') {
      final root = Directory(arguments.last);
      await root.create(recursive: true);
      await File(
        '${root.path}/android/app/build.gradle.kts',
      ).create(recursive: true);
      await File(
        '${root.path}/android/app/build.gradle.kts',
      ).writeAsString('android {\n    buildTypes {\n    }\n}\n');
      await File(
        '${root.path}/ios/Runner.xcodeproj/project.pbxproj',
      ).create(recursive: true);
      await File(
        '${root.path}/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme',
      ).create(recursive: true);
      await File(
        '${root.path}/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme',
      ).writeAsString(
        '<Scheme><LaunchAction buildConfiguration = "Debug" />'
        '<ArchiveAction buildConfiguration = "Release" /></Scheme>',
      );
      await File(
        '${root.path}/pubspec.yaml',
      ).writeAsString('name: placeholder\n');
      return const ProcessOutput(exitCode: 0, stdout: 'created', stderr: '');
    }
    return const ProcessOutput(exitCode: 1, stdout: '', stderr: 'offline');
  }
}
