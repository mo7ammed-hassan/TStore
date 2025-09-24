import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/core/hive_boxes/open_boxes.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/favorite_button_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_cubit.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';

abstract class UserFirebaseServices {
  Future<Either<String, Map<String, dynamic>>> fetchUserData();
  Future<Either> updateUserField({required Map<String, dynamic> data});
  Future<Either> reAuthenticateWithEmailAndPassword(
      String email, String password);
  Future<Either> deleteUserAccount();
  Future<Either> deleteAccount();
  Future<Either> uploadUserImage(String path, XFile image);
}

class UserFirebaseServiceImpl implements UserFirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<Either<String, Map<String, dynamic>>> fetchUserData() async {
    final userId = _auth.currentUser!.uid;

    final documentSnapshot = await _store.collection('Users').doc(userId).get();

    try {
      if (documentSnapshot.exists) {
        final userData =
            documentSnapshot.data(); // convert document snapshot to JSON
        if (kDebugMode) {
          print(userData);
        }
        return Right(userData!);
      } else {
        return const Left('User not found');
      }
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      return Left('Error fetching user data: $e');
    }
  }

  @override
  Future<Either> updateUserField({required Map<String, dynamic> data}) async {
    final userId = _auth.currentUser!.uid;

    try {
      await _store.collection('Users').doc(userId).update(data);
      return const Right('Successfully updated');
    } catch (e) {
      return Left('Error updating user field: $e');
    }
  }

  @override
  Future<Either> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.reauthenticateWithCredential(credential);

      return const Right('Successfully reauthenticated');
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      return Left('Error reauthenticating: $e');
    }
  }

  @override
  Future<Either> deleteAccount() async {
    try {
      final userId = _auth.currentUser!.uid;

      _deleteSubcollection(userId, 'orders');
      _deleteSubcollection(userId, 'Address');

      await _store.collection('Users').doc(userId).delete();

      await _auth.currentUser!.delete();

      // -- Remove User Boxes --
      await Hive.deleteBoxFromDisk(userId);
      await Hive.deleteBoxFromDisk('wishlist_$userId');
      // -- Reset Singletons to resevie new instance --
      await getIt.resetLazySingleton<WishlistCubit>();
      await getIt.resetLazySingleton<FavoriteButtonCubit>();
      await getIt.resetLazySingleton<OpenBoxes>();

      return const Right('User deleted successfully');
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      return Left('Error deleting  $e');
    }
  }

  @override
  Future<Either> deleteUserAccount() async {
    try {
      final provider =
          _auth.currentUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await deleteAccount();
          return const Right('google.com');
        } else if (provider == 'password') {
          return const Right('password');
        }
      }
      return const Left('Error determining user account type');
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      return Left('Error deleting user Account: $e');
    }
  }

  @override
  Future<Either> uploadUserImage(String path, XFile image) async {
    try {
      final ref = _storage.ref(path).child(image.name);

      await ref.putFile(File(image.path));

      final url = await ref.getDownloadURL();

      // Update user document with image URL
      await updateUserField(data: {
        'profilePicture': url,
      });

      return Right(url);
    } on FirebaseException catch (e) {
      return Left('Error uploading image: $e');
    } catch (e) {
      return Left('Error uploading image: $e');
    }
  }

  Future<void> _deleteSubcollection(String userId, String subcollection) async {
    final subcollectionRef =
        _store.collection('Users').doc(userId).collection(subcollection);

    final snapshots = await subcollectionRef.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
