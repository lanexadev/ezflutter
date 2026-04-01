import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/providers/product_providers.dart';
import 'package:ezflutter/app/widgets/empty_state.dart';
import 'package:ezflutter/app/widgets/error_view.dart';
import 'package:ezflutter/app/widgets/loading_widget.dart';
import 'package:ezflutter/core/ez/ez_tile.dart';
import 'package:ezflutter/core/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Product list with search — showcases EzTile in a custom page
/// with filtering that EzListPage doesn't natively provide.
@RoutePage()
class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  String _searchQuery = '';

  List<Product> _filter(List<Product> products) {
    if (_searchQuery.isEmpty) return products;
    final query = _searchQuery.toLowerCase();
    return products.where((p) =>
        p.name.toLowerCase().contains(query) ||
        p.category.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(const AddProductRoute()),
        child: const Icon(Icons.add),
      ),
      body: productsAsync.when(
        data: (products) {
          final filtered = _filter(products);
          if (filtered.isEmpty) {
            return EmptyState(
              message: _searchQuery.isEmpty
                  ? 'No products yet. Add your first!'
                  : 'No products match "$_searchQuery"',
              icon: Icons.storefront,
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(productsProvider),
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final product = filtered[index];
                return InkWell(
                  onTap: () => context.router.push(
                    ProductDetailRoute(id: product.id),
                  ),
                  child: EzTile(
                    title: product.name,
                    subtitle:
                        '\$${product.price.toStringAsFixed(2)} — ${product.category}',
                    leading: EzTile.avatar(product.imageUrl),
                    trailing: product.inStock
                        ? EzTile.chevron
                        : EzTile.badge('Sold Out', color: Colors.red),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(productsProvider),
        ),
      ),
    );
  }
}
