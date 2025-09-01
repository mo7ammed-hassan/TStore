import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/common/core/firebase_collections/collections.dart';
import 'package:t_store/features/checkout/data/models/order_model.dart';

abstract class OrderRemoteDataSources {
  Future<List<OrderModel>> fetchAllOrders({required String? userId});
  Future<void> cancelOrder({required String orderId, required String? userId});
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
}
