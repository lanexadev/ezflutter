// ignore_for_file: avoid_print
import 'dart:io';

/// Builds the app for Android and/or iOS in release mode.
///
/// Usage:
///   dart run tools/build.dart                      # Build both
///   dart run tools/build.dart --android             # Android only
///   dart run tools/build.dart --ios                 # iOS only
///   dart run tools/build.dart --env prod            # Specific env (default: prod)
///   dart run tools/build.dart --apk                 # APK split-per-abi
///   dart run tools/build.dart --aab                 # App Bundle (Play Store)
///   dart run tools/build.dart --android --apk --aab # Both APK and AAB
Future<void> main(List<String> args) async {
  final android = args.contains('--android') || _noPlatformFlag(args);
  final ios = args.contains('--ios') || _noPlatformFlag(args);
  final buildApk = args.contains('--apk') || (!args.contains('--aab') && android);
  final buildAab = args.contains('--aab') || (!args.contains('--apk') && android);
  final env = _getArg(args, '--env') ?? 'prod';
  final configFile = 'config/$env.json';

  if (!File(configFile).existsSync()) {
    print('Error: $configFile not found.');
    print('Available: config/dev.json, config/staging.json, config/prod.json');
    exit(1);
  }

  print('=== EzFlutter Build ===');
  print('Environment: $env');
  print('Config: $configFile');
  print('Platforms: ${[if (android) "Android", if (ios) "iOS"].join(", ")}');
  print('');

  // Step 1: Code generation
  print('[1/3] Running code generation...');
  final gen = await _run('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
  if (gen != 0) {
    print('Code generation failed.');
    exit(1);
  }

  // Step 2: Android builds
  if (android) {
    if (buildApk) {
      print('');
      print('[2/3] Building Android APK (split-per-abi)...');
      print('      Architectures: arm64-v8a, armeabi-v7a, x86_64');
      final apk = await _run('flutter', [
        'build',
        'apk',
        '--release',
        '--split-per-abi',
        '--dart-define-from-file=$configFile',
        '--obfuscate',
        '--split-debug-info=build/debug-info/android',
      ]);
      if (apk != 0) {
        print('APK build failed.');
        exit(1);
      }
      print('');
      print('APK outputs:');
      _listFiles('build/app/outputs/flutter-apk/');
    }

    if (buildAab) {
      print('');
      print('[2/3] Building Android App Bundle (Play Store)...');
      final aab = await _run('flutter', [
        'build',
        'appbundle',
        '--release',
        '--dart-define-from-file=$configFile',
        '--obfuscate',
        '--split-debug-info=build/debug-info/android',
      ]);
      if (aab != 0) {
        print('App Bundle build failed.');
        exit(1);
      }
      print('');
      print('AAB output:');
      _listFiles('build/app/outputs/bundle/release/');
    }
  }

  // Step 3: iOS build
  if (ios) {
    if (!Platform.isMacOS) {
      print('');
      print('[3/3] Skipping iOS — requires macOS.');
    } else {
      print('');
      print('[3/3] Building iOS...');
      final ipa = await _run('flutter', [
        'build',
        'ipa',
        '--release',
        '--dart-define-from-file=$configFile',
        '--obfuscate',
        '--split-debug-info=build/debug-info/ios',
      ]);
      if (ipa != 0) {
        print('iOS build failed.');
        print('Note: iOS requires code signing. Run with --no-codesign for CI.');
        exit(1);
      }
      print('');
      print('IPA output:');
      _listFiles('build/ios/ipa/');
    }
  }

  print('');
  print('=== Build complete ===');
  print('');
  print('Outputs:');
  if (android && buildApk) {
    print('  APK (split):  build/app/outputs/flutter-apk/');
    print('    - app-arm64-v8a-release.apk    (~15 MB, 95% devices)');
    print('    - app-armeabi-v7a-release.apk   (~12 MB, legacy 32-bit)');
    print('    - app-x86_64-release.apk        (~15 MB, emulators)');
  }
  if (android && buildAab) {
    print('  AAB:          build/app/outputs/bundle/release/app-release.aab');
    print('                (Upload this to Google Play Store)');
  }
  if (ios) {
    print('  IPA:          build/ios/ipa/');
    print('                (Upload via Transporter or fastlane)');
  }
  print('');
  print('Debug symbols: build/debug-info/');
  print('               (Upload to Firebase Crashlytics for deobfuscation)');
}

Future<int> _run(String command, List<String> args) async {
  final process = await Process.start(command, args, runInShell: true);
  process.stdout.listen(stdout.add);
  process.stderr.listen(stderr.add);
  return process.exitCode;
}

void _listFiles(String dir) {
  final directory = Directory(dir);
  if (!directory.existsSync()) {
    print('  (directory not found — build may have failed)');
    return;
  }
  for (final file in directory.listSync()) {
    if (file is File) {
      final size = file.lengthSync();
      final sizeMb = (size / 1024 / 1024).toStringAsFixed(1);
      final name = file.path.split(Platform.pathSeparator).last;
      print('  $name (${sizeMb} MB)');
    }
  }
}

bool _noPlatformFlag(List<String> args) =>
    !args.contains('--android') && !args.contains('--ios');

String? _getArg(List<String> args, String flag) {
  final idx = args.indexOf(flag);
  if (idx == -1 || idx + 1 >= args.length) return null;
  return args[idx + 1];
}
