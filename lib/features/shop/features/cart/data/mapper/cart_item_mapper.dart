import 'package:t_store/features/shop/features/cart/data/mapper/product_cart_item_mapper.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';

extension CartItemMapper on CartItemModel {
  /// Converts a [CartItemModel] to a [CartItemEntity].
  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      product: product.toEntity(),
      quantity: quantity,
    );
  }
}

/// Converts a [CartItemEntity] to a [CartItemModel].
extension CartModelMapper on CartItemEntity {
  CartItemModel toModel() {
    return CartItemModel(
      id: id ?? '',
      product: product.toModel(),
      quantity: quantity,
    );
  }
}
