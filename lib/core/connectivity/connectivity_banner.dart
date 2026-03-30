import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezflutter/core/connectivity/connectivity_provider.dart';

/// A banner that shows when the device is offline.
class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);

    return Column(
      children: [
        connectivity.when(
          data: (isOnline) => isOnline
              ? const SizedBox.shrink()
              : MaterialBanner(
                  content: const Text('No internet connection'),
                  backgroundColor: Colors.red.shade100,
                  actions: const [SizedBox.shrink()],
                ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        Expanded(child: child),
      ],
    );
  }
}
