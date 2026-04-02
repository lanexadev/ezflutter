import 'dart:io';

// ─── ANSI Colors ───────────────────────────────────────────────────────────

const _reset = '\x1B[0m';
const _bold = '\x1B[1m';
const _dim = '\x1B[2m';
const _cyan = '\x1B[36m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _red = '\x1B[31m';
const _white = '\x1B[37m';

// ─── Entry Point ───────────────────────────────────────────────────────────

Future<void> main() async {
  while (true) {
    _showMenu();
    final choice = _ask('  Choose [0-8]');

    switch (choice) {
      case '1':
        await _createPage();
      case '2':
        await _createService();
      case '3':
        await _generateCode();
      case '4':
        await _cleanRebuild();
      case '5':
        await _buildApp();
      case '6':
        await _renameProject();
      case '7':
        await _updateDeps();
      case '8':
        await _setup();
      case '0' || 'q' || 'exit':
        _printLn('\n  ${_green}Bye!$_reset\n');
        exit(0);
      default:
        _printLn('  ${_red}Invalid choice.$_reset');
    }

    _printLn('');
    final again = _ask('  Back to menu? [Y/n]');
    if (again.toLowerCase() == 'n') {
      _printLn('\n  ${_green}Bye!$_reset\n');
      exit(0);
    }
  }
}

// ─── Menu ──────────────────────────────────────────────────────────────────

void _showMenu() {
  _printLn('');
  _printLn('  $_cyan$_bold┌──────────────────────────────────────┐$_reset');
  _printLn('  $_cyan$_bold│$_reset        ${_bold}EzFlutter CLI v2.0$_reset          $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold├──────────────────────────────────────┤$_reset');
  _printLn('  $_cyan$_bold│$_reset                                      $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[1]$_reset Create a page                   $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[2]$_reset Create a service                $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[3]$_reset Generate code                   $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[4]$_reset Clean & rebuild                 $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[5]$_reset Build app                       $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[6]$_reset Rename project                  $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[7]$_reset Update dependencies             $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_white[8]$_reset Setup (first time)              $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset  $_dim[0]$_reset ${_dim}Exit$_reset                            $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold│$_reset                                      $_cyan$_bold│$_reset');
  _printLn('  $_cyan$_bold└──────────────────────────────────────┘$_reset');
  _printLn('');
}

// ─── 1. Create Page ────────────────────────────────────────────────────────

Future<void> _createPage() async {
  _header('Create a Page');

  final name = _askRequired('  Page name');
  if (name == null) return;

  _printLn('');
  _printLn('  Page type:');
  _printLn('    $_white[1]$_reset Simple (ConsumerWidget)');
  _printLn('    $_white[2]$_reset List (EzListPage — loading/error/empty/refresh)');
  _printLn('    $_white[3]$_reset Detail (EzDetailPage — field display)');
  _printLn('    $_white[4]$_reset Form (EzFormPage — auto validation)');
  _printLn('    $_white[5]$_reset Settings (EzSettingsPage — sections)');
  _printLn('    $_white[6]$_reset Tabs (EzTabPage — tabbed layout)');
  _printLn('');
  final typeChoice = _ask('  Choose [1-6]');

  final type = switch (typeChoice) {
    '2' => 'list',
    '3' => 'detail',
    '4' => 'form',
    '5' => 'settings',
    '6' => 'tabs',
    _ => 'simple',
  };

  final snakeName = _toSnakeCase(name);
  final pascalName = _toPascalCase(name);
  final filePath = 'lib/app/pages/${snakeName}_page.dart';

  if (File(filePath).existsSync()) {
    _error('$filePath already exists.');
    return;
  }

  final content = _pageTemplate(pascalName, type);
  File(filePath).writeAsStringSync(content);
  _success('Created $filePath');

  _printLn('');
  _printLn('  ${_yellow}Next:$_reset Add route in lib/core/router/app_router.dart:');
  _printLn('        AutoRoute(page: ${pascalName}Route.page),');

  _printLn('');
  final gen = _ask('  Generate code now? [Y/n]');
  if (gen.toLowerCase() != 'n') {
    await _generateCode();
  }
}

// ─── 2. Create Service ─────────────────────────────────────────────────────

Future<void> _createService() async {
  _header('Create a Service');

  final name = _askRequired('  Service name');
  if (name == null) return;

  final snakeName = _toSnakeCase(name);
  final pascalName = _toPascalCase(name);
  final filePath = 'lib/app/services/${snakeName}_service.dart';

  if (File(filePath).existsSync()) {
    _error('$filePath already exists.');
    return;
  }

  final content = """
import 'package:injectable/injectable.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/ez/ez_service.dart';

@injectable
class ${pascalName}Service extends EzService {
  Future<Result<String>> doSomething() => guard(() async {
        // TODO: Implement your logic here
        return 'done';
      });
}
""";

  File(filePath).writeAsStringSync(content);
  _success('Created $filePath');

  _printLn('');
  final gen = _ask('  Generate code now? [Y/n]');
  if (gen.toLowerCase() != 'n') {
    await _generateCode();
  }
}

// ─── 3. Generate Code ──────────────────────────────────────────────────────

Future<void> _generateCode() async {
  _header('Generate Code');

  _step('Running build_runner...');
  final br = await _run('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
  if (br != 0) {
    _error('build_runner failed.');
    return;
  }

  _step('Running slang (translations)...');
  await _run('dart', ['run', 'slang']);

  _success('Code generation complete.');
}

// ─── 4. Clean & Rebuild ────────────────────────────────────────────────────

Future<void> _cleanRebuild() async {
  _header('Clean & Rebuild');

  _step('Deleting generated files...');
  for (final pattern in ['*.g.dart', '*.freezed.dart', '*.gr.dart', '*.config.dart']) {
    _deletePattern('lib', pattern);
  }

  _step('Running flutter clean...');
  await _run('flutter', ['clean']);

  _step('Getting dependencies...');
  await _run('flutter', ['pub', 'get']);

  _step('Regenerating code...');
  await _run('dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);

  _step('Regenerating translations...');
  await _run('dart', ['run', 'slang']);

  _success('Clean & rebuild complete.');
}

// ─── 5. Build App ──────────────────────────────────────────────────────────

Future<void> _buildApp() async {
  _header('Build App');

  _printLn('  Platform:');
  _printLn('    $_white[1]$_reset Android');
  _printLn('    $_white[2]$_reset iOS');
  _printLn('    $_white[3]$_reset Both');
  _printLn('');
  final platformChoice = _ask('  Choose [1-3]');

  final android = platformChoice == '1' || platformChoice == '3';
  final ios = platformChoice == '2' || platformChoice == '3';

  var buildApk = false;
  var buildAab = false;

  if (android) {
    _printLn('');
    _printLn('  Android format:');
    _printLn('    $_white[1]$_reset APK (split per architecture)');
    _printLn('    $_white[2]$_reset App Bundle (Play Store)');
    _printLn('    $_white[3]$_reset Both');
    _printLn('');
    final formatChoice = _ask('  Choose [1-3]');
    buildApk = formatChoice == '1' || formatChoice == '3';
    buildAab = formatChoice == '2' || formatChoice == '3';
  }

  _printLn('');
  _printLn('  Environment:');
  _printLn('    $_white[1]$_reset dev');
  _printLn('    $_white[2]$_reset staging');
  _printLn('    $_white[3]$_reset prod');
  _printLn('');
  final envChoice = _ask('  Choose [1-3]');
  final env = switch (envChoice) {
    '1' => 'dev',
    '2' => 'staging',
    _ => 'prod',
  };
  final configFile = 'config/$env.json';

  if (!File(configFile).existsSync()) {
    _error('$configFile not found.');
    return;
  }

  _printLn('');
  _step('Generating code...');
  await _run('dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);

  if (android && buildApk) {
    _printLn('');
    _step('Building Android APK (arm64, armv7, x86_64)...');
    final code = await _run('flutter', [
      'build', 'apk', '--release', '--split-per-abi',
      '--dart-define-from-file=$configFile',
      '--obfuscate', '--split-debug-info=build/debug-info/android',
    ]);
    if (code != 0) {
      _error('APK build failed.');
    } else {
      _success('APK built.');
      _listOutputFiles('build/app/outputs/flutter-apk/');
    }
  }

  if (android && buildAab) {
    _printLn('');
    _step('Building Android App Bundle...');
    final code = await _run('flutter', [
      'build', 'appbundle', '--release',
      '--dart-define-from-file=$configFile',
      '--obfuscate', '--split-debug-info=build/debug-info/android',
    ]);
    if (code != 0) {
      _error('App Bundle build failed.');
    } else {
      _success('App Bundle built.');
      _listOutputFiles('build/app/outputs/bundle/release/');
    }
  }

  if (ios) {
    if (!Platform.isMacOS) {
      _printLn('');
      _error('iOS build requires macOS. Skipping.');
    } else {
      _printLn('');
      _step('Building iOS...');
      final code = await _run('flutter', [
        'build', 'ipa', '--release',
        '--dart-define-from-file=$configFile',
        '--obfuscate', '--split-debug-info=build/debug-info/ios',
      ]);
      if (code != 0) {
        _error('iOS build failed.');
      } else {
        _success('IPA built.');
        _listOutputFiles('build/ios/ipa/');
      }
    }
  }
}

// ─── 6. Rename Project ─────────────────────────────────────────────────────

Future<void> _renameProject() async {
  _header('Rename Project');

  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    _error('pubspec.yaml not found. Run from project root.');
    return;
  }

  var content = pubspec.readAsStringSync();
  final oldName = RegExp(r'^name:\s*(\S+)', multiLine: true)
          .firstMatch(content)
          ?.group(1) ??
      'ezflutter';

  _printLn('  Current name: $_bold$oldName$_reset');
  _printLn('');

  final name = _ask('  New app name (empty to skip)');
  final org = _ask('  New organization (e.g. com.example, empty to skip)');

  if (name.isEmpty && org.isEmpty) {
    _printLn('  ${_dim}Nothing to change.$_reset');
    return;
  }

  if (name.isNotEmpty) {
    final snakeName = _toSnakeCase(name);
    _step('Renaming package: $oldName -> $snakeName');

    content = content.replaceFirst(
      RegExp(r'^name:\s*\S+', multiLine: true),
      'name: $snakeName',
    );
    pubspec.writeAsStringSync(content);

    var count = 0;
    for (final dir in ['lib', 'test']) {
      for (final file in _dartFiles(dir)) {
        final src = file.readAsStringSync();
        final updated = src.replaceAll('package:$oldName/', 'package:$snakeName/');
        if (src != updated) {
          file.writeAsStringSync(updated);
          count++;
        }
      }
    }
    _success('Updated pubspec.yaml + $count Dart files.');
  }

  if (org.isNotEmpty) {
    final appName = _toSnakeCase(name.isNotEmpty ? name : oldName);
    _step('Updating organization: $org');

    final gradle = File('android/app/build.gradle.kts');
    if (gradle.existsSync()) {
      var g = gradle.readAsStringSync();
      g = g.replaceAll(RegExp(r'namespace\s*=\s*"[^"]*"'), 'namespace = "$org.$appName"');
      g = g.replaceAll(RegExp(r'applicationId\s*=\s*"[^"]*"'), 'applicationId = "$org.$appName"');
      gradle.writeAsStringSync(g);
    }

    final pbxproj = File('ios/Runner.xcodeproj/project.pbxproj');
    if (pbxproj.existsSync()) {
      var p = pbxproj.readAsStringSync();
      p = p.replaceAll(
        RegExp(r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*[^;]+'),
        'PRODUCT_BUNDLE_IDENTIFIER = $org.$appName',
      );
      pbxproj.writeAsStringSync(p);
    }

    _success('Updated Android + iOS bundle identifiers.');
  }

  _printLn('');
  _printLn('  ${_yellow}Run "flutter clean && flutter pub get" to apply.$_reset');
}

// ─── 7. Update Dependencies ────────────────────────────────────────────────

Future<void> _updateDeps() async {
  _header('Update Dependencies');

  _step('Upgrading packages...');
  await _run('flutter', ['pub', 'upgrade']);

  _step('Regenerating code...');
  await _run('dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);

  _step('Regenerating translations...');
  await _run('dart', ['run', 'slang']);

  _step('Running tests...');
  final testCode = await _run('flutter', ['test']);
  if (testCode != 0) {
    _error('Some tests failed! Check output above.');
  } else {
    _success('All tests passed.');
  }

  _success('Update complete.');
}

// ─── 8. Setup ──────────────────────────────────────────────────────────────

Future<void> _setup() async {
  _header('First-Time Setup');

  _step('Installing dependencies...');
  final pubGet = await _run('flutter', ['pub', 'get']);
  if (pubGet != 0) {
    _error('Failed to install dependencies.');
    return;
  }

  _step('Generating code...');
  final br = await _run('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
  if (br != 0) {
    _error('Code generation failed.');
    return;
  }

  _step('Generating translations...');
  await _run('dart', ['run', 'slang']);

  _success('Setup complete!');
  _printLn('');
  _printLn('  Run: ${_bold}flutter run --dart-define-from-file=config/dev.json$_reset');
}

// ─── Page Templates ────────────────────────────────────────────────────────

String _pageTemplate(String name, String type) => switch (type) {
      'list' => _listTemplate(name),
      'detail' => _detailTemplate(name),
      'form' => _formTemplate(name),
      'settings' => _settingsTemplate(name),
      'tabs' => _tabsTemplate(name),
      _ => _simpleTemplate(name),
    };

String _simpleTemplate(String n) => """
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${n}Page extends ConsumerWidget {
  const ${n}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('$n')),
      body: const Center(child: Text('$n Page')),
    );
  }
}
""";

String _listTemplate(String n) => """
import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_list_page.dart';
import 'package:ezflutter/core/ez/ez_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${n}Page extends EzListPage<dynamic> {
  const ${n}Page({super.key});

  @override
  String get title => '$n';

  @override
  AsyncValue<List<dynamic>> watchData(WidgetRef ref) =>
      const AsyncValue.data([]); // TODO: ref.watch(yourProvider)

  @override
  void invalidateData(WidgetRef ref) {} // TODO: ref.invalidate(yourProvider)

  @override
  Widget buildItem(BuildContext context, dynamic item) =>
      EzTile(title: item.toString());
}
""";

String _detailTemplate(String n) => """
import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_detail_page.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${n}Page extends EzDetailPage<dynamic> {
  const ${n}Page({super.key});

  @override
  String get title => '$n';

  @override
  List<EzField> get fields => [
        EzField.text('name', label: 'Name'),
        // TODO: Add your fields
      ];

  @override
  AsyncValue<dynamic> watchData(WidgetRef ref) =>
      const AsyncValue.data(null); // TODO: ref.watch(yourProvider)

  @override
  void invalidateData(WidgetRef ref) {} // TODO: ref.invalidate(yourProvider)
}
""";

String _formTemplate(String n) => """
import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:ezflutter/core/ez/ez_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${n}Page extends EzFormPage {
  const ${n}Page({super.key});

  @override
  String get title => '$n';

  @override
  String get submitLabel => 'Submit';

  @override
  List<EzField> get fields => [
        EzField.text('name', label: 'Name', required: true),
        // TODO: Add your fields
      ];

  @override
  Future<void> Function(Map<String, dynamic> data) get onSubmit =>
      (data) async {
        // TODO: Handle submission
      };
}
""";

String _settingsTemplate(String n) => """
import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${n}Page extends EzSettingsPage {
  const ${n}Page({super.key});

  @override
  String get title => '$n';

  @override
  List<EzSection> get sections => [
        EzSection('General', [
          EzSetting.action(label: 'Example', icon: Icons.settings, onTap: () {}),
        ]),
      ];
}
""";

String _tabsTemplate(String n) => """
import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/ez/ez_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ${n}Page extends EzTabPage {
  const ${n}Page({super.key});

  @override
  String get title => '$n';

  @override
  List<EzTab> get tabs => [
        EzTab(label: 'Tab 1', icon: Icons.home, body: const Center(child: Text('Tab 1'))),
        EzTab(label: 'Tab 2', icon: Icons.list, body: const Center(child: Text('Tab 2'))),
      ];
}
""";

// ─── Helpers ───────────────────────────────────────────────────────────────

void _header(String title) {
  _printLn('');
  _printLn('  $_bold$_cyan$title$_reset');
  _printLn('  $_cyan${"─" * title.length}$_reset');
  _printLn('');
}

void _step(String msg) => _printLn('  $_dim>$_reset $msg');
void _success(String msg) => _printLn('  $_green✓$_reset $msg');
void _error(String msg) => _printLn('  $_red✗$_reset $msg');

void _printLn(String s) => stdout.writeln(s);

String _ask(String prompt) {
  stdout.write('$prompt: ');
  return stdin.readLineSync()?.trim() ?? '';
}

String? _askRequired(String prompt) {
  final value = _ask(prompt);
  if (value.isEmpty) {
    _error('This field is required.');
    return null;
  }
  return value;
}

Future<int> _run(String command, List<String> args) async {
  final process = await Process.start(command, args, runInShell: true);
  process.stdout.listen(stdout.add);
  process.stderr.listen(stderr.add);
  return process.exitCode;
}

void _deletePattern(String dir, String pattern) {
  final directory = Directory(dir);
  if (!directory.existsSync()) return;
  for (final file in directory.listSync(recursive: true)) {
    if (file is File && file.path.contains(RegExp(pattern.replaceAll('*', '.*')))) {
      file.deleteSync();
    }
  }
}

void _listOutputFiles(String dir) {
  final directory = Directory(dir);
  if (!directory.existsSync()) return;
  for (final file in directory.listSync()) {
    if (file is File) {
      final size = file.lengthSync();
      final sizeMb = (size / 1024 / 1024).toStringAsFixed(1);
      final name = file.path.split(Platform.pathSeparator).last;
      _printLn('    $name ($sizeMb MB)');
    }
  }
}

String _toSnakeCase(String input) {
  return input
      .replaceAll(RegExp('[^a-zA-Z0-9]'), '_')
      .replaceAll(RegExp('([A-Z])'), r'_$1')
      .toLowerCase()
      .replaceAll(RegExp('_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
}

String _toPascalCase(String input) {
  return input
      .replaceAll(RegExp('[^a-zA-Z0-9]'), ' ')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map((s) => s[0].toUpperCase() + s.substring(1).toLowerCase())
      .join();
}

List<File> _dartFiles(String dir) {
  final directory = Directory(dir);
  if (!directory.existsSync()) return [];
  return directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();
}
