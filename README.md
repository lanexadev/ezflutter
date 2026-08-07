# START.DART

[![Quality](https://github.com/lucasschimmel/start-dart/actions/workflows/quality.yml/badge.svg)](https://github.com/lucasschimmel/start-dart/actions/workflows/quality.yml)
[![Mobile build](https://github.com/lucasschimmel/start-dart/actions/workflows/build.yml/badge.svg)](https://github.com/lucasschimmel/start-dart/actions/workflows/build.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**The AI-native Flutter app starter.**

START.DART combines a deterministic CLI, production-minded Flutter primitives, an opinionated feature-first template, and a universal agent contract. Generated projects remain understandable without an AI tool and become immediately navigable when one is present.

> Version 3 is a complete, breaking successor to EzFlutter V2. Generated applications target Android and iOS only.

## Start in five minutes

```bash
dart pub global activate start_dart_cli
startdart doctor
startdart create my_app
cd my_app
flutter run --target lib/main_dev.dart --dart-define=APP_ENV=dev
```

Until the packages are available on pub.dev, run the CLI from a clone:

```bash
dart pub get
dart run packages/start_dart_cli/bin/startdart.dart doctor
dart run packages/start_dart_cli/bin/startdart.dart create sandbox_app
```

## What is included

- `startdart create`: reproducible, non-interactive Android/iOS app generation.
- `startdart add feature|model`: architecture-aware scaffolding.
- `startdart doctor`: actionable environment diagnostics with optional JSON output.
- `package:start_dart`: typed results, failures, validation, asynchronous state, pagination, and retry primitives.
- A feature-first MVVM template with development, staging, and production entrypoints.
- Unit, widget, integration, Android, and iOS verification paths.
- `AGENTS.md` and `.agents/`: one provider-neutral contract for coding agents, with reusable rules, skills, hooks, and references.
- Thin adapters for Codex, Claude Code, Cursor, GitHub Copilot, Gemini, and other tools that understand repository instructions.

## Architecture

Generated applications organize code by product feature:

```text
lib/
├── app/
├── core/
├── features/
│   └── example/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── shared/
```

Dependencies flow from presentation to domain contracts and then to data implementations. The framework deliberately avoids imposing a router, networking client, state-management package, backend, or code generator.

## AI-native, not AI-dependent

Every generated repository carries the same engineering contract in `AGENTS.md`. Agents progressively load only the applicable material from `.agents/`, while developers can read and apply the exact same rules. No vendor-specific file contains a second, drifting version of the architecture.

## Repository

```text
packages/start_dart/       Flutter primitives
packages/start_dart_cli/   Generator and scaffolding CLI
template/                  Reference output used by tests
.agents/                   Universal agent system
docs/                      Guides and architecture documentation
```

## Documentation

- [Getting started](docs/getting-started.md)
- [CLI reference](docs/cli.md)
- [Architecture](docs/architecture.md)
- [AI workflow](docs/ai-workflow.md)
- [Migrating from EzFlutter V2](docs/migration-v2-to-v3.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [Changelog](CHANGELOG.md)

## Support and security

Use [GitHub Discussions](https://github.com/lucasschimmel/start-dart/discussions) for questions, [issues](https://github.com/lucasschimmel/start-dart/issues) for reproducible bugs and focused proposals, and private vulnerability reporting for security findings.

START.DART is released under the [MIT License](LICENSE). Copyright © 2026 Lucas Schimmel.
