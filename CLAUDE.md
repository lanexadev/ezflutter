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
| `EzPaginatedListPage<T>` | Infinite scroll lists |
| `EzDetailPage<T>` | Detail view from field definitions |
| `EzFormPage` | Forms with auto field rendering + validation |
| `EzSettingsPage` | Settings from sections config |
| `EzTabPage` | Tabbed layout from tab definitions |
| `EzField` | Declarative field (text, email, password, number, currency, select, toggle, date) |
| `EzTile` | Pre-styled list tile with avatar/badge helpers |
| `EzService` | Base service with `guard()` for auto Result wrapping |

## CLI Tool

**One command for everything:**
```bash
dart run tools/ez.dart
```

Interactive menu — create pages, services, build, rename, generate code, etc. No flags to remember.

## Creating Things

### Via CLI (recommended)
```bash
dart run tools/ez.dart    # Then choose [1] Create a page, [2] Create a service, etc.
```

### Manually
- Pages: `lib/app/pages/` with `@RoutePage()` + Ez* class
- Models: `lib/app/models/` with `@freezed` + `abstract class`
- Services: `lib/app/services/` with `@injectable` + `extends EzService`
- Providers: `lib/app/providers/` with `@riverpod`
- After adding: run `dart run tools/ez.dart` → [3] Generate code

## Key Patterns
- Errors: Return `Result<T>`, never throw. Use `guard()` in services.
- State: Riverpod 3.x with code generation. `ref.watch()` in widgets.
- DI: get_it + injectable. `getIt<Service>()` to access.
- Navigation: auto_route. `@RoutePage()` on pages.
- Fields: `EzField.text()`, `EzField.email()`, etc. — renders as display OR input.
