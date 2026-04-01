import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

/// Watches network connectivity in real-time.
///
/// Usage:
/// ```dart
/// final isOnline = ref.watch(connectivityProvider);
/// ```
@Riverpod(keepAlive: true)
Stream<bool> connectivity(Ref ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged.map(
    (results) => results.any(
      (r) => r != ConnectivityResult.none,
    ),
  );
}
