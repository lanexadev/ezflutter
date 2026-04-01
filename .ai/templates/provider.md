# Provider Template

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{name}_provider.g.dart';

@riverpod
class {Name} extends _${Name} {
  @override
  {StateType} build() {
    // Initial state
    return initialValue;
  }

  void doSomething() {
    state = newValue;
  }
}
```

## Rules
- File: `lib/app/providers/{name}_provider.dart`
- Use `@riverpod` for auto-dispose or `@Riverpod(keepAlive: true)` for persistent
- Always add `part '{name}_provider.g.dart';`
- Run `dart run build_runner build --delete-conflicting-outputs` after
- Access: `ref.watch({name}Provider)` in widgets
