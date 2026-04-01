import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ezflutter/app/models/product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required Product product,
    @Default(1) int quantity,
  }) = _CartItem;

  const CartItem._();

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  double get total => product.price * quantity;
}
