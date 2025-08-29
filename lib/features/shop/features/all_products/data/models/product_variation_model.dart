import 'package:hive/hive.dart';

part 'product_variation_model.g.dart';

@HiveType(typeId: 6)
class ProductVariationModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? sku;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final double? salePrice;

  @HiveField(6)
  final int stock;

  @HiveField(7)
  final Map<String, String> attributeValues;

  const ProductVariationModel({
    required this.id,
    this.sku,
    required this.image,
    this.description,
    required this.price,
    this.salePrice,
    required this.stock,
    this.attributeValues = const {},
  });

  ProductVariationModel copyWith({
    String? id,
    String? sku,
    String? image,
    String? description,
    double? price,
    double? salePrice,
    int? stock,
    Map<String, String>? attributeValues,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }

  static ProductVariationModel empty() => const ProductVariationModel(
        id: '',
        sku: '',
        image: '',
        description: '',
        price: 0.0,
        salePrice: 0.0,
        stock: 0,
        attributeValues: {},
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sku': sku,
        'image': image,
        'description': description,
        'price': price,
        'salePrice': salePrice,
        'stock': stock,
        'attributeValues': attributeValues,
      };

  factory ProductVariationModel.fromJson(Map<String, dynamic> data) =>
      ProductVariationModel(
        id: data['id'] ?? '',
        sku: data['sku'],
        image: data['image'] ?? '',
        description: data['description'],
        price: (data['price'] ?? 0.0 as num).toDouble(),
        salePrice: data['salePrice'] != null
            ? (data['salePrice'] as num).toDouble()
            : null,
        stock: data['stock'] ?? 0,
        attributeValues:
            Map<String, String>.from(data['attributeValues'] ?? {}),
      );
}
