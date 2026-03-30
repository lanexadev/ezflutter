// ignore_for_file: avoid_print
import 'dart:io';

/// Updates dependencies, regenerates code, and runs tests.
///
/// Usage: dart run tools/update.dart
Future<void> main() async {
  print('Updating EzFlutter...\n');

  print('1/4 Updating dependencies...');
  final upgrade = await Process.run('flutter', ['pub', 'upgrade'], runInShell: true);
  stdout.write(upgrade.stdout);
  if (upgrade.exitCode != 0) {
    stderr.write(upgrade.stderr);
    print('Failed to upgrade dependencies.');
    exit(1);
  }

  print('\n2/4 Regenerating code...');
  final gen = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );
  stdout.write(gen.stdout);
  if (gen.exitCode != 0) {
    stderr.write(gen.stderr);
    print('Code generation failed.');
    exit(1);
  }

  print('\n3/4 Generating translations...');
  final slang = await Process.run('dart', ['run', 'slang'], runInShell: true);
  stdout.write(slang.stdout);

  print('\n4/4 Running tests...');
  final test = await Process.run('flutter', ['test'], runInShell: true);
  stdout.write(test.stdout);
  if (test.exitCode != 0) {
    stderr.write(test.stderr);
    print('\nTests failed!');
    exit(1);
  }

  print('\nUpdate complete!');
}
