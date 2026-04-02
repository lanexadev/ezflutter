import 'package:ezflutter/app/widgets/error_view.dart';
import 'package:flutter/material.dart';

/// Catches widget-level errors and displays an error view instead of crashing.
///
/// Wrap any subtree that might throw during build:
/// ```dart
/// ErrorBoundary(
///   child: SomeRiskyWidget(),
/// )
/// ```
class ErrorBoundary extends StatefulWidget {
  const ErrorBoundary({
    required this.child,
    this.onError,
    super.key,
  });

  final Widget child;
  final void Function(FlutterErrorDetails details)? onError;

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return ErrorView(
        message: _error!.exceptionAsString(),
        onRetry: () => setState(() => _error = null),
      );
    }

    return _ErrorBoundaryInherited(
      onError: (details) {
        widget.onError?.call(details);
        setState(() => _error = details);
      },
      child: widget.child,
    );
  }
}

class _ErrorBoundaryInherited extends InheritedWidget {
  const _ErrorBoundaryInherited({
    required this.onError,
    required super.child,
  });

  final void Function(FlutterErrorDetails) onError;

  @override
  bool updateShouldNotify(_ErrorBoundaryInherited oldWidget) =>
      onError != oldWidget.onError;
}
