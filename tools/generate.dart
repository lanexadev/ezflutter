// ignore_for_file: avoid_print
import 'dart:io';

/// Runs all code generators (build_runner + slang).
///
/// Usage: dart run tools/generate.dart
Future<void> main() async {
  print('Running build_runner...');
  final buildRunner = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );
  stdout.write(buildRunner.stdout);
  stderr.write(buildRunner.stderr);

  print('\nRunning slang...');
  final slang = await Process.run(
    'dart',
    ['run', 'slang'],
    runInShell: true,
  );
  stdout.write(slang.stdout);
  stderr.write(slang.stderr);

  if (buildRunner.exitCode == 0 && slang.exitCode == 0) {
    print('\nCode generation complete.');
  } else {
    print('\nCode generation failed.');
    exit(1);
  }
}
