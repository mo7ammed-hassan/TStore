import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_product_usecase.dart';

class ProductsByBrandCubit extends Cubit<ProductsByBrandState> {
  ProductsByBrandCubit() : super(ProductsByBrandInitialState());

  final List<ProductEntity> products = [];

  Future<void> fetchProductsByBrand(
      {required String brandId, int limit = 10}) async {
    var result = await getIt.get<GetProductsUseCase>().call(
          brandId: brandId,
          limit: limit,
        );

    if (isClosed) return;

    result.fold(
      (error) => emit(ProductsByBrandErrorState(message: error.toString())),
      (products) {
        products = products;
        emit(ProductsByBrandLoadedState(products: products));
      },
    );
  }
}
