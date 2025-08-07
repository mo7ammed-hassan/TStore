// import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
// import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
// import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';

// class CartItemMapper {
//   static CartItemModel fromProductEntity({
//     required ProductEntity product,
//     required int quantity,
//     required ProductVariationEntity? selectedVariation,
//   }) {
//     final isVariationSelected = selectedVariation?.id.isNotEmpty ?? false;

//     final price = isVariationSelected
//         ? (selectedVariation!.salePrice > 0.0
//             ? selectedVariation.salePrice
//             : selectedVariation.price)
//         : ((product.salePrice ?? 0.0) > 0.0
//             ? product.salePrice!
//             : product.price);

//     return CartItemModel(
//       productId: product.id,
//       title: product.title,
//       imageUrl:
//           isVariationSelected ? selectedVariation!.image : product.thumbnail,
//       quantity: quantity,
//       price: price.toDouble(),
//       brandName: product.brand?.name ?? '',
//       variationId: selectedVariation?.id ?? '',
//       selectedVariation:
//           isVariationSelected ? selectedVariation!.attributeValues : null,
//     );
//   }
// }
