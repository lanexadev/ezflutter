// ignore_for_file: avoid_print
import 'dart:io';

/// Cleans generated files and rebuilds.
///
/// Usage: dart run tools/clean.dart
Future<void> main() async {
  print('Cleaning generated files...');

  // Delete generated files
  final patterns = ['*.g.dart', '*.freezed.dart', '*.gr.dart', '*.config.dart'];
  for (final pattern in patterns) {
    final result = await Process.run(
      'find',
      ['lib', '-name', pattern, '-delete'],
      runInShell: true,
    );
    if (result.exitCode != 0) {
      // Windows fallback
      await Process.run(
        'cmd',
        ['/c', 'del', '/s', '/q', 'lib\\$pattern'],
        runInShell: true,
      );
    }
  }

  print('Running flutter clean...');
  await Process.run('flutter', ['clean'], runInShell: true);

  print('Getting dependencies...');
  await Process.run('flutter', ['pub', 'get'], runInShell: true);

  print('Regenerating code...');
  final gen = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );
  stdout.write(gen.stdout);
  stderr.write(gen.stderr);

  print('\nClean complete.');
}
