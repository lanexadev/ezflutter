# EzFlutter V2 — Claude Code Instructions

## Architecture
Dual-layer Flutter boilerplate:
- `lib/core/` — Framework layer (system). DO NOT modify unless asked.
- `lib/app/` — Application layer (user zone). This is where you work.

## Ez* System (config-over-code)
EzFlutter provides pre-built page abstractions. **Always prefer Ez* classes over raw Flutter widgets:**

| Class | Use case |
|---|---|
| `EzListPage<T>` | Lists with loading/error/empty/refresh |
| `EzDetailPage<T>` | Detail view from field definitions |
| `EzFormPage` | Forms with auto field rendering + validation |
| `EzSettingsPage` | Settings from sections config |
| `EzField` | Declarative field (text, email, password, number, currency, select, toggle, date) |
| `EzTile` | Pre-styled list tile with avatar/badge helpers |
| `EzService` | Base service with `guard()` for auto Result wrapping |

## Creating Things

### New Page
```bash
dart run tools/create_page.dart --name "Products" --type list
```
Types: `simple`, `list`, `form`, `settings`

Then add route in `lib/core/router/app_router.dart` and run `build_runner`.

### New Service
```bash
dart run tools/create_service.dart --name "Payment"
```
Services extend `EzService`. Use `guard()` instead of try/catch.

### New Model
Use `@freezed` + `abstract class` in `lib/app/models/`. Run `build_runner`.

### New Provider
Use `@riverpod` in `lib/app/providers/`. Run `build_runner`.

## Commands
- `dart run tools/setup.dart` — first-time setup
- `dart run tools/generate.dart` — run code generation
- `dart run build_runner build --delete-conflicting-outputs` — generate code
- `flutter test` — run tests
- `flutter run --dart-define-from-file=config/dev.json` — run in dev mode
- `flutter analyze` — check for lint errors

## Key Patterns
- Errors: Return `Result<T>`, never throw. Use `guard()` in services.
- State: Riverpod 3.x with code generation. `ref.watch()` in widgets.
- DI: get_it + injectable. `getIt<Service>()` to access.
- Navigation: auto_route. `@RoutePage()` on pages.
- Fields: `EzField.text()`, `EzField.email()`, etc. — renders as display OR input.
