import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/features/all_brands/data/models/brand_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_attribute_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/utils/constants/images_strings.dart';

class ProductModel {
  final String id;
  final int stock;
  final num price;
  final String title;
  final String sku;
  final DateTime? date;
  final double salePrice;
  final String thumbnail;
  final bool? isFeatured;
  final BrandModel? brand;
  final String? description;
  final String? categoryId;
  final List<String> images;
  final String productType;
  final List<ProductAttributeModel> productAttributes;
  final List<ProductVariationModel> productVariations;

  const ProductModel({
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
    return const ProductModel(
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

extension ProductXModel on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      stock: stock,
      price: price,
      title: title,
      sku: sku,
      salePrice: salePrice,
      thumbnail: thumbnail,
      isFeatured: isFeatured,
      brand: brand?.toEntity(),
      description: description,
      categoryId: categoryId,
      images: images,
      productType: productType,
      productAttributes: productAttributes.map((e) => e.toEntity()).toList(),
      productVariations: productVariations.map((e) => e.toEntity()).toList(),
    );
  }
}
