# Model Template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{name}.freezed.dart';
part '{name}.g.dart';

@freezed
abstract class {Name} with _${Name} {
  const factory {Name}({
    required String id,
    required String name,
    // Add fields here
  }) = _{Name};

  factory {Name}.fromJson(Map<String, dynamic> json) => _${Name}FromJson(json);
}
```

## Rules
- File: `lib/app/models/{name}.dart`
- Always use `@freezed` annotation
- Always add `part` directives for `.freezed.dart` and `.g.dart`
- Use `abstract class` (required by freezed 3.x)
- Run `dart run build_runner build --delete-conflicting-outputs` after
