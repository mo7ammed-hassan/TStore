import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/common/core/firebase_collections/collections.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';

abstract class AddressFirebaseServices {
  Future<Either<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      fetchAddresses();
  Future<Either> addNewAddress({required AddressModel address});
  Future<void> deleteAddress({required String addressId});
  Future<void> updateSelectedAddress(
      {required String addressId, required bool isSelected});
}

class AddressFirebaseServicesImpl extends AddressFirebaseServices {
  final _storage = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Future<Either<String, String>> addNewAddress(
      {required AddressModel address}) async {
    try {
      final userId = _user!.uid;

      var collection = _storage
          .collection(FirebaseCollections.USER_COLLECTION)
          .doc(userId)
          .collection(FirebaseCollections.ADDRESS_COLLECTION);

      final docRef = collection.doc();
      final userAddress = address.copyWith(id: docRef.id);
      await docRef.set(userAddress.toJson());

      return Right(docRef.id);
    } on Exception catch (e) {
      return Left('Error adding address: $e');
    }
  }

  @override
  Future<void> deleteAddress({required String addressId}) async {
    try {
      final userId = _user!.uid;

      await _storage
          .collection(FirebaseCollections.USER_COLLECTION)
          .doc(userId)
          .collection(FirebaseCollections.ADDRESS_COLLECTION)
          .doc(addressId)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Either<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      fetchAddresses() async {
    try {
      final userId = _user!.uid;

      var snapshot = await _storage
          .collection(FirebaseCollections.USER_COLLECTION)
          .doc(userId)
          .collection(FirebaseCollections.ADDRESS_COLLECTION)
          .get();

      final List<QueryDocumentSnapshot<Map<String, dynamic>>> address =
          snapshot.docs.map((address) => address).toList();

      return Right(address);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> updateSelectedAddress(
      {required String addressId, required bool isSelected}) async {
    try {
      final userId = _user!.uid;

      await _storage
          .collection(FirebaseCollections.USER_COLLECTION)
          .doc(userId)
          .collection(FirebaseCollections.ADDRESS_COLLECTION)
          .doc(addressId)
          .update({'selectedAddress': isSelected});
    } catch (e) {
      return;
    }
  }
}
