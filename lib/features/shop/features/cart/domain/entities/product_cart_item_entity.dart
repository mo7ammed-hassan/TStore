import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';


class ProductCartItemEntity {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final ProductVariationModel variation;
  final String brand;

  ProductCartItemEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.variation,
      required this.brand});

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
