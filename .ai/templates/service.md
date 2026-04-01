# Service Template

Services extend `EzService` which provides `guard()` for automatic Result wrapping.

```dart
import 'package:injectable/injectable.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/ez/ez_service.dart';

@injectable
class {Name}Service extends EzService {
  // guard() auto-wraps in Result with try/catch + logging
  Future<Result<{Type}>> fetchData() => guard(() async {
    // Your logic here — just return the data, no try/catch needed
    return data;
  });

  Future<Result<void>> saveData({Type} data) => guard(() async {
    // Save logic
  });
}
```

## Rules
- File: `lib/app/services/{name}_service.dart`
- Always extend `EzService` (provides guard())
- Always use `@injectable` annotation
- Use `guard()` instead of manual try/catch — it handles Result wrapping, logging, and error mapping
- Access via `getIt<{Name}Service>()`

## CLI
```bash
dart run tools/create_service.dart --name "Payment"
```
