import 'package:flutter/material.dart';

/// Convenience extensions on BuildContext.
extension BuildContextExtensions on BuildContext {
  /// Access theme data.
  ThemeData get theme => Theme.of(this);

  /// Access color scheme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Access media query.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Show a snackbar.
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show a snackbar with an action.
  void showSnackBarWithAction({
    required String message,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: actionLabel,
          onPressed: onAction,
        ),
      ),
    );
  }
}
