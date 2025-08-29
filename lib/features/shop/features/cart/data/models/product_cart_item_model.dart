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

  ProductCartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.variation,
    required this.brand,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'variation': variation?.toJson(),
      'brand': brand,
    };
  }

  factory ProductCartItemModel.fromJson(Map<String, dynamic> json) {
    return ProductCartItemModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : null,
      imageUrl: json['imageUrl'] as String?,
      variation: json['variation'] != null
          ? ProductVariationModel.fromJson(json['variation'])
          : null,
      brand: json['brand'] as String?,
    );
  }
}
