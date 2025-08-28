import 'package:t_store/features/shop/features/all_brands/data/mapper/brand_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_attribute_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_variation_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
import 'package:t_store/features/shop/features/cart/data/models/product_cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/product_cart_item_entity.dart';

extension ProductEntityMapper on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      stock: stock,
      price: price,
      title: title,
      sku: sku,
      date: date,
      salePrice: salePrice ?? 0.0,
      thumbnail: thumbnail,
      isFeatured: isFeatured,
      brand: brand?.toModel(),
      description: description,
      categoryId: categoryId,
      images: images ?? const [],
      productType: productType,
      productAttributes: productAttributes.map((e) => e.toModel()).toList(),
      productVariations:
          productVariations?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}

extension ProductModelMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      stock: stock,
      price: price,
      title: title,
      sku: sku,
      date: date,
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

extension ProductEntityCartItemMapper on ProductEntity {
  ProductCartItemEntity toCartItemProductEntity(
      {ProductVariationEntity? variation}) {
    final hasVariation = variation != null;

    return ProductCartItemEntity(
      id: id,
      title: title,
      price: _calculatePrice(
        basePrice: price.toDouble(),
        salePrice: salePrice,
        variationPrice: variation?.price.toDouble(),
        variationSalePrice: variation?.salePrice,
      ),
      imageUrl: variation?.image ?? '',
      variation:
          hasVariation ? variation.toModel() : ProductVariationModel.empty(),
      brand: brand?.name ?? '',
    );
  }
}

extension ProductModelCartItemMapper on ProductModel {
  ProductCartItemModel toCartItemProductModel(
      {ProductVariationModel? variation}) {
    final hasVariation = variation != null;
    return ProductCartItemModel(
      id: id,
      title: title,
      price: _calculatePrice(
        basePrice: price.toDouble(),
        salePrice: salePrice,
        variationPrice: variation?.price.toDouble(),
        variationSalePrice: variation?.salePrice,
      ),
      imageUrl: variation?.image,
      variation: hasVariation ? variation : ProductVariationModel.empty(),
      brand: brand?.name ?? '',
    );
  }
}

double _calculatePrice({
  required double basePrice,
  double? salePrice,
  double? variationPrice,
  double? variationSalePrice,
}) {
  if (variationSalePrice != null && variationSalePrice > 0) {
    return variationSalePrice;
  } else if (variationPrice != null) {
    return variationPrice;
  } else if (salePrice != null && salePrice > 0) {
    return salePrice;
  }
  return basePrice;
}
