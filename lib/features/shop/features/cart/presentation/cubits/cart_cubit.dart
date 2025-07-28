import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_single_cart_item_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/fetch_cart_items_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/remover_single_cart_item_use_case.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  // -- Fetch Cart Items --
  Future<void> fetchCartItems() async {
    emit(CartLoadingState());
    final result = await getIt.get<FetchCartItemsUseCase>().call();
    result.fold(
      (failure) => emit(CartErrorState(failure.message)),
      (cartItems) => emit(CartLoadedState(cartItems)),
    );
  }

  // -- Add Product To Cart --
  Future<void> addProductToCart({required ProductEntity product}) async {
    final result =
        await getIt.get<AddProductToCartUseCase>().call(params: product);

    result.fold(
      (failure) => emit(CartErrorState(failure.message)),
      (_) {
        Loaders.customToast(message: 'Item added to cart');
        fetchCartItems();
      },
    );
  }

  // -- Remove Single Cart Item --
  Future<void> removeSingleCartItem({required CartItemModel cartItem}) async {
    var result =
        await getIt.get<RemoverSingleCartItemUseCase>().call(params: cartItem);
    result.fold(
      (failure) => emit(CartErrorState(failure.message)),
      (_) => fetchCartItems(),
    );
  }

  // -- Add Single Cart Item --

  Future<void> addSingleCartItem({required CartItemModel cartItem}) async {
    var result =
        await getIt.get<AddSingleCartItemUseCase>().call(params: cartItem);
    result.fold(
      (failure) => emit(CartErrorState(failure.message)),
      (_) => fetchCartItems(),
    );
  }

  // -- Remove All Cart Items --

  Future<void> removeAllCartItems() async {
    var result = await getIt.get<RemoverSingleCartItemUseCase>().call();
    result.fold(
      (failure) => emit(CartErrorState(failure.message)),
      (_) => fetchCartItems(),
    );
  }
}
