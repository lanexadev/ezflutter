import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/services/product_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductService service;

  setUp(() {
    service = ProductService();
  });

  group('ProductService', () {
    test('getProducts returns mock products', () async {
      final result = await service.getProducts();
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, isNotNull);
      expect(result.dataOrNull!.length, greaterThanOrEqualTo(8));
    });

    test('getProduct returns product by id', () async {
      final result = await service.getProduct('1');
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull?.name, equals('Wireless Headphones'));
    });

    test('getProduct fails for unknown id', () async {
      final result = await service.getProduct('unknown');
      expect(result.isFailure, isTrue);
    });

    test('getProductsByCategory filters correctly', () async {
      final result = await service.getProductsByCategory('Electronics');
      expect(result.isSuccess, isTrue);
      final products = result.dataOrNull!;
      expect(products.every((p) => p.category == 'Electronics'), isTrue);
    });

    test('addProduct adds to list', () async {
      const newProduct = Product(
        id: '99',
        name: 'Test Product',
        description: 'A test',
        price: 9.99,
        category: 'Other',
      );
      final addResult = await service.addProduct(newProduct);
      expect(addResult.isSuccess, isTrue);

      final listResult = await service.getProducts();
      expect(
        listResult.dataOrNull?.any((p) => p.id == '99'),
        isTrue,
      );
    });

    test('deleteProduct removes from list', () async {
      await service.deleteProduct('1');
      final result = await service.getProducts();
      expect(
        result.dataOrNull?.any((p) => p.id == '1'),
        isFalse,
      );
    });

    test('categories returns distinct sorted categories', () {
      final cats = service.categories;
      expect(cats, contains('Electronics'));
      expect(cats, contains('Sports'));
      expect(cats, equals(List.from(cats)..sort()));
    });
  });
}
