# EzFlutter V2

A production-ready Flutter boilerplate with dual-layer architecture — designed for both beginners and experienced developers.

> **Version:** 2.0.0 | **Platforms:** Android, iOS | **Flutter:** 3.41.6+ | **Dart:** 3.11.4+

---

## Quick Start

```bash
git clone https://github.com/lucasschimmel/ezflutter.git
cd ezflutter
dart run tools/ez.dart    # Choose [8] Setup
flutter run --dart-define-from-file=config/dev.json
```

## Architecture

EzFlutter uses a **dual-layer architecture**:

```
lib/
├── core/    # Framework — system layer (experienced devs only)
└── app/     # Application — user layer (everyone)
```

**`core/`** contains all infrastructure: DI, routing, networking, auth, storage, theming, i18n, error handling, logging, connectivity, lifecycle, environment config, and the Ez* page system.

**`app/`** is the only folder beginners work in. Creating pages, models, and services takes just a few lines of configuration.

## The Ez* System

EzFlutter's core differentiator: **write configuration, not Flutter widgets**.

```dart
// Before (raw Flutter) — 50+ lines
@RoutePage()
class ProductsPage extends ConsumerWidget {
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(...),
      body: ref.watch(provider).when(
        data: (items) => ListView.builder(...),
        loading: () => CircularProgressIndicator(),
        error: (e, _) => Text(e.toString()),
      ),
    );
  }
}

// After (Ez*) — 15 lines
@RoutePage()
class ProductsPage extends EzListPage<Product> {
  const ProductsPage({super.key});

  @override
  String get title => 'Products';
  @override
  AsyncValue<List<Product>> watchData(WidgetRef ref) => ref.watch(productsProvider);
  @override
  void invalidateData(WidgetRef ref) => ref.invalidate(productsProvider);
  @override
  Widget buildItem(BuildContext context, Product item) =>
      EzTile(title: item.name, subtitle: '\$${item.price}');
}
```

### Available Ez* Classes

| Class | Use case |
|---|---|
| `EzListPage<T>` | Lists with loading/error/empty/pull-to-refresh |
| `EzPaginatedListPage<T>` | Infinite scroll lists |
| `EzDetailPage<T>` | Detail view from field definitions |
| `EzFormPage` | Forms with auto field rendering + validation |
| `EzSettingsPage` | Settings from declarative sections |
| `EzTabPage` | Tabbed layout from tab definitions |
| `EzField` | Declarative field (text, email, password, number, currency, select, toggle, date) |
| `EzTile` | Pre-styled list tile with avatar/badge helpers |
| `EzService` | Base service with `guard()` for auto Result wrapping |

## Features

| Feature | Package | Description |
|---|---|---|
| State Management | Riverpod 3.x | Compile-time safe, auto-dispose, code-gen |
| Routing | auto_route 11.x | Type-safe, guards, deep linking |
| DI | get_it + injectable | Code-generated service registration |
| Networking | Dio + Retrofit | Auth interceptor, retry, error handling, logging |
| Models | Freezed | Immutable, copyWith, JSON serialization |
| Theming | FlexColorScheme | Material 3, light/dark/system from 1 seed color |
| i18n | Slang | Type-safe translations (EN/FR included) |
| Auth | JWT + SecureStorage | Token management, auto-refresh ready |
| Storage | SharedPrefs + SecureStorage | Settings + secure data |
| Connectivity | connectivity_plus | Real-time monitoring + offline banner |
| Error Handling | Result\<T\> + AppException | No exceptions, pattern matching |
| Logging | Logger | Environment-aware levels (dev/staging/prod) |
| Testing | mocktail | Mocks + example tests |
| CI/CD | GitHub Actions | Quality gate + build + release pipelines |
| AI Skills | CLAUDE.md + .ai/ | AI-friendly project navigation |

## Project Structure

```
ezflutter/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── main_dev.dart                # Dev flavor
│   ├── main_staging.dart            # Staging flavor
│   ├── main_prod.dart               # Production flavor
│   ├── core/                        # Framework layer
│   │   ├── auth/                    # Auth service, provider, guard
│   │   ├── connectivity/            # Network monitoring + banner
│   │   ├── di/                      # get_it + injectable
│   │   ├── env/                     # Environment config
│   │   ├── error/                   # AppException + Result<T> + ErrorBoundary
│   │   ├── extensions/              # BuildContext, String, DateTime helpers
│   │   ├── ez/                      # Ez* declarative page system
│   │   ├── i18n/                    # Slang translations
│   │   ├── lifecycle/               # App lifecycle observer
│   │   ├── logging/                 # Logger facade
│   │   ├── models/                  # System models (User, AuthToken)
│   │   ├── network/                 # Dio + interceptors (auth, retry, error, log)
│   │   ├── notifications/           # Local + push (stub, ready for implementation)
│   │   ├── responsive/              # Breakpoints + ResponsiveBuilder
│   │   ├── router/                  # auto_route config
│   │   ├── storage/                 # Settings + SecureStorage
│   │   ├── theme/                   # FlexColorScheme + ThemeMode provider
│   │   └── utils/                   # Debouncer, Validators
│   └── app/                         # Application layer
│       ├── config.dart              # Seed color + app name (1 file to edit)
│       ├── pages/                   # Your pages
│       ├── widgets/                 # Loading, Empty, Error, AsyncValue
│       ├── models/                  # Your Freezed data models
│       ├── services/                # Your EzService business services
│       └── providers/               # Your Riverpod providers
├── tools/
│   └── ez.dart                      # Interactive CLI (replaces 8 scripts)
├── example/                         # EzShop showcase app
├── config/                          # dev.json, staging.json, prod.json
├── assets/locales/                  # Translation files (EN/FR)
├── .ai/                             # AI assistant templates
├── .github/workflows/               # CI/CD (quality, build, release)
├── .vscode/                         # VS Code snippets (9 Ez* snippets)
├── fastlane/                        # App Store / Play Store deployment
└── test/                            # Unit + widget tests
```

## CLI Tool

**One command for everything:**

```bash
dart run tools/ez.dart
```

Interactive menu — no flags or arguments to remember:

```
┌──────────────────────────────────────┐
│          EzFlutter CLI v2.0          │
├──────────────────────────────────────┤
│  [1] Create a page                   │
│  [2] Create a service                │
│  [3] Generate code                   │
│  [4] Clean & rebuild                 │
│  [5] Build app                       │
│  [6] Rename project                  │
│  [7] Update dependencies             │
│  [8] Setup (first time)              │
│  [0] Exit                            │
└──────────────────────────────────────┘
```

## Getting Started

### Prerequisites
- Flutter 3.41.6+ (stable channel)
- Dart 3.11.4+
- Android Studio or VS Code with Flutter extension

### Setup
```bash
git clone https://github.com/lucasschimmel/ezflutter.git
cd ezflutter
dart run tools/ez.dart    # Choose [8] Setup
```

### Run
```bash
flutter run --dart-define-from-file=config/dev.json
```

### Customize
Edit `lib/app/config.dart` — change the seed color and app name:
```dart
class AppConfig {
  static const Color seedColor = Color(0xFF6750A4);  // Change this
  static const String appName = 'My App';              // And this
}
```
The entire theme (light + dark) adapts automatically.

## Environments

| Env | Config | Logging | Debug Banner |
|---|---|---|---|
| dev | `config/dev.json` | Verbose | Yes |
| staging | `config/staging.json` | Info + errors | No |
| prod | `config/prod.json` | Errors only | No |

## VS Code Snippets

Type these in any `.dart` file:

| Snippet | Generates |
|---|---|
| `ezpage` | Simple page (ConsumerWidget) |
| `ezlist` | EzListPage with loading/error/empty |
| `ezdetail` | EzDetailPage with fields |
| `ezform` | EzFormPage with validation |
| `ezsettings` | EzSettingsPage with sections |
| `eztab` | EzTabPage with tabs |
| `ezmodel` | Freezed data model |
| `ezservice` | EzService with guard() |
| `ezprovider` | Riverpod provider |

## Example App

The `example/` folder contains **EzShop**, a complete product catalog demonstrating every Ez* feature:
- Product list (EzListPage + search)
- Product detail (EzDetailPage + hero image)
- Add product form (EzFormPage with 6 field types)
- Shopping cart with quantities
- Settings (EzSettingsPage)
- Auth flow, theming, i18n (EN/FR)

## Testing

```bash
flutter test                    # All tests
flutter test --coverage         # With coverage
```

## Build

```bash
dart run tools/ez.dart    # Choose [5] Build app → guided prompts
```

Or directly:
```bash
flutter build apk --release --split-per-abi --dart-define-from-file=config/prod.json
flutter build appbundle --release --dart-define-from-file=config/prod.json
```

## Contributing

1. Fork the repo
2. Create a feature branch from `develop`
3. Commit with conventional commits
4. Open a PR against `develop`

## License

MIT License — see [LICENSE](LICENSE)

---

Made with Flutter by [lucasschimmel](https://github.com/lucasschimmel)
