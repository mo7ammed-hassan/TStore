import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/common/models/get_all_products_param_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/repository/product_repository.dart';
import 'package:t_store/config/service_locator.dart';

class GetProductsSpecificCategoryUseCase
    extends UseCases<Either<dynamic, List<ProductEntity>>, GetAllParams> {
  @override
  Future<Either<dynamic, List<ProductEntity>>> call(
      {GetAllParams? params}) async {
    return await getIt<ProductRepository>()
        .getAllProductsSpecificCategory(categoryId: params!.id,limit: params.limit);
  }
}
