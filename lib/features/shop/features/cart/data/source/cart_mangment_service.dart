import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';

abstract class CartManagementService {
  Future<void> addItemToCart({required CartItemModel cartItem});

  Future<void> removeItemFromCart({required String cartItemId});

  Future<void> changeItemQuantity(
      {required String itemId, required int quantity});

  Future<void> clearCart();
}

class CartManagementServiceImpl implements CartManagementService {
  final CartLocalStorageServices cartLocalStorageServices;
  CartManagementServiceImpl(this.cartLocalStorageServices);

  static final String _userId = FirebaseAuth.instance.currentUser!.uid;
  static final String _boxName = '${_userId}Cart';

  @override
  Future<void> addItemToCart({required CartItemModel cartItem}) async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);
    String cartKey = cartItem.product.variation!.id;

    if (cartBox.containsKey(cartKey)) {
      CartItemModel? existingItem = cartBox.get(cartKey);

      if (existingItem?.quantity != cartItem.quantity) {
        final updatedCartItem =
            existingItem?.copyWith(quantity: cartItem.quantity);
        await cartBox.put(cartKey, updatedCartItem!);
      }

      return;
    }

    // String cartKey = UniqueKey().toString();
    final updatedCartItem = cartItem.copyWith(id: cartKey);
    await cartBox.put(cartKey, updatedCartItem);
  }

  @override
  Future<void> changeItemQuantity(
      {required String itemId, required int quantity}) async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);
    if (quantity <= 0) {
      removeItemFromCart(cartItemId: itemId);
    } else {
      final bool itemExist = cartBox.containsKey(itemId);

      if (itemExist) {
        CartItemModel? cartItem = cartBox.get(itemId);
        final updatedCartItem = cartItem?.copyWith(quantity: quantity);
        cartBox.put(itemId, updatedCartItem!);
      }
    }
  }

  @override
  Future<void> removeItemFromCart({required String cartItemId}) async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);

    if (!cartBox.containsKey(cartItemId)) return;

    cartBox.delete(cartItemId);
  }

  @override
  Future<void> clearCart() async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);
    await cartBox.clear();
    await cartBox.compact();
  }
}




















/*
// class CartManagementServiceImpl implements CartManagementService {
//   final CartLocalStorageServices cartLocalStorageServices;
//   final CartItemFactoryInterface cartItemFactory;

//   static final String _userId = FirebaseAuth.instance.currentUser!.uid;
//   static final String _boxName = '${_userId}Cart';

//   CartManagementServiceImpl(
//       this.cartLocalStorageServices, this.cartItemFactory);

//   @override
//   Future<void> addSingleItemToCart({required CartItemModel cartItem}) async {
//     var cartBox = await Hive.openBox<CartItemModel>(_boxName);
//     String cartKey = '${cartItem.productId}-${cartItem.variationId}';

//     if (cartBox.containsKey(cartKey)) {
//       var existingItem = cartBox.get(cartKey)!;
//       existingItem.quantity += 1;
//       await cartBox.put(cartKey, existingItem);
//     } else {
//       await cartBox.put(cartKey, cartItem);
//     }
//   }

//   @override
//   Future<void> addProductToCart(
//       {required ProductEntity product, int quantity = 1}) async {
//     var cartItem =
//         cartItemFactory.createCartItem(product: product, quantity: quantity);
//     await addSingleItemToCart(cartItem: cartItem);
//   }

//   @override
//   Future<void> removeAllItemsFromCart() async {
//     var cartBox = await Hive.openBox<CartItemModel>(_boxName);
//     await cartBox.clear();
//   }

//   @override
//   Future<void> removeSingleItemFromCart(
//       {required CartItemModel cartItem}) async {
//     var cartBox = await Hive.openBox<CartItemModel>(_boxName);
//     String cartKey = '${cartItem.productId}-${cartItem.variationId}';
//     if (!cartBox.containsKey(cartKey)) return;

//     var existingItem = cartBox.get(cartKey);
//     if (existingItem == null) return;

//     if (existingItem.quantity > 1) {
//       existingItem.quantity -= 1;
//       await cartBox.put(cartKey, existingItem);
//     } else {
//       await cartBox.delete(cartKey);
//     }
//   }
// }



 */