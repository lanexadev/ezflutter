import 'dart:async';

/// Debounces calls to avoid excessive execution.
///
/// Usage:
/// ```dart
/// final debouncer = Debouncer(duration: Duration(milliseconds: 300));
/// debouncer.run(() => search(query));
/// ```
class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 300)});

  final Duration duration;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }
}
