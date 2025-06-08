import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(AllProductsInitialState());

  //AllProductCubit.of(context).someMethod();
  static AllProductsCubit of(BuildContext context) => BlocProvider.of(context);

  final List<ProductEntity> allProducts = [];

  Future<void> fetchAllProducts({required Future<dynamic> future}) async {
    if (kDebugMode) {
      print('fetching all featured products');
    }
    emit(AllProductsLoadingState());

    // Fetch all products
    var result = await future;

    if (isClosed) return;

    result.fold(
      (error) {
        emit(AllProductsFailureState(error: error));
      },
      (products) {
        for (var product in products) {
          if (kDebugMode) {
            print(product.title);
          }
        }
        allProducts.clear();
        allProducts.addAll(products);

        emit(AllProductsLoadedState(products));
      },
    );
  }

  void clearProducts() {
    allProducts.clear();
  }

  @override
  Future<void> close() {
    if (kDebugMode) {
      print('closing all products cubit');
    }
    return super.close();
  }
}
