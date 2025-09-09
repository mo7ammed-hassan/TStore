import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/models/get_all_products_param_model.dart';
import 'package:t_store/features/shop/features/all_brands/domain/usecases/get_brands_specific_category.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_product_usecase.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_state.dart';
import 'package:t_store/config/service_locator.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  // -- fetch Brands--
  Future<void> fetchBrandsSpecificCategory({required String categoryId}) async {
    emit(StoreBrandLoading());

    var result = await getIt
        .get<GetBrandsSpecificCategory>()
        .call(params: GetAllParams(id: categoryId, limit: 2));

    if (isClosed) return;

    result.fold(
      (error) {
        emit(StoreBrandError(error: error));
      },
      (data) => emit(
        StoreBrandLoaded(brands: data),
      ),
    );
  }

  // --fetch Products --

  Future<void> fetchProductsSpecificCategory(
      {required String categoryId}) async {
    emit(StoreProductLoading());

    var result = await getIt
        .get<GetProductsUseCase>()
        .call(categoryId: categoryId, limit: 10);

    if (isClosed) return;

    result.fold(
      (error) {
        emit(StoreProductError(error: error.toString()));
      },
      (data) => emit(
        StoreProductLoaded(products: data),
      ),
    );
  }

  // --fetch Products specific brand --
  Future<void> fetchProductsSpecificBrand(
      {required String brandId, int limit = 3}) async {
    emit(StoreProductSpecificBrandLoading());

    var result = await getIt.get<GetProductsUseCase>().call(
          brandId: brandId,
          limit: limit,
        );

    if (isClosed) return;

    result.fold(
      (error) => emit(StoreProductSpecificBrandError(error: error.toString())),
      (products) {
        products = List.of(products);
        emit(StoreProductSpecificBrandLoaded(products: products));
      },
    );
  }
}
