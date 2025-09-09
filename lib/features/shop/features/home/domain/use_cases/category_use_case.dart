import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/home/domain/repository/category_repositoy.dart';
import 'package:t_store/core/config/service_locator.dart';

class CategoryUseCase
    extends UseCases<Either<String, List<CategoryEntity>>, dynamic> {
  @override
  Future<Either<String, List<CategoryEntity>>> call({params}) async {
    return await getIt<CategoryRepository>().getAllCategories();
  }
}
