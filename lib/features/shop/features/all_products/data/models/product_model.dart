import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/all_brands/data/models/brand_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_attribute_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';
import 'package:t_store/utils/constants/images_strings.dart';

part 'product_model.g.dart';

@HiveType(typeId: 4)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int stock;

  @HiveField(2)
  final num price;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String sku;

  @HiveField(5)
  final DateTime? date;

  @HiveField(6)
  final double salePrice;

  @HiveField(7)
  final String thumbnail;

  @HiveField(8)
  final bool? isFeatured;

  @HiveField(9)
  final BrandModel? brand;

  @HiveField(10)
  final String? description;

  @HiveField(11)
  final String? categoryId;

  @HiveField(12)
  final List<String> images;

  @HiveField(13)
  final String productType;

  @HiveField(14)
  final List<ProductAttributeModel> productAttributes;

  @HiveField(15)
  final List<ProductVariationModel> productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.sku,
    this.date,
    required this.salePrice,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images = const [],
    required this.productType,
    this.productAttributes = const [],
    this.productVariations = const [],
  });

  static ProductModel empty() {
    return ProductModel(
      id: '100',
      stock: 0,
      price: 0.0,
      title: '',
      sku: '',
      date: null,
      salePrice: 0.0,
      thumbnail: TImages.defaultProductImage,
      isFeatured: false,
      brand: null,
      description: '',
      categoryId: '',
      productType: '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'stock': stock,
      'price': price.toDouble(),
      'title': title,
      'sku': sku,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'brand': brand?.toJson(),
      'description': description,
      'categoryId': categoryId,
      'images': images,
      'productType': productType,
      'productAttributes': productAttributes.map((e) => e.toJson()).toList(),
      'productVariations': productVariations.map((e) => e.toJson()).toList(),
    };
  }

  factory ProductModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      stock: data['stock'] ?? 0,
      price: data['price'] ?? 0.0,
      title: data['title'] ?? '',
      sku: data['sku'] ?? '',
      date: data['date'] != null
          ? DateTime.tryParse(data['date'] as String)
          : null,
      salePrice: (data['salePrice'] ?? 0.0).toDouble(),
      thumbnail: data['thumbnail'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      description: data['description'] ?? '',
      categoryId: data['categoryId'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      productType: data['productType'] ?? '',
      productAttributes: (data['productAttributes'] as List<dynamic>?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          const [],
      productVariations: (data['productVariations'] as List<dynamic>?)
              ?.map((e) => ProductVariationModel.fromJson(e))
              .toList() ??
          const [],
    );
  }
}
