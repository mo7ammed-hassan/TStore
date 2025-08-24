import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/home/domain/use_cases/category_use_case.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_state.dart';
import 'package:t_store/config/service_locator.dart';

class CategoryCubit extends Cubit<CategoryState> {
  // Singleton instance..
  static final CategoryCubit _singleton = CategoryCubit._internal();

  // (Factory Constructor) Singleton..
  factory CategoryCubit() {
    return _singleton;
  }

  // private constructor.. 'create one instance only'
  CategoryCubit._internal() : super(const CategoryInitial());

  final List<CategoryEntity> allCategories = [];
  final List<CategoryEntity> featuredCategories = [];
  bool _hasFetched = false;

  Future<void> getAllCategories() async {
    if (_hasFetched && allCategories.isNotEmpty) return;

    emit(const CategoryLoadingState());

    var result = await getIt<CategoryUseCase>().call();

    if (isClosed) return;
    result.fold(
      (error) {
        emit(CategoryFailureState(error));
      },
      (categories) {
        allCategories.clear();
        allCategories.addAll(categories);

        featuredCategories.clear();
        featuredCategories.addAll(
          categories
              .where((category) =>
                  category.isFeatured && category.parentId.isEmpty)
              .toList(),
        );

        emit(CategoryLoadedState(allCategories, featuredCategories));

        _hasFetched = true;
      },
    );
  }

  Future<void> refreshCategories() async {
    _hasFetched = false;
    await getAllCategories();
  }
}
