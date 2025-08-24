import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/repository/product_repository.dart';
import 'package:t_store/config/service_locator.dart';

class GetFeturedProductsUseCase
    extends UseCases<Either<dynamic, List<ProductEntity>>, int> {
  @override
  Future<Either<dynamic, List<ProductEntity>>> call({int? params}) async {
    return await getIt<ProductRepository>().getFeaturedProducts(limit: params!);
  }
}
