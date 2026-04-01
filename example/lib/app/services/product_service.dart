import 'package:injectable/injectable.dart';
import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/core/error/result.dart';
import 'package:ezflutter/core/ez/ez_service.dart';

@singleton
class ProductService extends EzService {
  final List<Product> _products = _mockProducts;

  Future<Result<List<Product>>> getProducts() => guard(() async {
        // Simulate network delay
        await Future<void>.delayed(const Duration(milliseconds: 500));
        return List.unmodifiable(_products);
      });

  Future<Result<Product>> getProduct(String id) => guard(() async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        return _products.firstWhere((p) => p.id == id);
      });

  Future<Result<List<Product>>> getProductsByCategory(String category) =>
      guard(() async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        return _products.where((p) => p.category == category).toList();
      });

  Future<Result<Product>> addProduct(Product product) => guard(() async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        _products.add(product);
        return product;
      });

  Future<Result<void>> deleteProduct(String id) => guard(() async {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        _products.removeWhere((p) => p.id == id);
      });

  List<String> get categories =>
      _products.map((p) => p.category).toSet().toList()..sort();
}

final List<Product> _mockProducts = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    description:
        'Premium noise-cancelling wireless headphones with 30h battery life. '
        'Features adaptive EQ, multi-device pairing, and comfortable over-ear design.',
    price: 149.99,
    category: 'Electronics',
    imageUrl: 'https://picsum.photos/seed/headphones/400/400',
    createdAt: DateTime(2024, 1, 15),
  ),
  Product(
    id: '2',
    name: 'Leather Notebook',
    description:
        'Handcrafted Italian leather journal with 240 lined pages. '
        'Perfect for daily journaling, sketching, or note-taking.',
    price: 34.99,
    category: 'Stationery',
    imageUrl: 'https://picsum.photos/seed/notebook/400/400',
    createdAt: DateTime(2024, 2, 20),
  ),
  Product(
    id: '3',
    name: 'Running Shoes',
    description:
        'Lightweight running shoes with responsive cushioning and breathable mesh upper. '
        'Engineered for long-distance comfort.',
    price: 89.99,
    category: 'Sports',
    imageUrl: 'https://picsum.photos/seed/shoes/400/400',
    createdAt: DateTime(2024, 3, 5),
  ),
  Product(
    id: '4',
    name: 'Ceramic Mug Set',
    description: 'Set of 4 handmade ceramic mugs in earth tones. '
        'Microwave and dishwasher safe. 350ml capacity each.',
    price: 42.00,
    category: 'Home',
    imageUrl: 'https://picsum.photos/seed/mugs/400/400',
    createdAt: DateTime(2024, 3, 10),
    inStock: false,
  ),
  Product(
    id: '5',
    name: 'Mechanical Keyboard',
    description:
        'Compact 75% mechanical keyboard with hot-swappable switches, '
        'RGB backlighting, and USB-C connectivity.',
    price: 119.00,
    category: 'Electronics',
    imageUrl: 'https://picsum.photos/seed/keyboard/400/400',
    createdAt: DateTime(2024, 4, 1),
  ),
  Product(
    id: '6',
    name: 'Yoga Mat',
    description:
        'Extra thick 6mm eco-friendly TPE yoga mat with alignment lines. '
        'Non-slip surface on both sides.',
    price: 29.99,
    category: 'Sports',
    imageUrl: 'https://picsum.photos/seed/yogamat/400/400',
    createdAt: DateTime(2024, 4, 15),
  ),
  Product(
    id: '7',
    name: 'Desk Lamp',
    description:
        'LED desk lamp with adjustable color temperature (3000K-6500K), '
        '5 brightness levels, and wireless charging base.',
    price: 59.99,
    category: 'Home',
    imageUrl: 'https://picsum.photos/seed/lamp/400/400',
    createdAt: DateTime(2024, 5, 1),
  ),
  Product(
    id: '8',
    name: 'Fountain Pen',
    description:
        'Premium fountain pen with 14K gold nib. Includes converter for bottled ink. '
        'Comes in a gift box.',
    price: 75.00,
    category: 'Stationery',
    imageUrl: 'https://picsum.photos/seed/pen/400/400',
    createdAt: DateTime(2024, 5, 20),
  ),
];
