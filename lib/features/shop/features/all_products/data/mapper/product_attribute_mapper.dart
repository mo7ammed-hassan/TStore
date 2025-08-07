import 'package:t_store/features/shop/features/all_products/data/models/product_attribute_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_attribute_entity.dart';

/// Extension to convert ProductAttributeModel -> ProductAttributeEntity
extension ProductAttributeModelMapper on ProductAttributeModel {
  ProductAttributeEntity toEntity() {
    return ProductAttributeEntity(
      name: name,
      values: values,
    );
  }
}

/// Extension to convert ProductAttributeEntity -> ProductAttributeModel
extension ProductAttributeEntityMapper on ProductAttributeEntity {
  ProductAttributeModel toModel() {
    return ProductAttributeModel(
      name: name,
      values: values,
    );
  }
}
