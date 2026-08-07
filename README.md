# Nativiq

Nativiq is an AI-native system for creating production-minded Flutter apps. It combines a deterministic CLI, a small framework, an opinionated feature-first template, and one universal agent contract.

> V3 is a complete, breaking successor to EzFlutter. It targets Android and iOS only.

## Five-minute start

```bash
dart pub global activate nativiq_cli
nativiq doctor
nativiq create my_app
cd my_app
flutter run --target lib/main_dev.dart --dart-define=APP_ENV=dev
```

For repository development:

```bash
dart pub get
dart run packages/nativiq_cli/bin/nativiq.dart doctor
dart run packages/nativiq_cli/bin/nativiq.dart create sandbox_app
```

## What V3 contains

- `nativiq create`: reproducible, non-interactive app generation.
- `nativiq add feature|model`: architecture-aware scaffolding.
- `nativiq doctor`: actionable environment diagnostics.
- `package:nativiq`: typed results, failures, validation, async state, pagination, and retry primitives.
- `template/`: feature-first MVVM starter with environments and tests.
- `AGENTS.md` + `.agents/`: canonical guidance, skills, rules, hooks, and references shared by AI coding tools.
- Thin adapters for Codex, Claude Code, Cursor, GitHub Copilot, and Gemini.

## Architecture

Generated applications organize code by product feature. A feature owns its view, view model, domain contracts, data repository, and services. Cross-cutting code stays in `core`; reusable UI stays in `shared`.

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

The dependency direction is `view → view model → repository → service`. See [Architecture](docs/architecture.md) for the complete contract.

## AI-native, not AI-dependent

Every generated repository is understandable and maintainable without an AI tool. When an agent is used, `AGENTS.md` gives it the same architecture, quality, security, and delivery contract. Specialized repeatable work lives in `.agents/skills`; vendor adapters only route to that source.

## Documentation

- [Getting started](docs/getting-started.md)
- [Architecture](docs/architecture.md)
- [AI workflow](docs/ai-workflow.md)
- [CLI reference](docs/cli.md)
- [Migrating from EzFlutter V2](docs/migration-v2-to-v3.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)

## Status

Nativiq V3 is developed on `develop`. Package publication and the repository rename are separate release operations after validation.

MIT © Lucas Schimmel
