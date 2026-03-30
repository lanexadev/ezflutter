import 'package:flutter/widgets.dart';
import 'package:ezflutter/core/logging/log.dart';

/// Observes app lifecycle events (foreground/background).
class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Log.debug('App resumed (foreground)');
      case AppLifecycleState.inactive:
        Log.debug('App inactive');
      case AppLifecycleState.paused:
        Log.debug('App paused (background)');
      case AppLifecycleState.detached:
        Log.debug('App detached');
      case AppLifecycleState.hidden:
        Log.debug('App hidden');
    }
  }
}
