import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';

abstract class SubCategoryState {}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategoryLoaded extends SubCategoryState {
  final List<CategoryEntity> subCategories;
  SubCategoryLoaded(this.subCategories);
}

class SubCategoryFailure extends SubCategoryState {
  final String error;
  SubCategoryFailure(this.error);
}

/// sub category products
class SubCategoryProductsLoaded extends SubCategoryState {
  final List<ProductEntity> products;
  SubCategoryProductsLoaded(this.products);
}

class SubCategoryProductsFailure extends SubCategoryState {
  final String error;
  SubCategoryProductsFailure(this.error);
}

class SubCategoryProductsLoading extends SubCategoryState {}
