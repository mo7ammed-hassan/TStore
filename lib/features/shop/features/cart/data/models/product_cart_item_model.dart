import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';

part 'product_cart_item_model.g.dart';

@HiveType(typeId: 3)
class ProductCartItemModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? imageUrl;
  @HiveField(4)
  final ProductVariationModel? variation;
  @HiveField(5)
  final String? brand;

  ProductCartItemModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.variation,
      required this.brand});
}
