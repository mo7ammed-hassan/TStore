import 'package:t_store/features/shop/features/all_brands/data/mapper/brand_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_attribute_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_variation_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';

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

