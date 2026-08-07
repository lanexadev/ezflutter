import 'dart:io';

final class TemplateWriter {
  const TemplateWriter({
    required this.root,
    required this.projectName,
    this.localFrameworkPath,
  });

  final Directory root;
  final String projectName;
  final String? localFrameworkPath;

  Future<void> write() async {
    final files = _applicationFiles(projectName, localFrameworkPath);
    for (final entry in files.entries) {
      final file = File(_join(root.path, entry.key));
      await file.parent.create(recursive: true);
      await file.writeAsString(entry.value);
    }
    final obsoleteTest = File(_join(root.path, 'test/widget_test.dart'));
    if (await obsoleteTest.exists()) await obsoleteTest.delete();
    await _configureAndroidFlavors();
  }

  Future<void> _configureAndroidFlavors() async {
    final buildFile = File(_join(root.path, 'android/app/build.gradle.kts'));
    var source = await buildFile.readAsString();
    const flavors = '''
    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
        }
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
        }
        create("prod") {
            dimension = "environment"
        }
    }

''';
    source = source.replaceFirst(
      '    buildTypes {',
      '$flavors    buildTypes {',
    );
    await buildFile.writeAsString(source);
  }

  static Future<void> addFeature(Directory project, String name) async {
    final destination = Directory(_join(project.path, 'lib/features/$name'));
    if (await destination.exists()) {
      throw FileSystemException('Feature already exists', destination.path);
    }
    await destination.parent.create(recursive: true);
    final staging = await destination.parent.createTemp('.nativiq_feature_');
    try {
      final files = _featureFiles(name);
      for (final entry in files.entries) {
        final file = File(_join(staging.path, entry.key));
        await file.parent.create(recursive: true);
        await file.writeAsString(entry.value);
      }
      await staging.rename(destination.path);
    } catch (_) {
      if (await staging.exists()) await staging.delete(recursive: true);
      rethrow;
    }
  }

  static Future<void> addModel(
    Directory project,
    String feature,
    String name,
  ) async {
    final featureDirectory = Directory(
      _join(project.path, 'lib/features/$feature'),
    );
    if (!await featureDirectory.exists()) {
      throw FileSystemException(
        'Feature does not exist',
        featureDirectory.path,
      );
    }
    final directory = Directory(_join(featureDirectory.path, 'domain/models'));
    final destination = File(_join(directory.path, '$name.dart'));
    if (await destination.exists()) {
      throw FileSystemException('Model already exists', destination.path);
    }
    await directory.create(recursive: true);
    final staging = File(
      _join(
        directory.path,
        '.$name.${DateTime.now().microsecondsSinceEpoch}.tmp',
      ),
    );
    try {
      await staging.writeAsString(_modelFile(name));
      await staging.rename(destination.path);
    } catch (_) {
      if (await staging.exists()) await staging.delete();
      rethrow;
    }
  }
}

Map<String, String> _applicationFiles(String name, String? frameworkPath) => {
  'pubspec.yaml': _pubspec(name, frameworkPath),
  'analysis_options.yaml':
      "include: package:flutter_lints/flutter.yaml\n\nlinter:\n  rules:\n    - directives_ordering\n    - prefer_final_locals\n",
  'AGENTS.md': _agents,
  '.agents/rules/architecture.md': _architectureRule,
  '.agents/rules/testing.md': _testingRule,
  '.agents/skills/create-feature/SKILL.md': _featureSkill,
  '.agents/hooks/README.md': _hooksReadme,
  '.agents/references/architecture.md': _architectureReference,
  'lib/main.dart':
      "import 'bootstrap.dart';\nimport 'core/config/app_environment.dart';\n\nvoid main() => bootstrap(AppEnvironment.production);\n",
  'lib/main_dev.dart':
      "import 'bootstrap.dart';\nimport 'core/config/app_environment.dart';\n\nvoid main() => bootstrap(AppEnvironment.development);\n",
  'lib/main_staging.dart':
      "import 'bootstrap.dart';\nimport 'core/config/app_environment.dart';\n\nvoid main() => bootstrap(AppEnvironment.staging);\n",
  'lib/bootstrap.dart': _bootstrap(name),
  'lib/app/app.dart': _app,
  'lib/core/config/app_environment.dart': _environment,
  ..._featureFiles(
    'home',
  ).map((path, value) => MapEntry('lib/features/home/$path', value)),
  'test/core/config/app_environment_test.dart': _environmentTest(name),
  'test/features/home/presentation/home_view_model_test.dart':
      _homeViewModelTest(name),
  'test/widget/app_test.dart': _appTest(name),
  'integration_test/app_smoke_test.dart': _integrationTest(name),
};

Map<String, String> _featureFiles(String name) {
  final pascal = _pascalCase(name);
  return {
    'domain/${name}_repository.dart':
        "abstract interface class ${pascal}Repository {\n  Future<String> load();\n}\n",
    'data/in_memory_${name}_repository.dart':
        "import '../domain/${name}_repository.dart';\n\nfinal class InMemory${pascal}Repository implements ${pascal}Repository {\n  @override\n  Future<String> load() async => '$pascal ready';\n}\n",
    'presentation/${name}_view_model.dart':
        "import 'package:flutter/foundation.dart';\nimport 'package:nativiq/nativiq.dart';\n\nimport '../domain/${name}_repository.dart';\n\nfinal class ${pascal}ViewModel extends ChangeNotifier {\n  ${pascal}ViewModel(this._repository);\n\n  final ${pascal}Repository _repository;\n  AsyncState<String> state = const AsyncState.idle();\n  String get message => state.dataOrNull ?? '';\n\n  Future<void> load() async {\n    state = AsyncState.loading(previousData: state.dataOrNull);\n    notifyListeners();\n    state = AsyncState.data(await _repository.load());\n    notifyListeners();\n  }\n}\n",
    'presentation/${name}_screen.dart':
        "import 'package:flutter/material.dart';\n\nimport '../data/in_memory_${name}_repository.dart';\nimport '${name}_view_model.dart';\n\nfinal class ${pascal}Screen extends StatefulWidget {\n  const ${pascal}Screen({super.key});\n\n  @override\n  State<${pascal}Screen> createState() => _${pascal}ScreenState();\n}\n\nfinal class _${pascal}ScreenState extends State<${pascal}Screen> {\n  late final ${pascal}ViewModel viewModel;\n\n  @override\n  void initState() {\n    super.initState();\n    viewModel = ${pascal}ViewModel(InMemory${pascal}Repository())..load();\n  }\n\n  @override\n  void dispose() {\n    viewModel.dispose();\n    super.dispose();\n  }\n\n  @override\n  Widget build(BuildContext context) => Scaffold(\n    appBar: AppBar(title: const Text('$pascal')),\n    body: ListenableBuilder(\n      listenable: viewModel,\n      builder: (context, child) => Center(\n        child: viewModel.state.isLoading\n            ? const CircularProgressIndicator()\n            : Text(viewModel.message, key: const Key('${name}_message')),\n      ),\n    ),\n  );\n}\n",
  };
}

String _modelFile(String name) {
  final pascal = _pascalCase(name);
  return "final class $pascal {\n  const $pascal({required this.id});\n\n  final String id;\n\n  factory $pascal.fromJson(Map<String, Object?> json) => $pascal(id: json['id']! as String);\n\n  Map<String, Object?> toJson() => {'id': id};\n}\n";
}

String _pubspec(String name, String? frameworkPath) =>
    '''name: $name
description: AI-native Flutter application built with Nativiq.
publish_to: none
version: 1.0.0+1

environment:
  sdk: ^3.11.0

dependencies:
  flutter:
    sdk: flutter
  nativiq:
${frameworkPath == null ? '    ^3.0.0' : '    path: ${frameworkPath.replaceAll('\\', '/')}'}

dev_dependencies:
  flutter_lints: ^6.0.0
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter

flutter:
  uses-material-design: true
''';

String _bootstrap(String name) =>
    "import 'package:flutter/widgets.dart';\n\nimport 'app/app.dart';\nimport 'core/config/app_environment.dart';\n\nvoid bootstrap(AppEnvironment environment) {\n  WidgetsFlutterBinding.ensureInitialized();\n  runApp(const App());\n}\n";

const _app =
    "import 'package:flutter/material.dart';\n\nimport '../features/home/presentation/home_screen.dart';\n\nfinal class App extends StatelessWidget {\n  const App({super.key});\n\n  @override\n  Widget build(BuildContext context) => MaterialApp(\n    title: 'Nativiq App',\n    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),\n    home: const HomeScreen(),\n  );\n}\n";

const _environment =
    "enum AppEnvironment { development, staging, production }\n";
String _environmentTest(String name) =>
    "import 'package:$name/core/config/app_environment.dart';\nimport 'package:flutter_test/flutter_test.dart';\n\nvoid main() {\n  test('exposes all deployment environments', () {\n    expect(AppEnvironment.values, hasLength(3));\n  });\n}\n";
String _homeViewModelTest(String name) =>
    "import 'package:$name/features/home/data/in_memory_home_repository.dart';\nimport 'package:$name/features/home/presentation/home_view_model.dart';\nimport 'package:flutter_test/flutter_test.dart';\n\nvoid main() {\n  test('loads the repository message', () async {\n    final viewModel = HomeViewModel(InMemoryHomeRepository());\n    await viewModel.load();\n    expect(viewModel.message, 'Home ready');\n  });\n}\n";
String _appTest(String name) =>
    "import 'package:$name/app/app.dart';\nimport 'package:flutter_test/flutter_test.dart';\n\nvoid main() {\n  testWidgets('shows the home state', (tester) async {\n    await tester.pumpWidget(const App());\n    await tester.pumpAndSettle();\n    expect(find.text('Home ready'), findsOneWidget);\n  });\n}\n";
String _integrationTest(String name) =>
    "import 'package:$name/main_dev.dart' as app;\nimport 'package:flutter_test/flutter_test.dart';\nimport 'package:integration_test/integration_test.dart';\n\nvoid main() {\n  IntegrationTestWidgetsFlutterBinding.ensureInitialized();\n  testWidgets('launches the development application', (tester) async {\n    app.main();\n    await tester.pumpAndSettle();\n    expect(find.text('Home ready'), findsOneWidget);\n  });\n}\n";

const _agents = '''# AI agent entry point

Read `.agents/rules/` before changing code. Load only the relevant workflow from
`.agents/skills/`, and consult `.agents/references/architecture.md` for structural decisions.
Hooks are documented in `.agents/hooks/README.md`.

This application targets Android and iOS only. Preserve the feature-first MVVM boundaries and
run `flutter analyze` plus `flutter test` before presenting a change.
''';
const _architectureRule = '''# Architecture rules

- Organize product code by feature, then by `data`, `domain`, and `presentation`.
- Presentation depends on domain contracts; data implements those contracts.
- View models own screen state. Widgets render state and forward user intent.
- Keep platform support limited to Android and iOS.
''';
const _testingRule = '''# Testing rules

- Test observable behavior with Arrange, Act, Assert structure.
- Unit-test view models and repositories; widget-test user-visible states.
- Add an integration smoke test for every critical launch path.
''';
const _featureSkill = '''---
name: create-feature
description: Add a feature while preserving Nativiq feature-first MVVM boundaries.
---

# Create a feature

1. Create `lib/features/<name>/{data,domain,presentation}`.
2. Define the repository contract in domain and its implementation in data.
3. Add a view model and screen in presentation.
4. Add unit and widget tests for observable behavior.
5. Run `flutter analyze` and `flutter test`.

Prefer `nativiq add feature <name>` for the initial scaffold.
''';
const _hooksReadme = '''# Hooks

Agent tools may wire their native hooks to run `flutter analyze` and `flutter test` after changes.
This directory documents intent only so the repository stays provider-neutral.
''';
const _architectureReference = '''# Application architecture

The application uses feature-first MVVM. Each feature owns its data adapters, domain contracts,
and presentation layer. Shared cross-feature types live under `lib/core`. Entrypoints select one of
the development, staging, or production environments before bootstrapping the same application.
''';

String _pascalCase(String value) => value
    .split('_')
    .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
    .join();
String _join(String left, String right) =>
    '${left.replaceAll(RegExp(r'[/\\]+$'), '')}${Platform.pathSeparator}${right.replaceAll(RegExp(r'^[/\\]+'), '')}';
