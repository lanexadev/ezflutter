# Getting started

## Requirements

- Flutter stable 3.41 or later
- Dart 3.11 or later
- Android Studio/Xcode according to the platform you build

Run `nativiq doctor` before creating an app. Diagnostics can be consumed by automation with `nativiq doctor --json`.

## Create an application

```bash
nativiq create acme_mobile --org com.acme
cd acme_mobile
flutter pub get
flutter test
flutter run --target lib/main_dev.dart --dart-define=APP_ENV=dev
```

Generation is non-interactive and safe by default: invalid Dart package names, unsupported platforms, unsafe paths, and non-empty destinations are rejected before files are written.

## Extend it

```bash
nativiq add feature checkout
nativiq add model checkout order
```

Run the repository hook after changes:

```bash
.agents/hooks/validate.sh
```
