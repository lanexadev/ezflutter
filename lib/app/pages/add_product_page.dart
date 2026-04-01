import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/providers/product_providers.dart';
import 'package:ezflutter/app/services/product_service.dart';
import 'package:ezflutter/core/di/injection.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:ezflutter/core/ez/ez_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Showcases EzFormPage — declare fields, get a full form with validation.
@RoutePage()
class AddProductPage extends EzFormPage {
  const AddProductPage({super.key});

  @override
  String get title => 'Add Product';

  @override
  String get submitLabel => 'Add Product';

  @override
  List<EzField> get fields => [
        EzField.text('name', label: 'Product Name', required: true, icon: Icons.label),
        EzField.textArea('description', label: 'Description', required: true, hint: 'Describe your product...'),
        EzField.currency('price', label: 'Price', required: true, symbol: '\$'),
        EzField.select('category', label: 'Category', required: true, options: [
          'Electronics',
          'Sports',
          'Home',
          'Stationery',
          'Fashion',
          'Food',
          'Other',
        ]),
        EzField.toggle('inStock', label: 'In Stock'),
        EzField.text('imageUrl', label: 'Image URL', icon: Icons.image, hint: 'https://...'),
      ];

  @override
  Future<void> Function(Map<String, dynamic> data) get onSubmit =>
      (data) async {
        final product = Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: data['name'] as String? ?? '',
          description: data['description'] as String? ?? '',
          price: (data['price'] as double?) ?? 0,
          category: data['category'] as String? ?? 'Other',
          inStock: data['inStock'] as bool? ?? true,
          imageUrl: data['imageUrl'] as String?,
          createdAt: DateTime.now(),
        );
        await getIt<ProductService>().addProduct(product);
      };
}
