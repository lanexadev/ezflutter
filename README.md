# EzFlutter

**EzFlutter** is a production-ready Flutter boilerplate designed to kickstart your mobile application development. It provides a clean, modular architecture with essential features already wired up — state management, theming, internationalization, routing, services, and more.

> **Version:** 1.0.0 | **License:** MIT | **Dart SDK:** ^3.7.2

---

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
  - [System Requirements](#system-requirements)
  - [Install Flutter](#install-flutter)
  - [Verify Installation](#verify-installation)
  - [IDE Setup](#ide-setup)
- [Getting Started](#getting-started)
  - [Clone the Repository](#clone-the-repository)
  - [Install Dependencies](#install-dependencies)
  - [Run the App](#run-the-app)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
  - [Overview](#overview)
  - [State Management](#state-management)
  - [Routing](#routing)
  - [Theming](#theming)
  - [Internationalization (i18n)](#internationalization-i18n)
  - [Services](#services)
  - [Utilities](#utilities)
- [Pages & Screens](#pages--screens)
- [Configuration](#configuration)
- [Adding a New Feature](#adding-a-new-feature)
  - [Add a New Page](#add-a-new-page)
  - [Add a New Service](#add-a-new-service)
  - [Add a New Language](#add-a-new-language)
  - [Customize the Theme](#customize-the-theme)
- [Reusable Widgets](#reusable-widgets)
- [Testing](#testing)
- [Build & Deploy](#build--deploy)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Provider-based State Management** — Reactive state with `ChangeNotifier` and `MultiProvider`
- **Light & Dark Theming** — Toggle between themes at runtime with `ThemeManager`
- **Internationalization (i18n)** — JSON-based translations with dynamic language switching (EN/FR included)
- **Centralized Routing** — Named routes with a single route map and automatic error pages
- **HTTP API Client** — Generic `ApiService` for GET/POST requests
- **Local Storage** — `CacheService` wrapping `SharedPreferences` for persistent data
- **Authentication Scaffold** — `AuthService` + `AuthGuard` ready to connect to your backend
- **Notification Service** — Notification framework ready for integration
- **Update Checker** — Compare local version against a remote API
- **Global Error Handling** — Centralized error handler with logging utilities
- **Validation & Formatting** — Email validator and currency formatter included
- **Modular Architecture** — Clean separation between UI, business logic, services, and utilities

---

## Prerequisites

### System Requirements

| Requirement | Minimum |
|---|---|
| **OS** | Windows 10+, macOS 10.15+, or Linux (64-bit) |
| **Disk Space** | 2.8 GB (Flutter SDK + tools) |
| **Git** | 2.x or later |
| **RAM** | 8 GB recommended |

### Install Flutter

#### Windows

1. Download the Flutter SDK from [flutter.dev/docs/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)
2. Extract the zip to a folder (e.g., `C:\flutter`) — **avoid** paths with spaces or special characters
3. Add Flutter to your PATH:
   ```
   setx PATH "%PATH%;C:\flutter\bin"
   ```
4. Install [Android Studio](https://developer.android.com/studio) for the Android SDK and emulator
5. Accept Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```

#### macOS

1. Install via Homebrew (recommended):
   ```bash
   brew install --cask flutter
   ```
   Or download manually from [flutter.dev/docs/get-started/install/macos](https://docs.flutter.dev/get-started/install/macos)
2. Install Xcode from the App Store (required for iOS development):
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```
3. Install CocoaPods:
   ```bash
   sudo gem install cocoapods
   ```
4. Install [Android Studio](https://developer.android.com/studio) for Android development

#### Linux

1. Install dependencies:
   ```bash
   sudo apt update
   sudo apt install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev
   ```
2. Download and extract Flutter:
   ```bash
   git clone https://github.com/flutter/flutter.git -b stable ~/flutter
   echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```
3. Install [Android Studio](https://developer.android.com/studio) for Android development

### Verify Installation

Run Flutter Doctor to check your environment:

```bash
flutter doctor
```

You should see checkmarks for:
- Flutter SDK
- Android toolchain (for Android development)
- Xcode (macOS only, for iOS development)
- Connected device or emulator

Fix any issues reported by `flutter doctor` before proceeding.

### IDE Setup

#### VS Code (Recommended)

1. Install [VS Code](https://code.visualstudio.com/)
2. Install the **Flutter** extension (includes Dart)
3. Open the command palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run `Flutter: New Project` to verify

#### Android Studio

1. Install the **Flutter** and **Dart** plugins via `Settings > Plugins`
2. Configure the Flutter SDK path in `Settings > Languages & Frameworks > Flutter`

#### IntelliJ IDEA

1. Install the **Flutter** plugin via `Settings > Plugins`
2. Configure the SDK path in `Settings > Languages & Frameworks > Flutter`

---

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/lanexadev/ezflutter.git
cd ezflutter
```

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
# List available devices
flutter devices

# Run on a connected device or emulator
flutter run

# Run on a specific device
flutter run -d <device_id>

# Run on Chrome (web)
flutter run -d chrome

# Run in release mode
flutter run --release
```

---

## Project Structure

```
ezflutter/
├── lib/
│   ├── main.dart                        # App entry point & Provider setup
│   ├── app/                             # UI layer
│   │   ├── config/
│   │   │   ├── config.dart              # App constants (name, API URL)
│   │   │   └── routes.dart              # Route definitions map
│   │   ├── pages/
│   │   │   ├── splash_screen.dart       # Loading screen
│   │   │   ├── home.dart                # Main dashboard
│   │   │   ├── auth.dart                # Authentication page
│   │   │   ├── documentation.dart       # Help & documentation
│   │   │   └── notifications.dart       # Notification testing
│   │   ├── themes/
│   │   │   └── custom_themes.dart       # Light & dark theme definitions
│   │   └── widgets/
│   │       ├── app_header.dart          # Reusable AppBar
│   │       └── custom_button.dart       # Reusable button
│   └── core/                            # Business logic layer
│       ├── framework/
│       │   ├── router.dart              # Route generator
│       │   ├── state_manager.dart       # App-wide state (language)
│       │   ├── theme_manager.dart       # Theme switching logic
│       │   ├── error_handler.dart       # Global error handler
│       │   └── logger.dart              # Logging utility
│       ├── services/
│       │   ├── api_service.dart         # HTTP client (GET/POST)
│       │   ├── auth_service.dart        # Authentication logic
│       │   ├── auth_guard.dart          # Route protection widget
│       │   ├── notification_service.dart # Notification dispatch
│       │   ├── storage_service.dart     # Local storage (SharedPreferences)
│       │   ├── translation_service.dart # i18n service (JSON-based)
│       │   └── update_service.dart      # App update checker
│       └── utils/
│           ├── validators.dart          # Input validation (email)
│           └── formatter.dart           # Data formatting (currency)
├── assets/
│   └── locales/
│       ├── en.json                      # English translations
│       └── fr.json                      # French translations
├── test/
│   └── widget_test.dart                 # Widget tests
├── android/                             # Android native config
├── ios/                                 # iOS native config
├── pubspec.yaml                         # Dependencies & project config
├── analysis_options.yaml                # Lint rules
└── README.md
```

---

## Architecture

### Overview

EzFlutter follows a **layered architecture** separating concerns into distinct folders:

```
┌─────────────────────────────────────┐
│            UI Layer (app/)           │
│   Pages, Widgets, Themes, Config    │
├─────────────────────────────────────┤
│        Framework (core/framework/)  │
│   Router, State, Theme, Errors      │
├─────────────────────────────────────┤
│        Services (core/services/)    │
│   API, Auth, Storage, i18n, etc.    │
├─────────────────────────────────────┤
│        Utilities (core/utils/)      │
│   Validators, Formatters            │
└─────────────────────────────────────┘
```

- **`lib/app/`** — Everything the user sees: pages, widgets, themes, route config
- **`lib/core/framework/`** — App-wide infrastructure: routing, state management, theming, error handling
- **`lib/core/services/`** — Business logic and data access: API calls, auth, storage, translations
- **`lib/core/utils/`** — Pure utility functions with no dependencies

### State Management

EzFlutter uses **Provider** with `ChangeNotifier` for reactive state management.

Three providers are registered at the app root in `main.dart`:

| Provider | Class | Purpose |
|---|---|---|
| `ThemeManager` | `ChangeNotifier` | Manages light/dark theme switching |
| `AppState` | `ChangeNotifier` | Manages app-wide state (language) |
| `TranslationService` | `ChangeNotifier` | Manages translations and locale |

**Consuming state in a widget:**

```dart
// Read (non-reactive)
final theme = Provider.of<ThemeManager>(context, listen: false);

// Watch (reactive — rebuilds on change)
final translation = Provider.of<TranslationService>(context);

// Using Consumer
Consumer<ThemeManager>(
  builder: (context, themeManager, child) {
    return Text(themeManager.themeMode.toString());
  },
);
```

### Routing

Routes are defined as a map in `lib/app/config/routes.dart`:

```dart
final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => SplashScreen(),
  '/home': (context) => HomePage(),
  '/documentation': (context) => DocumentationPage(),
  '/notifications': (context) => NotificationsPage(),
  '/auth': (context) => AuthPage(),
};
```

The `AppRouter` in `lib/core/framework/router.dart` generates `MaterialPageRoute` instances from this map. Unknown routes display an error page.

**Navigate between pages:**

```dart
// Push a named route
Navigator.pushNamed(context, '/auth');

// Push and replace current route
Navigator.pushReplacementNamed(context, '/home');

// Go back
Navigator.pop(context);
```

### Theming

Two themes are defined in `lib/app/themes/custom_themes.dart`:

| Theme | Primary | Secondary | Background |
|---|---|---|---|
| **Light** | Blue 700 | Teal 300 | White |
| **Dark** | Blue 300 | Teal 200 | Black 87 |

**Toggle the theme at runtime:**

```dart
final themeManager = Provider.of<ThemeManager>(context, listen: false);
themeManager.toggleTheme();
```

**Customize themes** by editing `CustomThemes.lightTheme` and `CustomThemes.darkTheme` in `lib/app/themes/custom_themes.dart`.

### Internationalization (i18n)

Translations are stored as JSON files in `assets/locales/`:

```json
// assets/locales/en.json
{
  "app_title": "EzFlutter",
  "welcome_message": "Welcome to EzFlutter!",
  "change_language": "Change Language",
  "discover": "Discover"
}
```

**Use translations in widgets:**

```dart
final t = Provider.of<TranslationService>(context);
Text(t.translate('welcome_message'));
```

**Switch language:**

```dart
final appState = Provider.of<AppState>(context, listen: false);
await appState.setAppLanguage('fr');
```

### Services

| Service | File | Description |
|---|---|---|
| **ApiService** | `api_service.dart` | HTTP client with `get(endpoint)` and `post(endpoint, data)` methods |
| **AuthService** | `auth_service.dart` | Authentication with `login(username, password)` and `logout()` |
| **AuthGuard** | `auth_guard.dart` | Widget that blocks access to a page if not authenticated |
| **NotificationService** | `notification_service.dart` | Send notifications with `sendNotification(title, message)` |
| **CacheService** | `storage_service.dart` | Local storage with `saveData(key, value)`, `getData(key)`, `clearCache()` |
| **TranslationService** | `translation_service.dart` | Singleton i18n service with `loadLanguage(code)` and `translate(key)` |
| **UpdateService** | `update_service.dart` | Check for updates with `isUpdateAvailable(currentVersion)` |

**Using the API service:**

```dart
final api = ApiService('https://api.example.com');

// GET request
final data = await api.get('/users');

// POST request
final result = await api.post('/users', {'name': 'John', 'email': 'john@example.com'});
```

**Using the cache service:**

```dart
// Save data
await CacheService.saveData('user_token', 'abc123');

// Retrieve data
final token = await CacheService.getData('user_token');

// Clear all cached data
await CacheService.clearCache();
```

**Protecting a page with AuthGuard:**

```dart
AuthGuard(page: MyProtectedPage());
```

### Utilities

| Utility | Method | Description |
|---|---|---|
| **Validators** | `isValidEmail(String email)` | Validates email format using regex |
| **Formatter** | `formatCurrency(double amount)` | Formats a number as USD currency (e.g., `$99.99`) |

```dart
Validators.isValidEmail('user@example.com'); // true
Formatter.formatCurrency(49.99);             // "$49.99"
```

---

## Pages & Screens

### Splash Screen (`/splash`)
Loading screen with a 3-second delay. Loads the default language and navigates to the home page.

### Home Page (`/home`)
Main dashboard displaying a 2-column grid of feature cards. Includes language and theme toggles in the app bar.

### Authentication (`/auth`)
Login/logout interface. Currently uses placeholder credentials (`admin`/`admin`) — replace `AuthService.login()` with your backend logic.

### Documentation (`/documentation`)
In-app documentation with expandable sections covering setup, page creation, theming, translations, and configuration.

### Notifications (`/notifications`)
Test page for the notification service. Tap the button to dispatch a test notification.

---

## Configuration

App-wide constants are defined in `lib/app/config/config.dart`:

```dart
class AppConfig {
  static const String appName = 'Easy Flutter 3';
  static const String apiBaseUrl = 'https://api.example.com';
}
```

Update these values to match your project:
- **`appName`** — Your application's display name
- **`apiBaseUrl`** — Your backend API base URL

---

## Adding a New Feature

### Add a New Page

1. **Create the page** in `lib/app/pages/`:

   ```dart
   // lib/app/pages/settings.dart
   import 'package:flutter/material.dart';

   class SettingsPage extends StatelessWidget {
     const SettingsPage({super.key});

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: const Text('Settings')),
         body: const Center(child: Text('Settings Page')),
       );
     }
   }
   ```

2. **Register the route** in `lib/app/config/routes.dart`:

   ```dart
   '/settings': (context) => const SettingsPage(),
   ```

3. **Navigate to it**:

   ```dart
   Navigator.pushNamed(context, '/settings');
   ```

### Add a New Service

1. **Create the service** in `lib/core/services/`:

   ```dart
   // lib/core/services/analytics_service.dart
   class AnalyticsService {
     void trackEvent(String name, Map<String, dynamic> properties) {
       // Your analytics implementation
     }
   }
   ```

2. **Use it** in your pages or other services:

   ```dart
   final analytics = AnalyticsService();
   analytics.trackEvent('button_pressed', {'button': 'login'});
   ```

### Add a New Language

1. **Create a JSON file** in `assets/locales/` (e.g., `es.json`):

   ```json
   {
     "app_title": "EzFlutter",
     "welcome_message": "Bienvenido a EzFlutter!",
     "change_language": "Cambiar idioma",
     "discover": "Descubrir"
   }
   ```

2. **Register the asset** in `pubspec.yaml`:

   ```yaml
   assets:
     - assets/locales/en.json
     - assets/locales/fr.json
     - assets/locales/es.json
   ```

3. **Load the language**:

   ```dart
   await appState.setAppLanguage('es');
   ```

### Customize the Theme

Edit `lib/app/themes/custom_themes.dart` to modify colors, typography, and component styles:

```dart
static ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,        // Change primary color
    secondary: Colors.amber,         // Change secondary color
  ),
  fontFamily: 'Roboto',             // Change font
  useMaterial3: true,
);
```

---

## Reusable Widgets

### AppHeader

A pre-styled `AppBar` with a centered title, implementing `PreferredSizeWidget`:

```dart
Scaffold(
  appBar: AppHeader(title: 'My Page Title'),
  body: ...,
);
```

### CustomButton

A styled `ElevatedButton` wrapper:

```dart
CustomButton(
  text: 'Submit',
  onPressed: () => handleSubmit(),
);
```

---

## Testing

Run tests with:

```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

---

## Build & Deploy

### Android

```bash
# Build APK
flutter build apk

# Build App Bundle (recommended for Play Store)
flutter build appbundle
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
# Build for iOS (macOS only)
flutter build ios

# Build IPA for distribution
flutter build ipa
```

### Web

```bash
flutter build web
```

Output: `build/web/`

---

## Troubleshooting

| Issue | Solution |
|---|---|
| `flutter pub get` fails | Run `flutter clean` then `flutter pub get` |
| Emulator not detected | Run `flutter doctor` and check Android SDK setup |
| iOS build fails | Run `cd ios && pod install && cd ..` |
| Hot reload not working | Restart the app with `flutter run` |
| Translation not loading | Verify the JSON file is listed in `pubspec.yaml` assets |
| Theme not toggling | Ensure you access `ThemeManager` via `Provider.of<ThemeManager>(context)` |

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m "Add my feature"`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

Made with Flutter by [LanexaDev](https://github.com/lanexadev)
