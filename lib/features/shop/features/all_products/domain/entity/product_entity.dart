import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_attribute_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';

/// final >>  immutabl
class ProductEntity {
  final String id;
  final int stock;
  final num price;
  final String title;
  final String sku;
  final DateTime? date;
  final double? salePrice;
  final String thumbnail;
  final bool? isFeatured;
  final BrandEntity? brand;
  final String? description;
  final String? categoryId;
  final List<String>? images;
  final String productType;
  final List<ProductAttributeEntity> productAttributes;
  final List<ProductVariationEntity>? productVariations;

  String get productPrice {
    if (productType == ProductType.single.toString()) {
      return (salePrice != null && salePrice! > 0)
          ? salePrice!.toString()
          : price.toString();
    }

    double smallestPrice = double.infinity;
    double largestPrice = 0;

    for (var variation in productVariations!) {
      double priceToConsider =
          (variation.salePrice > 0.0) ? variation.salePrice : variation.price;

      if (priceToConsider < smallestPrice) {
        smallestPrice = priceToConsider;
      }
      if (priceToConsider > largestPrice) {
        largestPrice = priceToConsider;
      }
    }

    return smallestPrice == largestPrice
        ? largestPrice.toString()
        : '$smallestPrice - $largestPrice';
  }

  /// Calculate the discount percentage
  String get discountPercentage {
    if (productType == ProductType.single.toString()) {
      if (salePrice != null && salePrice! > 0 && price > 0) {
        return (((price - salePrice!) / price) * 100).toStringAsFixed(1);
      }
      return '0';
    } else {
      double maxDiscount = 0;

      for (var variation in productVariations ?? []) {
        if (variation.salePrice > 0 && variation.price > 0) {
          double discount =
              ((variation.price - variation.salePrice) / variation.price) * 100;
          if (discount > maxDiscount) {
            maxDiscount = discount;
          }
        }
      }

      return maxDiscount.toStringAsFixed(1);
    }
  }

  String get getPrroductStockStatus {
    return stock > 0 ? 'In stock' : 'Out stock';
  }

  const ProductEntity({
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

  // Empty product entity
  const ProductEntity.empty()
      : id = '',
        stock = 0,
        price = 0,
        title = 'product title',
        sku = '',
        date = null,
        salePrice = 0,
        thumbnail = TImages.defaultProductImage,
        isFeatured = false,
        brand = null,
        description = '',
        categoryId = '',
        images = const [],
        productType = '',
        productAttributes = const [],
        productVariations = const [];
}
