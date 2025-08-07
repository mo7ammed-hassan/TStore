import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/cart/data/models/product_cart_item_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 2)
class CartItemModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final ProductCartItemModel product;
  @HiveField(2)
  final int quantity;

  double get totalPrice => product.variation!.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        product: json['product'], id: json['id'], quantity: json['quantity']);
  }

  CartItemModel(
      {required this.product, required this.id, required this.quantity});

  Map<String, dynamic> toJson() => {
        'id': id,
        'product': product,
        'quantity': quantity,
      };

  CartItemModel copyWith({
    ProductCartItemModel? product,
    String? id,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
