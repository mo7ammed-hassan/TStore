import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call({
    bool? isFeatured,
    bool? isPopular,
    String? categoryId,
    String? brandId,
    List<String>? productIds,
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) {
    return repository.getProducts(
      isFeatured: isFeatured,
      isPopular: isPopular,
      categoryId: categoryId,
      brandId: brandId,
      productIds: productIds,
      limit: limit,
      startAfter: startAfter,
    );
  }
}
