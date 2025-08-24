import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/models/get_all_products_param_model.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_all_products_by_brand_use_cse.dart';
import 'package:t_store/config/service_locator.dart';

class ProductsByBrandCubit extends Cubit<ProductsByBrandState> {
  ProductsByBrandCubit() : super(ProductsByBrandInitialState());

  final List<ProductEntity> products = [];

  Future<void> fetchProductsByBrand(
      {required String brandId, int limit = 10}) async {
    var result = await getIt.get<GetAllProductsByBrandUseCse>().call(
          params: GetAllParams(id: brandId, limit: limit),
        );

    if (isClosed) return;

    result.fold(
      (error) => emit(ProductsByBrandErrorState(message: error)),
      (products) {
        products = products;
        emit(ProductsByBrandLoadedState(products: products));
      },
    );
  }
}
