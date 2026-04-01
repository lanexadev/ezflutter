# EzFlutter V2 Conventions

## Naming
- Files: snake_case (e.g., `user_service.dart`)
- Classes: PascalCase (e.g., `UserService`)
- Variables/methods: camelCase
- Constants: camelCase (e.g., `defaultTimeout`)
- Providers: camelCase + Provider suffix (auto-generated)

## File Organization
- One class per file (exceptions: small related classes)
- Barrel exports per module (e.g., `auth.dart` exports all auth files)
- Generated files: `*.g.dart`, `*.freezed.dart`, `*.gr.dart`

## Patterns
- DO use Result<T> for operations that can fail
- DO use @freezed for all data models
- DO use @injectable/@singleton for services
- DO use @RoutePage() for all navigable pages
- DO use ConsumerWidget/ConsumerStatefulWidget for Riverpod
- DON'T throw exceptions in services — return Result.failure()
- DON'T access getIt directly in widgets — use providers
- DON'T put business logic in widgets
