import 'package:t_store/features/shop/features/cart/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/change_cart_item_quantity_usecase.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/fetch_cart_items_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/remove_item_from_cart_usecase.dart';

class CartUsecases {
  final FetchCartItemsUseCase fetchCartItemsUseCase;
  final AddItemToCartUsecase addItemToCartUsecase;
  final RemoveItemFromCartUsecase removeItemFromCartUsecase;
  final ChangeCartItemQuantityUsecase changeCartItemQuantityUsecase;
  final ClearCartUsecase clearCartUsecase;

  CartUsecases(
    this.fetchCartItemsUseCase,
    this.addItemToCartUsecase,
    this.removeItemFromCartUsecase,
    this.changeCartItemQuantityUsecase,
    this.clearCartUsecase,
  );
}
