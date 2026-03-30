// ignore_for_file: avoid_print
import 'dart:io';

/// Generates a new page using the Ez* system.
///
/// Usage:
///   dart run tools/create_page.dart --name "Profile"
///   dart run tools/create_page.dart --name "Products" --type list
///   dart run tools/create_page.dart --name "CreateProduct" --type form
///   dart run tools/create_page.dart --name "AppSettings" --type settings
Future<void> main(List<String> args) async {
  final name = _getArg(args, '--name');
  final type = _getArg(args, '--type') ?? 'simple';

  if (name == null) {
    print('Usage: dart run tools/create_page.dart --name "Profile" [--type list|form|settings|simple]');
    print('');
    print('Types:');
    print('  simple    ConsumerWidget with Scaffold (default)');
    print('  list      EzListPage with loading/error/empty/refresh');
    print('  form      EzFormPage with fields and validation');
    print('  settings  EzSettingsPage with sections');
    exit(1);
  }

  final snakeName = _toSnakeCase(name);
  final pascalName = _toPascalCase(name);
  final filePath = 'lib/app/pages/${snakeName}_page.dart';

  if (File(filePath).existsSync()) {
    print('Error: $filePath already exists.');
    exit(1);
  }

  final content = switch (type) {
    'list' => _listTemplate(pascalName),
    'form' => _formTemplate(pascalName),
    'settings' => _settingsTemplate(pascalName),
    _ => _simpleTemplate(pascalName),
  };

  File(filePath).writeAsStringSync(content);
  print('Created: $filePath (type: $type)');
  print('');
  print('Next steps:');
  print('  1. Add route in lib/core/router/app_router.dart:');
  print('     AutoRoute(page: ${pascalName}Route.page),');
  print('  2. Run: dart run build_runner build --delete-conflicting-outputs');
}

String _simpleTemplate(String name) => """import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${name}Page extends ConsumerWidget {
  const ${name}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: const Center(
        child: Text('$name Page'),
      ),
    );
  }
}
""";

String _listTemplate(String name) => """import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_list_page.dart';
import 'package:ezflutter/core/ez/ez_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${name}Page extends EzListPage<dynamic> {
  const ${name}Page({super.key});

  @override
  String get title => '$name';

  @override
  AsyncValue<List<dynamic>> watchData(WidgetRef ref) {
    // TODO: Replace with your provider
    // return ref.watch(${name.toLowerCase()}sProvider);
    return const AsyncValue.data([]);
  }

  @override
  void invalidateData(WidgetRef ref) {
    // TODO: Replace with your provider
    // ref.invalidate(${name.toLowerCase()}sProvider);
  }

  @override
  Widget buildItem(BuildContext context, dynamic item) {
    return EzTile(
      title: item.toString(),
      // TODO: Customize with your model fields
    );
  }
}
""";

String _formTemplate(String name) => """import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:ezflutter/core/ez/ez_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${name}Page extends EzFormPage {
  const ${name}Page({super.key});

  @override
  String get title => '$name';

  @override
  String get submitLabel => 'Submit';

  @override
  List<EzField> get fields => [
        EzField.text('name', label: 'Name', required: true),
        // TODO: Add your fields here
      ];

  @override
  Future<void> Function(Map<String, dynamic> data) get onSubmit =>
      (data) async {
        // TODO: Handle form submission
      };
}
""";

String _settingsTemplate(String name) => """import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${name}Page extends EzSettingsPage {
  const ${name}Page({super.key});

  @override
  String get title => '$name';

  @override
  List<EzSection> get sections => [
        EzSection('General', [
          EzSetting.action(
            label: 'Example',
            icon: Icons.settings,
            onTap: () {
              // TODO: Handle tap
            },
          ),
        ]),
      ];
}
""";

String? _getArg(List<String> args, String flag) {
  final idx = args.indexOf(flag);
  if (idx == -1 || idx + 1 >= args.length) return null;
  return args[idx + 1];
}

String _toSnakeCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
      .replaceAll(RegExp(r'([A-Z])'), r'_\$1')
      .toLowerCase()
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_\$'), '');
}

String _toPascalCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map((s) => s[0].toUpperCase() + s.substring(1).toLowerCase())
      .join();
}
