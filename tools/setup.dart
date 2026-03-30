// ignore_for_file: avoid_print
import 'dart:io';

/// Initial project setup.
///
/// Usage: dart run tools/setup.dart
Future<void> main() async {
  print('Setting up EzFlutter V2...\n');

  print('1/3 Installing dependencies...');
  final pubGet = await Process.run(
    'flutter',
    ['pub', 'get'],
    runInShell: true,
  );
  if (pubGet.exitCode != 0) {
    stderr.write(pubGet.stderr);
    exit(1);
  }
  print('    Dependencies installed.');

  print('2/3 Running code generation...');
  final buildRunner = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );
  if (buildRunner.exitCode != 0) {
    stderr.write(buildRunner.stderr);
    exit(1);
  }
  print('    Code generated.');

  print('3/3 Generating translations...');
  final slang = await Process.run(
    'dart',
    ['run', 'slang'],
    runInShell: true,
  );
  if (slang.exitCode != 0) {
    stderr.write(slang.stderr);
  }
  print('    Translations generated.');

  print('\nSetup complete! Run: flutter run --dart-define-from-file=config/dev.json');
}
