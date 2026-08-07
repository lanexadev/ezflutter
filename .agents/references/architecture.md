# Feature-first MVVM reference

```text
lib/
  app/
    app.dart
    composition_root.dart
  features/<feature>/
    view/<feature>_view.dart
    view_model/<feature>_view_model.dart
    repository/<feature>_repository.dart
    service/<feature>_service.dart
    model/<feature>_model.dart
  shared/
```

Views render immutable state and send intents. View models coordinate use cases and expose async state. Repositories own domain-facing data operations and translate infrastructure failures. Services wrap external SDKs, persistence, and transport. Models do not import UI libraries unless they are explicitly presentation models.

Dependency wiring belongs in the composition root so tests can replace repositories and services without global state.
