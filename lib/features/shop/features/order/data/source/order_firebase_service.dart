import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/common/core/firebase_collections/collections.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';

abstract class OrderFirebaseService {
  Future<Either<String, void>> placeOrder({required OrderModel order});
  Future<Either<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      getAllOrders();
}

class OrderFirebaseServiceImpl implements OrderFirebaseService {
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  final _storage = FirebaseFirestore.instance;
  @override
  Future<Either<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      getAllOrders() async {
    try {
      var data = await _storage
          .collection(FirebaseCollections.USER_COLLECTION)
          .doc(_currentUser)
          .collection(FirebaseCollections.ORDERS_COLLECTION)
          .get();

      return Right(data.docs);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> placeOrder({required OrderModel order}) async {
    try {
      await _storage
          .collection(FirebaseCollections.USER_COLLECTION)
          .doc(_currentUser)
          .collection(FirebaseCollections.ORDERS_COLLECTION)
          .add(order.toJson());
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
