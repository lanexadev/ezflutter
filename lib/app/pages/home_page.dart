import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/auth/auth_provider.dart';
import 'package:ezflutter/core/auth/auth_state.dart';
import 'package:ezflutter/core/router/app_router.gr.dart';
import 'package:ezflutter/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EzFlutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () =>
                ref.read(appThemeModeProvider.notifier).toggle(),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.router.push(const SettingsRoute()),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flutter_dash,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to EzFlutter V2',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'A production-ready Flutter boilerplate',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              switch (authState) {
                Authenticated(:final user) => Column(
                    children: [
                      Text('Logged in as ${user.email}'),
                      const SizedBox(height: 12),
                      FilledButton.tonal(
                        onPressed: () =>
                            ref.read(authProvider.notifier).logout(),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                Unauthenticated() => FilledButton(
                    onPressed: () =>
                        context.router.push(const LoginRoute()),
                    child: const Text('Login'),
                  ),
                AuthLoading() => const CircularProgressIndicator(),
              },
            ],
          ),
        ),
      ),
    );
  }
}
