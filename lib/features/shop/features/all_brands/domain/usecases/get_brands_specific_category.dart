import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/core/models/get_all_products_param_model.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/domain/repository/brands_repository.dart';

class GetBrandsSpecificCategory
    extends UseCases<Either<dynamic, List<BrandEntity>>, GetAllParams> {
  final BrandsRepository repository;

  GetBrandsSpecificCategory(this.repository);

  @override
  Future<Either<dynamic, List<BrandEntity>>> call(
      {GetAllParams? params}) async {
    return await repository.getBrandSpecificCategory(
        categoryId: params!.id, limit: params.limit);
  }
}
