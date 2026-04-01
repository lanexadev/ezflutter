# EzFlutter V2 — Copilot Instructions

## Architecture
- `lib/core/` = Framework layer. Do not modify unless asked.
- `lib/app/` = Application layer. This is where developers work.

## Ez* System (prefer over raw Flutter)
- List pages: extend `EzListPage<T>` or `EzPaginatedListPage<T>`
- Detail pages: extend `EzDetailPage<T>`
- Form pages: extend `EzFormPage`
- Settings pages: extend `EzSettingsPage`
- Tabbed pages: extend `EzTabPage`
- Fields: `EzField.text()`, `.email()`, `.password()`, `.currency()`, `.select()`, `.toggle()`, `.date()`
- Services: extend `EzService`, use `guard()` for auto Result wrapping
- List items: use `EzTile`

## Patterns
- Models: `@freezed` + `abstract class` in `lib/app/models/`
- Services: `@injectable` + `extends EzService` in `lib/app/services/`
- Providers: `@riverpod` in `lib/app/providers/`
- API: `@RestApi()` with Retrofit in `lib/app/services/api/`
- Errors: return `Result<T>`, never throw
- State: Riverpod 3.x, `ref.watch()` in widgets
- DI: `getIt<Service>()` to access

## After code-gen files
Run: `dart run build_runner build --delete-conflicting-outputs`
