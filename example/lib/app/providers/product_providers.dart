import 'package:ezflutter/app/models/product.dart';
import 'package:ezflutter/app/models/cart_item.dart';
import 'package:ezflutter/app/services/product_service.dart';
import 'package:ezflutter/core/di/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_providers.g.dart';

@riverpod
Future<List<Product>> products(Ref ref) async {
  final service = getIt<ProductService>();
  final result = await service.getProducts();
  return result.when(
    success: (data) => data,
    failure: (error) => throw Exception(error.message),
  );
}

@riverpod
Future<Product> product(Ref ref, String id) async {
  final service = getIt<ProductService>();
  final result = await service.getProduct(id);
  return result.when(
    success: (data) => data,
    failure: (error) => throw Exception(error.message),
  );
}

@riverpod
Future<List<Product>> productsByCategory(Ref ref, String category) async {
  final service = getIt<ProductService>();
  final result = await service.getProductsByCategory(category);
  return result.when(
    success: (data) => data,
    failure: (error) => throw Exception(error.message),
  );
}

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  List<CartItem> build() => [];

  void addToCart(Product product) {
    final existing = state.indexWhere((i) => i.product.id == product.id);
    if (existing >= 0) {
      final item = state[existing];
      state = [
        ...state.sublist(0, existing),
        item.copyWith(quantity: item.quantity + 1),
        ...state.sublist(existing + 1),
      ];
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(String productId) {
    state = state.where((i) => i.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    state = state.map((i) {
      if (i.product.id == productId) return i.copyWith(quantity: quantity);
      return i;
    }).toList();
  }

  void clear() => state = [];

  double get total => state.fold(0, (sum, item) => sum + item.total);
  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
}
