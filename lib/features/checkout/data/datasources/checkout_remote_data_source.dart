import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/common/core/firebase_collections/collections.dart';
import 'package:t_store/features/checkout/data/models/checkout_model.dart';
import 'package:t_store/features/checkout/data/models/order_model.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/cart/data/mapper/cart_item_mapper.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/utils/constants/enums.dart';

abstract class CheckoutRemoteDataSource {
  Future<OrderModel> createOrderDraft({
    required CheckoutModel checkoutData,
    required String userId,
  });

  Future<CheckoutModel> syncCartWithServer(
      {required List<CartItemEntity> itemsPayload});

  Future<void> updateOrderPaymentStatus({
    required String orderId,
    required PaymentStatus newStatus,
    required String userId,
  });
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  CheckoutRemoteDataSourceImpl();
  final firebaseInstance = FirebaseFirestore.instance;

  @override
  Future<OrderModel> createOrderDraft({
    required CheckoutModel checkoutData,
    required String userId,
  }) async {
    final orderRef = firebaseInstance
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .doc();

    final userAddressDoc = await firebaseInstance
        .collection(FirebaseCollections.USER_COLLECTION)
        .doc(userId)
        .collection(FirebaseCollections.ADDRESS_COLLECTION)
        .where("selectedAddress", isEqualTo: true)
        .limit(1)
        .get();

    final userAddress = AddressModel.fromSnapshot(userAddressDoc.docs.first);

    final order = OrderModel(
      orderId: orderRef.id,
      userId: userId,
      shippingAddress: userAddress,
      checkoutModel: checkoutData,
      paymentStatus: PaymentStatus.pendingPayment.name,
      orderStatus: OrderStatus.unCompleted.name,
      createdAt: Timestamp.now(),
    );

    final orderData = order.toJson();
    final batch = firebaseInstance.batch();

    // write in orders collection
    batch.set(orderRef, orderData);

    // write in user's orders collection
    final userOrderRef = firebaseInstance
        .collection(FirebaseCollections.USER_COLLECTION)
        .doc(userId)
        .collection("orders")
        .doc(orderRef.id);

    batch.set(userOrderRef, orderData);

    await batch.commit();

    return order;
  }

  @override
  Future<CheckoutModel> syncCartWithServer(
      {required List<CartItemEntity> itemsPayload}) async {
    final productsRef =
        firebaseInstance.collection(FirebaseCollections.PRODUCTS_COLLECTION);

    final productIds = itemsPayload.map((e) => e.product.id).toSet().toList();

    final productDocs = await productsRef
        .where(FieldPath.documentId, whereIn: productIds.take(10).toList())
        .get();

    final products =
        productDocs.docs.map((doc) => ProductModel.fromJson(doc)).toList();

    final productMap = {for (var p in products) p.id: p};

    double subtotal = 0;

    final updatedItems = <CartItemModel>[];

    for (var item in itemsPayload) {
      final product = productMap[item.product.id];
      if (product == null) continue;

      final variationMap = {for (var v in product.productVariations) v.id: v};

      final variation = variationMap[item.product.variation.id];
      if (variation == null) continue;

      final realPrice =
          (variation.salePrice != null && variation.salePrice != 0)
              ? variation.salePrice!
              : variation.price;

      subtotal += realPrice * item.quantity;

      final updatedItem = item.copyWith(price: realPrice);
      updatedItems.add(updatedItem.toModel());
    }

    double shipping = 50.0;
    double discount = 10.0;
    double total = subtotal + shipping - discount;

    final checkout = CheckoutModel(
      items: updatedItems,
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      total: total,
      currency: 'EGP',
    );

    return checkout;
  }

  @override
  Future<void> updateOrderPaymentStatus({
    required String orderId,
    required PaymentStatus newStatus,
    required String userId,
  }) async {
    final orderRef = firebaseInstance
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .doc(orderId);

    final userOrderRef = firebaseInstance
        .collection(FirebaseCollections.USER_COLLECTION)
        .doc(userId)
        .collection("orders")
        .doc(orderId);

    final batch = firebaseInstance.batch();

    batch.update(orderRef, {
      'paymentStatus': newStatus.name,
    });

    batch.update(userOrderRef, {
      'paymentStatus': newStatus.name,
    });

    await batch.commit();
  }
}
