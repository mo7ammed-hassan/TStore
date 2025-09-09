import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_product_usecase.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_state.dart';
import 'package:t_store/config/service_locator.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsState.initial());

  Future<void> fetchPopularProducts({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        state.popular.products.isNotEmpty &&
        state.popular.error == null) {
      return;
    }

    emit(state.copyWith(
      popular: state.popular.copyWith(isLoading: true, error: null),
    ));

    final result =
        await getIt<GetProductsUseCase>().call(isPopular: true, limit: 4);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            popular: state.popular
                .copyWith(isLoading: false, error: error.toString()),
          ),
        );
      },
      (products) {
        emit(
          state.copyWith(
            popular: state.popular.copyWith(
              isLoading: false,
              products: List.unmodifiable(products),
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchFeaturedProducts({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        state.featured.products.isNotEmpty &&
        state.featured.error == null) {
      return;
    }

    emit(state.copyWith(
      featured: state.featured.copyWith(isLoading: true, error: null),
    ));

    final result =
        await getIt<GetProductsUseCase>().call(isFeatured: true, limit: 4);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            featured: state.featured
                .copyWith(isLoading: false, error: error.toString()),
          ),
        );
      },
      (products) {
        emit(
          state.copyWith(
            featured: state.featured.copyWith(
              isLoading: false,
              products: List.unmodifiable(products),
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchInitialData() async {
    await Future.wait([
      fetchPopularProducts(forceRefresh: true),
      fetchFeaturedProducts(forceRefresh: true),
    ]);
  }

  Future<void> refreshProducts() async {
    emit(ProductsState.initial());
    await fetchInitialData();
  }
}





// ------------------------------- 
// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit() : super(const ProductsState());

//   Future<void> fetchProducts(ProductsCategory category,
//       {int? limit, bool forceRefresh = false}) async {
//     final currentSubset = state.getSubset(category);
//     if (!forceRefresh &&
//         currentSubset.items.isNotEmpty &&
//         currentSubset.error == null) {
//       return;
//     }

//     emit(
//       state.updateSubset(
//         category,
//         (current) => current.copyWith(loading: true),
//       ),
//     );

//     final result = await _getUsecase(category);

//     result.fold(
//       (failure) {
//         emit(state.updateSubset(category,
//             (s) => s.copyWith(loading: false, error: failure.message)));
//       },
//       (products) {
//         emit(state.updateSubset(
//             category, (s) => s.copyWith(loading: false, items: products)));
//       },
//     );
//   }

//   Future<Either<dynamic, List<ProductEntity>>> _getUsecase(
//       ProductsCategory category) async {
//     switch (category) {
//       case ProductsCategory.popular:
//         return await getIt<GetPopularProductsUseCase>().call();
//       case ProductsCategory.featured:
//         return await getIt<GetPopularProductsUseCase>().call();
//     }
//   }

//   Future<void> fetchInitialData() async {
//     await Future.wait([
//       fetchProducts(ProductsCategory.popular),
//       fetchProducts(ProductsCategory.featured),
//     ]);
//   }

//   Future<void> refreshProducts() async {
//     emit(ProductsState.initial());
//     await fetchInitialData();
//   }
// }