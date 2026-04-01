import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/providers/product_providers.dart';
import 'package:ezflutter/core/ez/ez_detail_page.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Showcases EzDetailPage — fields are declared once and rendered automatically.
@RoutePage()
class ProductDetailPage extends EzDetailPage<Product> {
  const ProductDetailPage({@PathParam('id') required this.id, super.key});

  final String id;

  @override
  String get title => 'Product Details';

  @override
  List<EzField> get fields => [
        EzField.text('name', label: 'Product Name'),
        EzField.text('description', label: 'Description'),
        EzField.currency('price', label: 'Price'),
        EzField.text('category', label: 'Category'),
        EzField.toggle('inStock', label: 'In Stock'),
        EzField.date('createdAt', label: 'Added On'),
      ];

  @override
  AsyncValue<Product> watchData(WidgetRef ref) =>
      ref.watch(productProvider(id));

  @override
  void invalidateData(WidgetRef ref) =>
      ref.invalidate(productProvider(id));

  @override
  List<Widget>? buildActions(BuildContext context, WidgetRef ref) => [
        IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            final productAsync = ref.read(productProvider(id));
            productAsync.whenData((product) {
              ref.read(cartProvider.notifier).addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} added to cart')),
              );
            });
          },
        ),
      ];

  @override
  Widget? buildHero(BuildContext context, Product data) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: data.imageUrl != null
            ? Image.network(
                data.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.image, size: 64),
                ),
              )
            : Container(
                height: 200,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.image, size: 64),
              ),
      );
}
