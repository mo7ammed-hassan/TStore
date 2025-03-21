import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/data/mappers_or_factories/cart_item_factory.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';

abstract class CartManagementService {
  Future<void> addProductToCart({required ProductEntity product, int quantity});
  Future<void> addSingleItemToCart({required CartItemModel cartItem});
  Future<void> removeSingleItemFromCart({required CartItemModel cartItem});
  Future<void> removeAllItemsFromCart();
}

class CartManagementServiceImpl implements CartManagementService {
  final CartLocalStorageServices cartLocalStorageServices;
  final CartItemFactoryInterface cartItemFactory;

  static final String _userId = FirebaseAuth.instance.currentUser!.uid;
  static final String _boxName = '${_userId}Cart';

  CartManagementServiceImpl(
      this.cartLocalStorageServices, this.cartItemFactory);

  @override
  Future<void> addSingleItemToCart({required CartItemModel cartItem}) async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);
    String cartKey = '${cartItem.productId}-${cartItem.variationId}';

    if (cartBox.containsKey(cartKey)) {
      var existingItem = cartBox.get(cartKey)!;
      existingItem.quantity += 1;
      await cartBox.put(cartKey, existingItem);
    } else {
      await cartBox.put(cartKey, cartItem);
    }
  }

  @override
  Future<void> addProductToCart(
      {required ProductEntity product, int quantity = 1}) async {
    var cartItem =
        cartItemFactory.createCartItem(product: product, quantity: quantity);
    await addSingleItemToCart(cartItem: cartItem);
  }

  @override
  Future<void> removeAllItemsFromCart() async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);
    await cartBox.clear();
  }

  @override
  Future<void> removeSingleItemFromCart(
      {required CartItemModel cartItem}) async {
    var cartBox = await Hive.openBox<CartItemModel>(_boxName);
    String cartKey = '${cartItem.productId}-${cartItem.variationId}';
    if (!cartBox.containsKey(cartKey)) return;

    var existingItem = cartBox.get(cartKey);
    if (existingItem == null) return;

    if (existingItem.quantity > 1) {
      existingItem.quantity -= 1;
      await cartBox.put(cartKey, existingItem);
    } else {
      await cartBox.delete(cartKey);
    }
  }
}
