import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';

class ProductCartItemEntity {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final ProductVariationModel variation;
  final String brand;

  ProductCartItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.variation,
    required this.brand,
  });

  ProductCartItemEntity copyWith({
    ProductVariationModel? variation,
    double? price,
  }) {
    final updatedVariation = variation != null
        ? variation.copyWith(price: price ?? variation.price)
        : this.variation.copyWith(price: price ?? this.variation.price);

    return ProductCartItemEntity(
      id: id,
      title: title,
      price: price ?? this.price,
      imageUrl: imageUrl,
      variation: updatedVariation,
      brand: brand,
    );
  }

  static ProductCartItemEntity empty() {
    return ProductCartItemEntity(
      id: '',
      title: '',
      price: 0.0,
      imageUrl: '',
      variation: ProductVariationModel.empty(),
      brand: '',
    );
  }
}
