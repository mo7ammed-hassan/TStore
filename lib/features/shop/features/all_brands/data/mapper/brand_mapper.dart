
import 'package:t_store/features/shop/features/all_brands/data/models/brand_model.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';

/// Extension to convert BrandModel -> BrandEntity
extension BrandModelMapper on BrandModel {
  BrandEntity toEntity() {
    return BrandEntity(
      id: id,
      name: name,
      image: image,
      isFeatured: isFeatured,
      productCount: productCount,
    );
  }
}

/// Extension to convert BrandEntity -> BrandModel
extension BrandEntityMapper on BrandEntity {
  BrandModel toModel() {
    return BrandModel(
      id: id,
      name: name,
      image: image,
      isFeatured: isFeatured ?? false,
      productCount: productCount ?? 0,
    );
  }
}
