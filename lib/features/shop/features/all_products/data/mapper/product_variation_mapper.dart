import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';

extension ProductVariationModelMapper on ProductVariationModel {
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

extension ProductVariationEntityMapper on ProductVariationEntity {
  ProductVariationModel toModel() {
    return ProductVariationModel(
      id: id,
      sku: sku,
      image: image,
      description: description,
      price: price,
      salePrice: salePrice,
      stock: stock,
      attributeValues: attributeValues,
    );
  }
}
