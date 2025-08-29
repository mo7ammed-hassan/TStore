import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_variation_mapper.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/product_cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/cart_usecases.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartUsecases) : super(CartInitialState());
  final CartUsecases _cartUsecases;

  // Cache of current cart items (for in-memory manipulation)
  List<CartItemEntity> _cartItems = [];

  double get totalPrice {
    return _cartItems.fold(
      0.0,
      (previousValue, item) => previousValue + item.totalPrice,
    );
  }

  double _orderTotal = 0.0;
  double get orderTotal => _orderTotal;

  void calcOrderTotal(double tax, double discount) {
    if (tax < 0) tax = 0;
    if (discount < 0) discount = 0;

    _orderTotal = (totalPrice + tax) - discount;
  }

  // -- Fetch Cart Items --
  Future<void> fetchCartItems() async {
    emit(CartLoadingState());
    final result = await _cartUsecases.fetchCartItemsUseCase();

    result.fold((failure) => emit(CartErrorState(failure.message)),
        (cartItems) {
      _cartItems = cartItems;
      _emitUpdateCart();
    });
  }

  Future<void> addItemToCart({
    bool showMessage = false,
    required ProductEntity product,
    required ProductVariationEntity selectedVariation,
    int quantity = 1,
  }) async {
    final exists = _cartItems.any(
      (item) =>
          item.product.variation.id == selectedVariation.id &&
          quantity == item.quantity,
    );

    if (exists) {
      Loaders.customToast(
        message: 'Item already in cart, please change quantity',
        isMedium: false,
      );
      return;
    }

    final ProductCartItemEntity productModel = ProductCartItemEntity(
      id: product.id,
      title: product.title,
      price: (selectedVariation.salePrice > 0)
          ? selectedVariation.salePrice
          : selectedVariation.price.toDouble(),
      imageUrl: selectedVariation.image,
      variation: selectedVariation.toModel(),
      brand: product.brand?.name ?? '',
    );

    final CartItemEntity cartItem =
        CartItemEntity(product: productModel, quantity: quantity);

    final result = await _cartUsecases.addItemToCartUsecase(params: cartItem);

    result.fold(
      (l) => emit(CartErrorState(l.message)),
      (r) {
        if (_cartItems
            .any((item) => item.product.variation.id == selectedVariation.id)) {
          _cartItems.removeWhere(
            (item) => item.product.variation.id == selectedVariation.id,
          );
        }
        _cartItems.add(cartItem);
        _emitUpdateCart();

        if (showMessage) {
          Loaders.customToast(
            message: 'Item added to cart',
            isMedium: false,
          );
        }
      },
    );
  }

  // -- Add item to cart --
  Future<void> removeItemFromCart({required CartItemEntity item}) async {
    final result = await _cartUsecases.removeItemFromCartUsecase(params: item);

    result.fold(
      (l) => emit(CartErrorState(l.message)),
      (r) {
        _cartItems.remove(item);
        _emitUpdateCart();

        Loaders.customToast(
          message: 'Item removed from cart',
          isMedium: false,
        );
      },
    );
  }

  // -- Change item quantity --
  Future<void> changeItemQuantity(
      {required CartItemEntity item, required int quantity}) async {
    final result = await _cartUsecases.changeCartItemQuantityUsecase(
        params: (item.product.variation.id, quantity));

    result.fold(
      (l) => emit(CartErrorState(l.message)),
      (r) {
        final index = _cartItems.indexWhere(
          (cartItem) =>
              cartItem.product.variation.id == item.product.variation.id,
        );
        if (index != -1) {
          _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
        }

        _emitUpdateCart();
      },
    );
  }

  int getCartLength() {
    return _cartItems.length;
  }

  int getItemQuantity({required String itemId}) {
    final item = _cartItems.firstWhere(
      (element) => element.product.id == itemId,
      orElse: () => CartItemEntity.empty(),
    );

    return item.quantity;
  }

  int getVariationItemQuantity({required String variationId}) {
    final item = _cartItems.firstWhere(
      (element) => element.product.variation.id == variationId,
      orElse: () => CartItemEntity.empty(),
    );

    return item.quantity;
  }

  // -- Private helper to emit state safely
  void _emitUpdateCart() {
    final updatedCartItems = List<CartItemEntity>.from(_cartItems);
    emit(CartLoadedState(updatedCartItems, totalPrice));
  }

  void clearAllItems() async {
    _cartItems.clear();
    _emitUpdateCart();
    await _cartUsecases.clearCartUsecase();
  }
}
