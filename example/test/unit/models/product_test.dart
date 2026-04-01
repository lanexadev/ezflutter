import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/models/cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product', () {
    test('creates with required fields', () {
      const product = Product(
        id: '1',
        name: 'Test',
        description: 'Desc',
        price: 9.99,
        category: 'Other',
      );
      expect(product.name, equals('Test'));
      expect(product.inStock, isTrue);
      expect(product.imageUrl, isNull);
    });

    test('serializes to JSON and back', () {
      final product = Product(
        id: '1',
        name: 'Test',
        description: 'Desc',
        price: 9.99,
        category: 'Other',
        createdAt: DateTime(2024, 1, 1),
      );
      final json = product.toJson();
      final restored = Product.fromJson(json);
      expect(restored, equals(product));
    });

    test('copyWith creates modified copy', () {
      const original = Product(
        id: '1',
        name: 'Test',
        description: 'Desc',
        price: 9.99,
        category: 'Other',
      );
      final modified = original.copyWith(price: 19.99, inStock: false);
      expect(modified.price, equals(19.99));
      expect(modified.inStock, isFalse);
      expect(modified.name, equals('Test'));
    });
  });

  group('CartItem', () {
    test('computes total correctly', () {
      const item = CartItem(
        product: Product(
          id: '1',
          name: 'Test',
          description: 'Desc',
          price: 10.0,
          category: 'Other',
        ),
        quantity: 3,
      );
      expect(item.total, equals(30.0));
    });

    test('defaults to quantity 1', () {
      const item = CartItem(
        product: Product(
          id: '1',
          name: 'Test',
          description: 'Desc',
          price: 5.0,
          category: 'Other',
        ),
      );
      expect(item.quantity, equals(1));
      expect(item.total, equals(5.0));
    });
  });
}
