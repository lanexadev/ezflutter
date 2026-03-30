import 'package:ezflutter/core/logging/log.dart';

/// Simplified notification interface.
///
/// Usage:
/// ```dart
/// await Notify.show(title: 'Reminder', body: 'Check your app');
/// ```
class Notify {
  Notify._();

  static Future<void> init() async {
    // TODO: Initialize flutter_local_notifications + firebase_messaging
    Log.info('Notification service initialized');
  }

  static Future<void> show({
    required String title,
    required String body,
  }) async {
    // TODO: Implement with flutter_local_notifications
    Log.info('Notification: $title — $body');
  }

  static Future<void> schedule({
    required String title,
    required String body,
    required DateTime when,
  }) async {
    // TODO: Implement scheduled notifications
    Log.info('Scheduled notification: $title at $when');
  }
}
