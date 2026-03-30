# EzFlutter V2

A production-ready Flutter boilerplate with dual-layer architecture — designed for both beginners and experienced developers.

> **Version:** 2.0.0 | **Platforms:** Android, iOS | **Flutter:** 3.41.6+ | **Dart:** 3.11.4+

---

## Quick Start

```bash
git clone https://github.com/lanexadev/ezflutter.git
cd ezflutter
dart run tools/setup.dart
flutter run --dart-define-from-file=config/dev.json
```

## Architecture

EzFlutter uses a **dual-layer architecture**:

```
lib/
├── core/    # Framework — system layer (experienced devs)
└── app/     # Application — user layer (all devs)
```

### core/ — Framework Layer
Contains all infrastructure: DI, routing, networking, auth, storage, theming, i18n, error handling, logging, connectivity, lifecycle, environment config.

**Beginners don't touch this.** Experienced devs can modify or extend.

### app/ — Application Layer
The only folder beginners work in. Creating pages, models, services, and providers is simple:

```dart
// Create a page (just 2 things: annotate + add route)
@RoutePage()
class ProfilePage extends ConsumerWidget { ... }

// Create a model
@freezed
abstract class Product with _$Product { ... }

// Create a service
@injectable
class PaymentService { ... }
```

## Features

| Feature | Package | Description |
|---|---|---|
| State Management | Riverpod 3.x | Compile-time safe, auto-dispose |
| Routing | auto_route 11.x | Type-safe, guards, deep linking |
| DI | get_it + injectable | Code-generated service registration |
| Networking | Dio + interceptors | Auth, retry, error handling, logging |
| Models | Freezed | Immutable, copyWith, JSON serialization |
| Theming | FlexColorScheme | Material 3, light/dark/system |
| i18n | Slang | Type-safe translations (EN/FR) |
| Auth | JWT + SecureStorage | Token management, auto-refresh ready |
| Storage | SharedPrefs + SecureStorage | Settings + secure data |
| Connectivity | connectivity_plus | Real-time monitoring + offline banner |
| Error Handling | Result<T> + AppException | No exceptions, pattern matching |
| Logging | Logger | Environment-aware levels |
| Testing | mocktail | Mocks + example tests |
| CI/CD | GitHub Actions | Quality gate + build pipeline |
| AI Skills | CLAUDE.md + .cursorrules | AI-friendly project navigation |

## Project Structure

```
ezflutter/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── main_dev.dart                # Dev entry point
│   ├── main_staging.dart            # Staging entry point
│   ├── main_prod.dart               # Production entry point
│   ├── core/                        # Framework layer
│   │   ├── auth/                    # Auth service, provider, guard
│   │   ├── connectivity/            # Network monitoring
│   │   ├── di/                      # get_it + injectable
│   │   ├── env/                     # Environment config
│   │   ├── error/                   # AppException + Result<T>
│   │   ├── extensions/              # BuildContext, String, DateTime
│   │   ├── i18n/                    # Slang translations
│   │   ├── lifecycle/               # App lifecycle observer
│   │   ├── logging/                 # Logger facade
│   │   ├── models/                  # System models (User, AuthToken)
│   │   ├── network/                 # Dio + interceptors
│   │   ├── notifications/           # Local + push (stub)
│   │   ├── responsive/              # Breakpoints + ResponsiveBuilder
│   │   ├── router/                  # auto_route config
│   │   ├── storage/                 # Settings + SecureStorage
│   │   ├── theme/                   # FlexColorScheme + ThemeMode
│   │   └── utils/                   # Debouncer, Validators
│   └── app/                         # Application layer
│       ├── config.dart              # Seed color + app name
│       ├── pages/                   # HomePage, SettingsPage, LoginPage
│       ├── widgets/                 # Loading, Empty, Error, AsyncValue
│       ├── models/                  # Your data models
│       ├── services/                # Your business services
│       └── providers/               # Your Riverpod providers
├── tools/                           # CLI scripts
├── config/                          # dev.json, staging.json, prod.json
├── assets/locales/                  # Translation files
├── .ai/                             # AI assistant instructions
├── .github/workflows/               # CI/CD
├── test/                            # Tests
└── spec/                            # V2 specification
```

## Getting Started

### Prerequisites
- Flutter 3.41.6+ (stable channel)
- Dart 3.11.4+
- Android Studio or VS Code with Flutter extension

### Setup
```bash
git clone https://github.com/lanexadev/ezflutter.git
cd ezflutter
dart run tools/setup.dart
```

### Run
```bash
# Dev mode
flutter run --dart-define-from-file=config/dev.json

# Prod mode
flutter run --release --dart-define-from-file=config/prod.json
```

### Create a New Page
```bash
dart run tools/create_page.dart --name "Profile"
# Then add route in lib/core/router/app_router.dart
# Then run: dart run build_runner build --delete-conflicting-outputs
```

### Create a New Service
```bash
dart run tools/create_service.dart --name "Payment"
# Then run: dart run build_runner build --delete-conflicting-outputs
```

### Customize the App

Edit `lib/app/config.dart`:
```dart
class AppConfig {
  static const Color seedColor = Color(0xFF6750A4);  // Change this
  static const String appName = 'My App';              // And this
}
```
That's it — the entire theme adapts automatically.

## CLI Tools

| Command | Description |
|---|---|
| `dart run tools/setup.dart` | First-time setup |
| `dart run tools/generate.dart` | Run code generation |
| `dart run tools/clean.dart` | Clean + rebuild |
| `dart run tools/update.dart` | Update deps + regen + test |
| `dart run tools/rename.dart --name "X" --org "com.x"` | Rename project |
| `dart run tools/create_page.dart --name "X"` | Generate a page |
| `dart run tools/create_service.dart --name "X"` | Generate a service |

## Environments

| Env | Config | Logging | Debug Banner |
|---|---|---|---|
| dev | `config/dev.json` | Verbose | Yes |
| staging | `config/staging.json` | Info + errors | No |
| prod | `config/prod.json` | Errors only | No |

## Testing

```bash
flutter test                    # Run all tests
flutter test --coverage         # With coverage
flutter test test/unit/         # Unit tests only
```

## Build

```bash
flutter build apk --release --dart-define-from-file=config/prod.json
flutter build ipa --release --dart-define-from-file=config/prod.json
```

## Contributing

1. Fork the repo
2. Create a feature branch
3. Commit with conventional commits
4. Open a PR against `develop`

## License

MIT License — see [LICENSE](LICENSE)

---

Made with Flutter by [LanexaDev](https://github.com/lanexadev)
