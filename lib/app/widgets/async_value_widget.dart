import 'package:ezflutter/app/widgets/error_view.dart';
import 'package:ezflutter/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles AsyncValue states (loading, error, data) automatically.
///
/// Usage:
/// ```dart
/// AsyncValueWidget(
///   value: ref.watch(myAsyncProvider),
///   data: (data) => Text(data.toString()),
/// )
/// ```
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.data,
    this.loading,
    this.error,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading?.call() ?? const LoadingWidget(),
      error: (e, s) =>
          error?.call(e, s) ?? ErrorView(message: e.toString()),
    );
  }
}
