import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_product_usecase.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final GetProductsUseCase getProductsUseCase;

  AllProductsCubit(this.getProductsUseCase) : super(AllProductsInitialState());

  Future<void> fetchAllProducts({
    String? categoryId,
    String? brandId,
    bool? isFeatured,
    bool? isPopular,
    int limit = 20,
  }) async {
    emit(AllProductsLoadingState());

    final result = await getProductsUseCase(
      categoryId: categoryId,
      brandId: brandId,
      isFeatured: isFeatured,
      isPopular: isPopular,
      limit: limit,
    );

    result.fold(
      (error) => emit(AllProductsFailureState(error: error.toString())),
      (products) => emit(AllProductsLoadedState(products)),
    );
  }
}
