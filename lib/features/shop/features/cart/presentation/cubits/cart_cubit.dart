import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_managment_service.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_single_cart_item_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/fetch_cart_items_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/remover_single_cart_item_use_case.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  // CartCubit._() : super(CartInitialState());
  // static final instance = CartCubit._();
  // factory CartCubit() => instance;

  int totalCartItems = 0;
  double totalCartPrice = 0;
  List<CartItemEntity> cartItemsList = [];

  // -- Fetch Cart Items --
  void fetchCartItems() async {
    emit(CartLoadingState());
    final result = await getIt.get<FetchCartItemsUseCase>().call();
    result.fold((failure) => emit(CartErrorState(failure.message)),
        (cartItems) {
      totalCartItems = cartItems.length;
      totalCartPrice = 0;
      cartItemsList = cartItems;
      calculateTotalPrice();
      emit(CartLoadedState(cartItems, cartItems.length));
    });
  }

  // -- Add Product To Cart --
  Future<void> addProductToCart(
      {required ProductEntity product, int quantity = 1}) async {
    final selectedVariation =
        getIt.get<ProductVariationCubit>().selectedVariation;

    // Check stock availability
    if (product.stock == 0) {
      Loaders.customToast(message: 'Out of stock');
      return;
    }

    if (product.productType == ProductType.variable.toString()) {
      // Ensure a valid variation is selected
      if (selectedVariation.attributeValues.isEmpty) {
        Loaders.customToast(message: 'Please select a variation');
        return;
      }

      // Find the selected variation in the product's variations
      final productVariation = product.productVariations?.firstWhere(
        (variation) => variation.id == selectedVariation.id,
      );

      // Check stock availability
      if (productVariation!.stock == 0) {
        Loaders.customToast(message: 'Out of stock');
        return;
      }
    }

    final result = await getIt
        .get<AddProductToCartUseCase>()
        .call(params: product, quantity: quantity);

    result.fold(
      (failure) => emit(CartErrorState(failure.message)),
      (_) {
        Loaders.customToast(message: 'Item added to cart');
        fetchCartItems();
      },
    );
  }

  Future<void> addProductToCartFormProduct(
      {required ProductEntity product, int quantity = 1}) async {
    if (product.stock == 0) {
      Loaders.customToast(message: 'Out of stock');
      return;
    }
    final result = await getIt
        .get<CartManagementService>()
        .addProductToCartFormProduct(product: product, quantity: quantity);

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

  // -- Get Item Quantity --
  int getItemQuantity({required String productId}) {
    int cartItemQuantity =
        getIt.get<CartLocalStorageServices>().getItemQuantity(productId);
    return cartItemQuantity;
  }

  int getItemQuantityWithVariationId(
      {required String productId, required String selectedVariationId}) {
    int cartItemQuantity = getIt
        .get<CartLocalStorageServices>()
        .getItemQuantityWithVariationId(
            productId: productId, selectedVariationId: selectedVariationId);
    return cartItemQuantity;
  }

  // --Calculate total price --
  double calculateTotalPrice() {
    totalCartPrice = 0;
    for (var item in cartItemsList) {
      totalCartPrice += item.price * item.quantity;
    }

    return totalCartPrice;
  }
}
