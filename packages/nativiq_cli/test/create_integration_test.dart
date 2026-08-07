@Tags(['integration'])
library;

import 'dart:io';

import 'package:nativiq_cli/nativiq_cli.dart';
import 'package:test/test.dart';

void main() {
  test(
    'generates a resolvable Flutter application in a temporary directory',
    () async {
      final sandbox = await Directory.systemTemp.createTemp(
        'nativiq_create_integration_',
      );
      final repository = _findRepositoryRoot();
      try {
        final exitCode =
            await NativiqCli(
              workingDirectory: sandbox,
              stdoutWriter: (_) {},
              stderrWriter: (_) {},
            ).run([
              'create',
              'generated_app',
              '--local-framework',
              '${repository.path}/packages/nativiq',
            ]);

        expect(exitCode, 0);
        expect(
          await Directory('${sandbox.path}/generated_app/android').exists(),
          isTrue,
        );
        expect(
          await Directory('${sandbox.path}/generated_app/ios').exists(),
          isTrue,
        );
        expect(
          await File(
            '${sandbox.path}/generated_app/.agents/skills/create-feature/SKILL.md',
          ).exists(),
          isTrue,
        );
        const canonicalFiles = [
          'AGENTS.md',
          '.agents/rules/architecture.md',
          '.agents/rules/testing.md',
          '.agents/skills/create-feature/SKILL.md',
          '.agents/hooks/README.md',
          '.agents/references/architecture.md',
          'lib/main.dart',
          'lib/main_dev.dart',
          'lib/main_staging.dart',
          'lib/bootstrap.dart',
          'lib/app/app.dart',
          'lib/core/config/app_environment.dart',
          'lib/features/home/domain/home_repository.dart',
          'lib/features/home/data/in_memory_home_repository.dart',
          'lib/features/home/presentation/home_view_model.dart',
          'lib/features/home/presentation/home_screen.dart',
        ];
        for (final path in canonicalFiles) {
          final generated = await File(
            '${sandbox.path}/generated_app/$path',
          ).readAsString();
          final canonical = await File(
            '${repository.path}/template/$path',
          ).readAsString();
          expect(generated, canonical, reason: 'Template drift in $path');
        }
        final generatedTests = await Process.run('flutter', [
          'test',
        ], workingDirectory: '${sandbox.path}/generated_app');
        expect(
          generatedTests.exitCode,
          0,
          reason: '${generatedTests.stdout}\n${generatedTests.stderr}',
        );
      } finally {
        if (await sandbox.exists()) await sandbox.delete(recursive: true);
      }
    },
  );
}

Directory _findRepositoryRoot() {
  var candidate = Directory.current.absolute;
  while (candidate.parent.path != candidate.path) {
    if (File('${candidate.path}/packages/nativiq/pubspec.yaml').existsSync()) {
      return candidate;
    }
    candidate = candidate.parent;
  }
  throw StateError('Could not locate the Nativiq workspace root.');
}
