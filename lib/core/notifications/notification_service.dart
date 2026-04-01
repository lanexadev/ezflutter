import 'package:ezflutter/core/logging/log.dart';

/// Simplified notification interface.
///
/// This is a **stub implementation** that logs notifications to console.
/// To enable real notifications, add `flutter_local_notifications` to
/// your pubspec.yaml and implement the methods below.
///
/// For push notifications, add `firebase_messaging` and configure
/// Firebase for your project.
///
/// Usage:
/// ```dart
/// await Notify.show(title: 'Reminder', body: 'Check your app');
/// await Notify.schedule(title: 'Meeting', body: 'In 1 hour', when: ...);
/// ```
///
/// ## Real implementation guide
///
/// 1. Add to pubspec.yaml:
///    ```yaml
///    flutter_local_notifications: any
///    firebase_messaging: any  # for push
///    ```
///
/// 2. Replace the stub methods with real implementations.
///    See: https://pub.dev/packages/flutter_local_notifications
class Notify {
  Notify._();

  /// Initialize the notification service.
  /// Call this in main() after WidgetsFlutterBinding.ensureInitialized().
  static Future<void> init() async {
    Log.info('Notification service initialized (stub)');
  }

  /// Show an immediate local notification.
  static Future<void> show({
    required String title,
    required String body,
  }) async {
    Log.info('Notification: $title — $body');
  }

  /// Schedule a notification for a future time.
  static Future<void> schedule({
    required String title,
    required String body,
    required DateTime when,
  }) async {
    Log.info('Scheduled notification: $title at $when');
  }
}
