import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/source/product_remote_data_source.dart.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    bool? isFeatured,
    bool? isPopular,
    String? categoryId,
    String? brandId,
    List<String>? productIds,
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        isFeatured: isFeatured,
        isPopular: isPopular,
        categoryId: categoryId,
        brandId: brandId,
        productIds: productIds,
        limit: limit,
        startAfter: startAfter
      );
      final productsList = products.map((e) => e.toEntity()).toList();
      return Right(productsList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
