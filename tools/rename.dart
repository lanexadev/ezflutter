// ignore_for_file: avoid_print
import 'dart:io';

/// Renames the EzFlutter project.
///
/// Usage: dart run tools/rename.dart --name "MyApp" --org "com.example"
Future<void> main(List<String> args) async {
  final name = _getArg(args, '--name');
  final org = _getArg(args, '--org');

  if (name == null && org == null) {
    print('Usage: dart run tools/rename.dart --name "MyApp" --org "com.example"');
    exit(1);
  }

  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    print('Error: pubspec.yaml not found. Run from project root.');
    exit(1);
  }

  var content = pubspec.readAsStringSync();
  final oldName = RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(content)?.group(1) ?? 'ezflutter';

  if (name != null) {
    final snakeName = _toSnakeCase(name);
    print('Renaming package: $oldName -> $snakeName');

    // Update pubspec.yaml
    content = content.replaceFirst(RegExp(r'^name:\s*\S+', multiLine: true), 'name: $snakeName');
    pubspec.writeAsStringSync(content);
    print('  Updated pubspec.yaml');

    // Update all Dart imports
    var count = 0;
    for (final file in _dartFiles('lib')) {
      final src = file.readAsStringSync();
      final updated = src.replaceAll('package:$oldName/', 'package:$snakeName/');
      if (src != updated) {
        file.writeAsStringSync(updated);
        count++;
      }
    }
    for (final file in _dartFiles('test')) {
      final src = file.readAsStringSync();
      final updated = src.replaceAll('package:$oldName/', 'package:$snakeName/');
      if (src != updated) {
        file.writeAsStringSync(updated);
        count++;
      }
    }
    print('  Updated $count Dart files');
  }

  if (org != null) {
    print('Updating organization: $org');

    // Android build.gradle.kts
    final gradle = File('android/app/build.gradle.kts');
    if (gradle.existsSync()) {
      var g = gradle.readAsStringSync();
      g = g.replaceAll(RegExp(r'namespace\s*=\s*"[^"]*"'), 'namespace = "$org.${_toSnakeCase(name ?? oldName)}"');
      g = g.replaceAll(RegExp(r'applicationId\s*=\s*"[^"]*"'), 'applicationId = "$org.${_toSnakeCase(name ?? oldName)}"');
      gradle.writeAsStringSync(g);
      print('  Updated android/app/build.gradle.kts');
    }

    // iOS project.pbxproj
    final pbxproj = File('ios/Runner.xcodeproj/project.pbxproj');
    if (pbxproj.existsSync()) {
      var p = pbxproj.readAsStringSync();
      p = p.replaceAll(
        RegExp(r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*[^;]+'),
        'PRODUCT_BUNDLE_IDENTIFIER = $org.${_toSnakeCase(name ?? oldName)}',
      );
      pbxproj.writeAsStringSync(p);
      print('  Updated ios/Runner.xcodeproj/project.pbxproj');
    }
  }

  print('\nDone! Run "flutter clean && flutter pub get" to apply changes.');
}

String? _getArg(List<String> args, String flag) {
  final idx = args.indexOf(flag);
  if (idx == -1 || idx + 1 >= args.length) return null;
  return args[idx + 1];
}

String _toSnakeCase(String input) {
  return input
      .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
      .replaceAll(RegExp(r'([A-Z])'), '_\$1')
      .toLowerCase()
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
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
