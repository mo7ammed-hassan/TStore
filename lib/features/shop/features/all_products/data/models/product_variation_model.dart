import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';

class ProductVariationModel {
  final String id;
  final String? sku;
  final String image;
  final String? description;
  final double price;
  final double? salePrice;
  final int stock;
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

  static ProductVariationModel empty() {
    return const ProductVariationModel(
      id: '',
      sku: '',
      image: '',
      description: '',
      price: 0.0,
      salePrice: 0.0,
      stock: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> data) {
    return ProductVariationModel(
      id: data['id'] ?? '',
      sku: data['sku'],
      image: data['image'] ?? '',
      description: data['description'],
      price: (data['price'] ?? 0.0).toDouble(),
      salePrice: data['salePrice'] != null
          ? (data['salePrice'] as num).toDouble()
          : null,
      stock: data['stock'] ?? 0,
      attributeValues: Map<String, String>.from(data['attributeValues'] ?? {}),
    );
  }
}

extension ProductVariationXModel on ProductVariationModel {
  ProductVariationEntity toEntity() {
    return ProductVariationEntity(
      id: id,
      sku: sku,
      image: image,
      description: description,
      price: price,
      salePrice: salePrice ?? 0.0,
      stock: stock,
      attributeValues: attributeValues,
    );
  }
}
