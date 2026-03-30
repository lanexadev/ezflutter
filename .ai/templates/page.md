# Page Template

When creating a new page, follow this exact pattern:

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class {Name}Page extends ConsumerWidget {
  const {Name}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Name}')),
      body: const Center(
        child: Text('{Name} Page'),
      ),
    );
  }
}
```

## Rules
- File: `lib/app/pages/{name}_page.dart`
- Always use `@RoutePage()` annotation
- Always extend `ConsumerWidget` (or `ConsumerStatefulWidget` if state is needed)
- Add route in `lib/core/router/app_router.dart`
- Run `dart run build_runner build --delete-conflicting-outputs` after
