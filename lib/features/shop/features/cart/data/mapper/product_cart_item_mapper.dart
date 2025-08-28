import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/models/product_cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/product_cart_item_entity.dart';

extension ProductCartItemMapper on ProductCartItemModel {
  ProductCartItemEntity toEntity() {
    return ProductCartItemEntity(
      id: id ?? '',
      title: title ?? '',
      price: price ?? 0.0,
      imageUrl: imageUrl ?? '',
      variation: variation ?? ProductVariationModel.empty(),
      brand: brand ?? '',
    );
  }
}

extension ProductCartItemModelMapper on ProductCartItemEntity {
  ProductCartItemModel toModel() {
    return ProductCartItemModel(
      id: id,
      imageUrl: imageUrl,
      title: title,
      price: price,
      variation: variation,
      brand: brand,
    );
  }
}

extension ProductCartItemToCartItemModelMapper on ProductCartItemModel {
  CartItemModel toCartItemModel({int quantity = 1}) {
    return CartItemModel(
      id: '',
      product: this,
      quantity: quantity,
    );
  }
}

extension ProductCartItemToCartItemEntityMapper on ProductCartItemEntity {
  CartItemEntity toCartItemModel({int quantity = 1}) {
    return CartItemEntity(
      id: '',
      product: this,
      quantity: quantity,
    );
  }
}
