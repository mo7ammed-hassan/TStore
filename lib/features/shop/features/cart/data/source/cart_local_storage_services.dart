import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalStorageServices {
  // -- Store items in cart--
  void storeCartItems({required List<CartItemModel> cartItems});
  // -- Fetch items from cart--
  List<CartItemModel> fetchCartItems();
  // -- Get total items in cart--
  int getCartItemsCount();
  // -- Get CartItemQuantity --
  int getItemQuantity(String productId);
  // -- Get ItemCount With Variation --
  int getItemQuantityWithVariationId(
      {required String productId, required String selectedVariationId});
}

class CartLocalStorageServicesImpl implements CartLocalStorageServices {
  static final String _userId = FirebaseAuth.instance.currentUser!.uid;
  static final String _boxName = 'Cart_$_userId';

  // Future<Box<CartItemModel>> _openBox() async {
  //   _cartBox ??= await Hive.openBox<CartItemModel>(_boxName);
  //   return _cartBox!;
  // }

  @override
  List<CartItemModel> fetchCartItems() {
    final cartBox = Hive.box<CartItemModel>(_boxName);
    // print(
    //     'Cart Items: ${cartBox.values.toList().map((e) => e.toJson()).toList()}');
    return cartBox.values.toList();
  }

  @override
  Future<void> storeCartItems({required List<CartItemModel> cartItems}) async {
    final cartBox = Hive.box<CartItemModel>(_boxName);
    await cartBox.clear();

    for (var item in cartItems) {
      String key = '${item.productId}-${item.variationId}';
      await cartBox.put(key, item);
    }
  }

  @override
  int getCartItemsCount() {
    final cartBox = Hive.box<CartItemModel>(_boxName);
    return cartBox.values.length;
  }

  @override
  int getItemQuantity(String productId) {
    final cartBox = Hive.box<CartItemModel>(_boxName);
    final cartItems = cartBox.values.toList();
    final foundItem = cartItems
        .where((element) => element.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  @override
  int getItemQuantityWithVariationId(
      {required String productId, required String? selectedVariationId}) {
    if (selectedVariationId == null || selectedVariationId.isEmpty) {
      getCartItemsCount();
    }
    var cartBox = Hive.box<CartItemModel>(_boxName);
    final cartItems = cartBox.values.toList();
    final foundItemQuantity = cartItems
        .where(
          (item) =>
              item.productId == productId &&
              item.variationId == selectedVariationId,
        )
        .fold(0, (previousValue, item) => previousValue + item.quantity);

    return foundItemQuantity;
  }
}
