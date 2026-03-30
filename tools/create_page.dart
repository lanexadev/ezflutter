// ignore_for_file: avoid_print
import 'dart:io';

/// Generates a new page with auto_route annotation.
///
/// Usage: dart run tools/create_page.dart --name "Profile"
Future<void> main(List<String> args) async {
  final name = _getArg(args, '--name');
  if (name == null) {
    print('Usage: dart run tools/create_page.dart --name "Profile"');
    exit(1);
  }

  final snakeName = _toSnakeCase(name);
  final pascalName = _toPascalCase(name);
  final filePath = 'lib/app/pages/${snakeName}_page.dart';

  if (File(filePath).existsSync()) {
    print('Error: $filePath already exists.');
    exit(1);
  }

  final content = """import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${pascalName}Page extends ConsumerWidget {
  const ${pascalName}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('$pascalName')),
      body: const Center(
        child: Text('$pascalName Page'),
      ),
    );
  }
}
""";

  File(filePath).writeAsStringSync(content);
  print('Created: $filePath');
  print('');
  print('Next steps:');
  print('  1. Add route in lib/core/router/app_router.dart:');
  print('     AutoRoute(page: ${pascalName}Route.page),');
  print('  2. Run: dart run build_runner build --delete-conflicting-outputs');
}

String? _getArg(List<String> args, String flag) {
  final idx = args.indexOf(flag);
  if (idx == -1 || idx + 1 >= args.length) return null;
  return args[idx + 1];
}

String _toSnakeCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
      .replaceAll(RegExp(r'([A-Z])'), r'_$1')
      .toLowerCase()
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
}

String _toPascalCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map((s) => s[0].toUpperCase() + s.substring(1).toLowerCase())
      .join();
}
