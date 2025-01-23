import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalStorageServices {
  // -- Store items in cart--
  void storeCartItems({required List<CartItemModel> cartItems});
  // -- Fetch items from cart--
  Future<List<CartItemModel>> fetchCartItems();
  // -- Get total items in cart--
  Future<int> getCartItemsCount();
}

class CartLocalStorageServicesImpl implements CartLocalStorageServices {
  static final String _userId = FirebaseAuth.instance.currentUser!.uid;
  static final String _boxName = '${_userId}Cart';

  static Box<CartItemModel>? _cartBox;

  Future<Box<CartItemModel>> _openBox() async {
    _cartBox ??= await Hive.openBox<CartItemModel>(_boxName);
    return _cartBox!;
  }

  @override
  Future<List<CartItemModel>> fetchCartItems() async {
    final cartBox = await _openBox();
    // print(
    //     'Cart Items: ${cartBox.values.toList().map((e) => e.toJson()).toList()}');
    return cartBox.values.toList();
  }

  @override
  Future<void> storeCartItems({required List<CartItemModel> cartItems}) async {
    final box = await _openBox();
    await box.clear();

    for (var item in cartItems) {
      String key = '${item.productId}-${item.variationId}';
      await box.put(key, item);
    }
  }

  @override
  Future<int> getCartItemsCount() async {
    final cartBox = await _openBox();
    return cartBox.values.length;
  }
}
