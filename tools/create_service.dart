// ignore_for_file: avoid_print
import 'dart:io';

/// Generates a new injectable service.
///
/// Usage: dart run tools/create_service.dart --name "Payment"
Future<void> main(List<String> args) async {
  final name = _getArg(args, '--name');
  if (name == null) {
    print('Usage: dart run tools/create_service.dart --name "Payment"');
    exit(1);
  }

  final snakeName = _toSnakeCase(name);
  final pascalName = _toPascalCase(name);
  final filePath = 'lib/app/services/${snakeName}_service.dart';

  if (File(filePath).existsSync()) {
    print('Error: $filePath already exists.');
    exit(1);
  }

  final content = """import 'package:injectable/injectable.dart';
import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/logging/log.dart';

/// ${pascalName} service.
///
/// Access via DI: `getIt<${pascalName}Service>()`
@injectable
class ${pascalName}Service {
  /// Example method returning a Result type.
  Future<Result<String>> doSomething() async {
    try {
      // TODO: Implement
      Log.info('${pascalName}Service.doSomething called');
      return const Result.success('done');
    } catch (e, s) {
      Log.error('${pascalName}Service.doSomething failed', error: e, stackTrace: s);
      return Result.failure(ServerException(e.toString()));
    }
  }
}
""";

  File(filePath).writeAsStringSync(content);
  print('Created: $filePath');
  print('');
  print('Next steps:');
  print('  1. Run: dart run build_runner build --delete-conflicting-outputs');
  print('  2. Use: final service = getIt<${pascalName}Service>();');
}

String? _getArg(List<String> args, String flag) {
  final idx = args.indexOf(flag);
  if (idx == -1 || idx + 1 >= args.length) return null;
  return args[idx + 1];
}

String _toSnakeCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
      .replaceAll(RegExp(r'([A-Z])'), r'_$1')
      .toLowerCase()
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
}

String _toPascalCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map((s) => s[0].toUpperCase() + s.substring(1).toLowerCase())
      .join();
}
