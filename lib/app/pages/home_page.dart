import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/app/providers/product_providers.dart';
import 'package:ezflutter/core/auth/auth_provider.dart';
import 'package:ezflutter/core/auth/auth_state.dart';
import 'package:ezflutter/core/connectivity/connectivity_banner.dart';
import 'package:ezflutter/core/ez/ez_tile.dart';
import 'package:ezflutter/core/router/app_router.gr.dart';
import 'package:ezflutter/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final productsAsync = ref.watch(productsProvider);
    final cart = ref.watch(cartProvider);

    return ConnectivityBanner(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EzShop'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => ref.read(appThemeModeProvider.notifier).toggle(),
            ),
            Badge(
              label: Text('${ref.watch(cartProvider).fold(0, (s, i) => s + i.quantity)}'),
              isLabelVisible: cart.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => context.router.push(const CartRoute()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.router.push(const SettingsRoute()),
            ),
          ],
        ),
        body: productsAsync.when(
          data: (products) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Welcome banner
              Card(
                color: theme.colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        switch (authState) {
                          Authenticated(:final user) => 'Welcome back, ${user.displayName ?? user.email}!',
                          _ => 'Welcome to EzShop!',
                        },
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${products.length} products available',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Quick actions
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => context.router.push(const ProductListRoute()),
                      icon: const Icon(Icons.storefront),
                      label: const Text('Browse All'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () => context.router.push(const AddProductRoute()),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Product'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Featured products
              Text('Featured Products', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...products.take(4).map(
                (product) => Card(
                  child: EzTile(
                    title: product.name,
                    subtitle: '\$${product.price.toStringAsFixed(2)} — ${product.category}',
                    leading: EzTile.avatar(product.imageUrl),
                    trailing: product.inStock
                        ? EzTile.badge('In Stock', color: Colors.green)
                        : EzTile.badge('Sold Out', color: Colors.red),
                    onTap: () => context.router.push(ProductDetailRoute(id: product.id)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Auth section
              if (authState is! Authenticated)
                OutlinedButton.icon(
                  onPressed: () => context.router.push(const LoginRoute()),
                  icon: const Icon(Icons.login),
                  label: const Text('Sign in to manage products'),
                ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.router.push(const AddProductRoute()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
