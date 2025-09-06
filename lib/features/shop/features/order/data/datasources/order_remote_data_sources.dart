import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/common/core/firebase_collections/collections.dart';
import 'package:t_store/features/checkout/data/models/order_model.dart';
import 'package:t_store/utils/constants/enums.dart';

abstract class OrderRemoteDataSources {
  Future<List<OrderModel>> fetchAllOrders({required String? userId});
  Future<void> cancelOrder({required String orderId, required String? userId});
  Future<OrderModel> updateOrderStatus({
    required String orderId,
    required String? userId,
    required OrderStatus orderStatus,
    PaymentStatus? paymentStatus,
  });
}

class OrderRemoteDataSourcesImpl implements OrderRemoteDataSources {
  final fireaseIns = FirebaseFirestore.instance;

  @override
  Future<List<OrderModel>> fetchAllOrders({required String? userId}) async {
    final ordersSnapshot = await fireaseIns
        .collection(FirebaseCollections.USER_COLLECTION)
        .doc(userId)
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .get();

    return ordersSnapshot.docs
        .map((doc) => OrderModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> cancelOrder(
      {required String orderId, required String? userId}) async {
    final batch = fireaseIns.batch();

    final userOrderRef = fireaseIns
        .collection(FirebaseCollections.USER_COLLECTION)
        .doc(userId)
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .doc(orderId);
    batch.delete(userOrderRef);

    final ordersRef = fireaseIns
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .doc(orderId);
    batch.delete(ordersRef);

    await batch.commit();
  }

  @override
  Future<OrderModel> updateOrderStatus({
    required String orderId,
    required String? userId,
    required OrderStatus orderStatus,
    PaymentStatus? paymentStatus,
  }) async {
    final batch = fireaseIns.batch();

    final updateOrderData = {
      'orderStatus': orderStatus.name,
      'updatedAt': Timestamp.now(),
    };
    if (paymentStatus != null) {
      updateOrderData['paymentStatus'] = paymentStatus.name;
    }

    final userOrderRef = fireaseIns
        .collection(FirebaseCollections.USER_COLLECTION)
        .doc(userId)
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .doc(orderId);
    batch.update(userOrderRef, updateOrderData);

    final ordersRef = fireaseIns
        .collection(FirebaseCollections.ORDERS_COLLECTION)
        .doc(orderId);
    batch.update(ordersRef, updateOrderData);

    await batch.commit();

    final snapShot = await userOrderRef.get();
    return OrderModel.fromJson(snapShot.data()!);
  }
}
