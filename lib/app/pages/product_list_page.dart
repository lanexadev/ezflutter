import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/providers/product_providers.dart';
import 'package:ezflutter/core/ez/ez_list_page.dart';
import 'package:ezflutter/core/ez/ez_tile.dart';
import 'package:ezflutter/core/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Showcases EzListPage — the developer writes ~20 lines for a full
/// list page with loading, error, empty, pull-to-refresh.
@RoutePage()
class ProductListPage extends EzListPage<Product> {
  const ProductListPage({super.key});

  @override
  String get title => 'Products';

  @override
  String get emptyMessage => 'No products yet. Add your first!';

  @override
  IconData get emptyIcon => Icons.storefront;

  @override
  bool get divider => true;

  @override
  AsyncValue<List<Product>> watchData(WidgetRef ref) =>
      ref.watch(productsProvider);

  @override
  void invalidateData(WidgetRef ref) => ref.invalidate(productsProvider);

  @override
  Widget buildItem(BuildContext context, Product item) => EzTile(
        title: item.name,
        subtitle: '\$${item.price.toStringAsFixed(2)} — ${item.category}',
        leading: EzTile.avatar(item.imageUrl),
        trailing: item.inStock ? EzTile.chevron : EzTile.badge('Sold Out', color: Colors.red),
      );

  @override
  void onItemTap(BuildContext context, Product item) =>
      context.router.push(ProductDetailRoute(id: item.id));

  @override
  Widget? buildFab(BuildContext context, WidgetRef ref) =>
      FloatingActionButton(
        onPressed: () => context.router.push(const AddProductRoute()),
        child: const Icon(Icons.add),
      );
}
