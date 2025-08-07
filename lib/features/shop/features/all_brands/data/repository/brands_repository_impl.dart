import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/all_brands/data/mapper/brand_mapper.dart';
import 'package:t_store/features/shop/features/all_brands/data/models/brand_model.dart';
import 'package:t_store/features/shop/features/all_brands/data/source/brands_firebase_services.dart';
import 'package:t_store/features/shop/features/all_brands/domain/repository/brands_repository.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';

class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsFirebaseServices brandsServices;

  BrandsRepositoryImpl(this.brandsServices);
  @override
  Future<Either<String, List<BrandEntity>>> getAllBrands(
      {required int limit}) async {
    var data = await brandsServices.getAllBrands(limit: 16);

    return data.fold(
      (error) => Left(error),
      (data) {
        List<BrandEntity> brands = List.from(data)
            .map((document) => BrandModel.fromJson(document.data()).toEntity())
            .toList();

        return Right(brands);
      },
    );
  }

  @override
  Future<Either<String, List<BrandEntity>>> getFeaturedBrands(
      {required int limit}) async {
    var data = await brandsServices.getFeaturedBrands(limit: limit);

    return data.fold(
      (error) => Left(error),
      (data) {
        List<BrandEntity> brands = List.from(data)
            .map((document) => BrandModel.fromJson(document.data()).toEntity())
            .toList();

        return Right(brands);
      },
    );
  }

  @override
  Future<Either<String, List<BrandEntity>>> getBrandSpecificCategory(
      {required String categoryId, required int limit}) async {
    var data = await brandsServices.getBrandSpecificCategory(
        categoryId: categoryId, limit: limit);

    return data.fold(
      (error) => Left(error),
      (data) {
        List<BrandEntity> brands = List.from(data)
            .map((document) => BrandModel.fromJson(document.data()).toEntity())
            .toList();

        return Right(brands);
      },
    );
  }
}
