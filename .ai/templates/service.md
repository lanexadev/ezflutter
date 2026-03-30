# Service Template

```dart
import 'package:injectable/injectable.dart';
import 'package:ezflutter/core/error/app_exception.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/logging/log.dart';

@injectable
class {Name}Service {
  Future<Result<{ReturnType}>> {methodName}() async {
    try {
      // Implementation here
      return const Result.success(data);
    } catch (e, s) {
      Log.error('{Name}Service.{methodName} failed', error: e, stackTrace: s);
      return Result.failure(ServerException(e.toString()));
    }
  }
}
```

## Rules
- File: `lib/app/services/{name}_service.dart`
- Always use `@injectable` annotation
- Always return `Result<T>` for operations that can fail
- Never throw exceptions — return `Result.failure()`
- Access via `getIt<{Name}Service>()`
