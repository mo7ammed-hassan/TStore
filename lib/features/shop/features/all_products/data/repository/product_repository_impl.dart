import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/all_products/data/source/product_firebase_services.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(this.productFirebaseServices);

  final ProductFirebaseServices productFirebaseServices;

  @override
  Future<Either<dynamic, List<ProductEntity>>> getPopularProducts() async {
    var retunedData = await productFirebaseServices.getAllProducts();

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<Either<dynamic, List<ProductEntity>>> getFeaturedProducts(
      {int limit = 4}) async {
    var retunedData =
        await productFirebaseServices.getFeaturedProducts(limit: limit);

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<Either<dynamic, List<ProductEntity>>> getAllFeaturedProducts(
      {required int limit}) async {
    var retunedData =
        await productFirebaseServices.getAllFeaturedProducts(limit: limit);

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<Either<dynamic, List<ProductEntity>>> getAllPopularProducts(
      {required int limit}) async {
    var retunedData =
        await productFirebaseServices.getAllPopularProducts(limit: limit);

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<Either<dynamic, List<ProductEntity>>> getAllProductsByBrand(
      {required String brandId, required int limit}) async {
    var retunedData = await productFirebaseServices.getAllProductsByBrand(
        brandId: brandId, limit: limit);

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<Either<dynamic, List<ProductEntity>>> getAllProductsSpecificCategory(
      {required String categoryId, required int limit}) async {
    var retunedData = await productFirebaseServices
        .getAllProductsSpecificCategory(categoryId: categoryId, limit: limit);

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<Either<dynamic, List<ProductEntity>>> fetchWishlistProducts(
      {required List<String> productIds}) async {
    var retunedData = await productFirebaseServices.getFavoriteProducts(
        productIds: productIds);

    return retunedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        List<ProductEntity> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).toEntity())
            .toList();

        return Right(products);
      },
    );
  }
}
