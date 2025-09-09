import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_product_usecase.dart';
import 'package:t_store/features/shop/features/home/domain/use_cases/sub_categories_use_case.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_state.dart';
import 'package:t_store/core/config/service_locator.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(SubCategoryInitial());

  bool isFirstTiem = true;

  void fetchSubCategory({required String categoryId}) async {
    if (isFirstTiem) emit(SubCategoryLoading());

    final result = await SubCategoriesUseCase().call(params: categoryId);

    if (isClosed) return;

    result.fold(
      (error) => emit(SubCategoryFailure(error)),
      (subCategories) {
        isFirstTiem = false;
        emit(SubCategoryLoaded(subCategories));
      },
    );
  }

  Future<List<ProductEntity>> fetchProductsSpecificCategory(
      {required String categoryId}) async {
    emit(SubCategoryProductsLoading());

    var result = await getIt
        .get<GetProductsUseCase>()
        .call(categoryId: categoryId, limit: 10);

    if (isClosed) {
      return [];
    }

    return result.fold(
      (error) {
        emit(SubCategoryProductsFailure(error.toString()));
        return [];
      },
      (products) {
        emit(SubCategoryProductsLoaded(products));
        return products;
      },
    );
  }
}
