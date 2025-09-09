import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/core/firebase_collections/collections.dart';

abstract class WishlistFirebaseServices {
  Future<void> addProductToWishlist(String productId);
  Future<void> removeProductFromWishlist(String productId);
  Future<bool> isProductInWishlist(String productId);
  Future<void> clearWishlist();

  Future<Either<String, List<DocumentSnapshot<Map<String, dynamic>>>>>
      fetchWishlist();
}

class WishlistFirebaseServicesImpl implements WishlistFirebaseServices {
  final _storage = FirebaseFirestore.instance
      .collection(FirebaseCollections.USER_COLLECTION);
  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Future<void> addProductToWishlist(String productId) async {
    try {
      if (_currentUser == null) {
        throw FirebaseAuthException(
            code: 'USER_NOT_LOGGED_IN', message: 'User is not authenticated');
      }

      final userId = _currentUser.uid;

      await _storage
          .doc(userId)
          .collection(FirebaseCollections.WISHLIST_COLLECTION)
          .doc(productId)
          .set({
        'productId': productId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Error adding product to wishlist: $e';
    }
  }

  @override
  Future<void> clearWishlist() async {
    try {
      if (_currentUser == null) {
        throw FirebaseAuthException(
            code: 'USER_NOT_LOGGED_IN', message: 'User is not authenticated');
      }

      final userId = _currentUser.uid;
      var batch = FirebaseFirestore.instance.batch();

      var wishlistDocs = await _storage
          .doc(userId)
          .collection(FirebaseCollections.WISHLIST_COLLECTION)
          .get();

      for (var doc in wishlistDocs.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw FirebaseException(plugin: 'Firestore', message: e.toString());
    }
  }

  @override
  Future<Either<String, List<DocumentSnapshot<Map<String, dynamic>>>>>
      fetchWishlist() async {
    try {
      if (_currentUser == null) {
        throw FirebaseAuthException(
            code: 'USER_NOT_LOGGED_IN', message: 'User is not authenticated');
      }

      final userId = _currentUser.uid;

      var data = await _storage
          .doc(userId)
          .collection(FirebaseCollections.WISHLIST_COLLECTION)
          .get();
      return Right(data.docs);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isProductInWishlist(String productId) async {
    try {
      if (_currentUser == null) {
        throw FirebaseAuthException(
            code: 'USER_NOT_LOGGED_IN', message: 'User is not authenticated');
      }

      final userId = _currentUser.uid;

      var data = await _storage
          .doc(userId)
          .collection(FirebaseCollections.WISHLIST_COLLECTION)
          .doc(productId)
          .get();

      return data.exists;
    } catch (e) {
      throw FirebaseException(plugin: 'Firestore', message: e.toString());
    }
  }

  @override
  Future<void> removeProductFromWishlist(String productId) async {
    try {
      if (_currentUser == null) {
        throw FirebaseAuthException(
            code: 'USER_NOT_LOGGED_IN', message: 'User is not authenticated');
      }

      final userId = _currentUser.uid;

      await _storage
          .doc(userId)
          .collection(FirebaseCollections.WISHLIST_COLLECTION)
          .doc(productId)
          .delete();
    } catch (e) {
      throw FirebaseException(plugin: 'Firestore', message: e.toString());
    }
  }
}
