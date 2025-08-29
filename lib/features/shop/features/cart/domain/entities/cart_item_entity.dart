import 'package:t_store/features/shop/features/cart/domain/entities/product_cart_item_entity.dart';

class CartItemEntity {
  final String? id;
  final ProductCartItemEntity product;
  final int quantity;

  double get totalPrice => product.price * quantity;

  CartItemEntity({this.id, required this.product, required this.quantity});

  static CartItemEntity empty() {
    return CartItemEntity(
      id: '',
      product: ProductCartItemEntity.empty(),
      quantity: 0,
    );
  }

  CartItemEntity copyWith({int? quantity, double? price}) {
    final updatedProduct =
        price != null ? product.copyWith(price: price) : product;

    return CartItemEntity(
      id: id,
      product: updatedProduct,
      quantity: quantity ?? this.quantity,
    );
  }
}
