---
name: create-app
description: Create and verify a new Android/iOS Nativiq Flutter application with the non-interactive CLI. Use when asked to scaffold, bootstrap, initialize, or smoke-test a generated Nativiq app.
---

# Create a Nativiq app

1. Read `AGENTS.md`, `.agents/rules/security.md`, and `.agents/rules/dart-flutter.md`.
2. Inspect CLI help before choosing flags; never assume unpublished options.
3. Validate the application name, organization identifier, destination, and selected environment values before writing.
4. Generate into a new or empty destination. Never overwrite a non-empty directory.
5. Confirm the output contains `android/` and `ios/`, and no web or desktop platform directories.
6. Run `.agents/hooks/check-generated-project.sh <destination>` to verify platforms, dependency resolution, formatting, analysis, and tests.
7. Report the exact destination, checks run, and any placeholder values the developer must replace.

For expected output and failure invariants, read [references/generation-contract.md](references/generation-contract.md).
