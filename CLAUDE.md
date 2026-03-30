# EzFlutter V2 — Claude Code Instructions

## Architecture
This is a dual-layer Flutter boilerplate:
- `lib/core/` — Framework layer (system). Contains DI, routing, networking, auth, storage, theming, i18n, error handling, logging, connectivity, lifecycle, env.
- `lib/app/` — Application layer (user zone). Contains config, pages, widgets, models, services, providers.

## Key Rules
- NEVER modify `lib/core/` unless explicitly asked — it's the framework layer
- New pages go in `lib/app/pages/` with `@RoutePage()` annotation
- New models go in `lib/app/models/` with `@freezed` annotation
- New services go in `lib/app/services/` with `@injectable` annotation
- New providers go in `lib/app/providers/` with `@riverpod` annotation
- After adding code-gen files, run: `dart run build_runner build --delete-conflicting-outputs`

## Commands
- `flutter pub get` — install dependencies
- `dart run build_runner build --delete-conflicting-outputs` — generate code
- `flutter test` — run tests
- `flutter run --dart-define-from-file=config/dev.json` — run in dev mode
- `flutter analyze` — check for lint errors

## State Management
Uses Riverpod 3.x with code generation. Access via `ref.watch(provider)` in ConsumerWidget.

## DI
Uses get_it + injectable. Register services with `@injectable` or `@singleton`. Access via `getIt<Service>()`.

## Navigation
Uses auto_route. Annotate pages with `@RoutePage()`. Add routes in `lib/core/router/app_router.dart`.
