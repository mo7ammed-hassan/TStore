import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/home/data/models/category_model.dart';
import 'package:t_store/features/shop/features/home/data/source/remote/category_firebase_services.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/home/domain/repository/category_repositoy.dart';
import 'package:t_store/core/config/service_locator.dart';

class CategoryRepositoyImpl extends CategoryRepository {
  @override
  Future<Either<String, List<CategoryEntity>>> getAllCategories() async {
    var returnedData =
        await getIt<CategoryFirebaseServices>().getAllCategories();

    return returnedData.fold(
      (error) => Left(error),
      (data) {
        List<CategoryEntity> allCategories = List.from(data)
            .map((document) => CategoryModel.fromJson(document).toEntity())
            .toList();

        return Right(allCategories);
      },
    );
  }

  @override
  Future<Either<String, List<CategoryEntity>>> getSubCategories(
      String categoryId) async {
    var returnedData =
        await getIt<CategoryFirebaseServices>().getSubCategories(categoryId);

    return returnedData.fold(
      (error) => Left(error),
      (data) {
        List<CategoryEntity> subCategories = List.from(data)
            .map((document) => CategoryModel.fromJson(document).toEntity())
            .toList();

        return Right(subCategories);
      },
    );
  }
}
