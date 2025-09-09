import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
     bool? isFeatured,
    bool? isPopular,
    String? categoryId,
    String? brandId,
    List<String>? productIds,
    int limit = 10,
    DocumentSnapshot? startAfter,
  });
}
