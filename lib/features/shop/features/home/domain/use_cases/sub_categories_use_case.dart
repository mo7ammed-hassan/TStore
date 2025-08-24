import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/home/domain/repository/category_repositoy.dart';
import 'package:t_store/config/service_locator.dart';

class SubCategoriesUseCase
    extends UseCases<Either<String, List<CategoryEntity>>, String> {
  @override
  Future<Either<String, List<CategoryEntity>>> call({String? params}) async {
    return await getIt<CategoryRepository>().getSubCategories(params!);
  }
}
