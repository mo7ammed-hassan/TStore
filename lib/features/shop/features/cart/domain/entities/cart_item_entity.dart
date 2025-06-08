import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/utils/constants/images_strings.dart';

class CartItemEntity {
  final String title;
  final String? imageUrl;
  final int quantity;
  final double price;
  final String? variationId;
  final String productId;
  final String? brandName;
  final Map<String, dynamic>? selectedVariation;

  CartItemEntity({
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.variationId,
    required this.productId,
    required this.brandName,
    required this.selectedVariation,
  });

  // --empty--
  CartItemEntity.empty()
      : title = '',
        imageUrl = TImages.productImage1,
        quantity = 0,
        price = 0.0,
        variationId = null,
        productId = '',
        brandName = null,
        selectedVariation = {};

  // -- toJson

  Map<String, dynamic> toJson() => CartItemModel.fromEntity(this).toJson();
}

extension CartItemEntityExtension on CartItemEntity {
  CartItemModel toModel() => CartItemModel.fromEntity(this);
}
