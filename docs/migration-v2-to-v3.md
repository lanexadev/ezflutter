# Migrating from EzFlutter V2 to START.DART V3

Version 3 is a product redesign, not an in-place dependency upgrade. The safest migration is to generate a fresh START.DART application and move product features one vertical slice at a time.

## Recommended path

1. Create a branch from the working V2 application and preserve its tests.
2. Install the `start_dart_cli` package and run `startdart doctor`.
3. Generate a new application with `startdart create <name> --org <domain>`.
4. Move pure models and domain rules first, without importing V2 framework types.
5. Recreate repository contracts in each feature's `domain` directory and infrastructure implementations in `data`.
6. Move screens into `presentation`, exposing state through view models.
7. Port tests alongside each feature and compare observable behavior before removing the V2 implementation.
8. Configure Android and iOS signing outside the repository, then validate every environment entrypoint.

## Important changes

- Package imports now use `package:start_dart/start_dart.dart`.
- The CLI command is `startdart`.
- Generated projects use feature-first MVVM rather than the V2 generated-code architecture.
- Web and desktop targets are intentionally not generated.
- `AGENTS.md` is the universal entry point for coding agents; vendor files only redirect to it.

There is no automatic source migration because V2 applications can contain generated and application-specific coupling that cannot be transformed safely without product context.
