import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/domain/repository/brands_repository.dart';

class GetAllBrandsUseCase
    extends UseCases<Either<dynamic, List<BrandEntity>>, int> {
  final BrandsRepository repository;

  GetAllBrandsUseCase(this.repository);

  @override
  Future<Either<dynamic, List<BrandEntity>>> call({int? params}) async {
    return await repository.getAllBrands(limit: params!);
  }
}
