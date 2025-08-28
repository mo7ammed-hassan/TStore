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
      images: images ?? [],
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

extension ProductToProductCartItemModelMapper on ProductEntity {
  ProductCartItemEntity toCartItemProductEntity(
      {ProductVariationEntity? variation}) {
    final hasVariation = variation != null;
    final hasSalePrice = !hasVariation && salePrice != null;

    return ProductCartItemEntity(
      id: id,
      title: title,
      price: hasVariation
          ? variation.price.toDouble()
          : hasSalePrice
              ? (salePrice! > 0 ? salePrice! : price.toDouble())
              : price.toDouble(),
      imageUrl: variation?.image ?? '',
      variation:
          hasVariation ? variation.toModel() : ProductVariationModel.empty(),
      brand: brand?.name ?? '',
    );
  }
}

extension ProductToProductCartItemEntityMapper on ProductModel {
  ProductCartItemModel toCartItemProductModel(
      {ProductVariationModel? variation}) {
    final hasVariation = variation != null;
    return ProductCartItemModel(
      id: id,
      title: title,
      price: hasVariation
          ? variation.price.toDouble()
          : salePrice > 0
              ? salePrice
              : price.toDouble(),
      imageUrl: variation?.image,
      variation: hasVariation ? variation : ProductVariationModel.empty(),
      brand: brand?.name ?? '',
    );
  }
}
