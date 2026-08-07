# start_dart

Small, code-generation-free reliability primitives for Flutter applications: typed results and failures, async state, pagination, validation, and retry policies.

```dart
import 'package:start_dart/start_dart.dart';

final Result<int> result = Result.success(42);
final doubled = result.map((value) => value * 2);
```

START.DART targets Android and iOS applications built with Flutter 3.41 or later. See the [main repository](https://github.com/lucasschimmel/start-dart) for architecture and contribution guidance.
