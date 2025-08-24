import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/common/core/hive_boxes/open_boxes.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/favorite_button_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_cubit.dart';
import 'package:t_store/config/service_locator.dart';

abstract class AuthenticationFirebaseServices {
  Future<Either> signup(UserCreationModel userCreationModel);
  Future<Either> signin(UserSigninModel userSigninModel);
  Future<Either> logout();
  Future<Either> resetPassword({required String email});
  Future<Either> sendEmailVerification();
  Future<bool> isVerifiedEmail(User? user);
  Future<Either<String, UserCredential>> signInWithGoogle();
}

class AuthenticationFirebaseServicesImpl
    extends AuthenticationFirebaseServices {
  final FirebaseAuth _user = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Either> logout() async {
    try {
      // Close User Wishlist Box
      await getIt
          .get<OpenBoxes>()
          .closeUserWishlistBox(userID: _user.currentUser!.uid);
      // -- Reset Singletons to resevie new instance
      await getIt.resetLazySingleton<WishlistCubit>();
      await getIt.resetLazySingleton<FavoriteButtonCubit>();
      await getIt.resetLazySingleton<OpenBoxes>();

      await GoogleSignIn.instance.signOut();
      await _user.signOut();

      return const Right('Success Logout');
    } catch (e) {
      return const Left('There was an error, please try again');
    }
  }

  @override
  Future<Either> resetPassword({required String email}) async {
    try {
      await _user.sendPasswordResetEmail(email: email);
      return const Right('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      }
      return Left(message);
    } catch (e) {
      return const Left('There was an error, please try again');
    }
  }

  @override
  Future<Either> signup(UserCreationModel userCreationModel) async {
    try {
      // Create user in Firebase Auth
      final UserCredential userCredential =
          await _user.createUserWithEmailAndPassword(
        email: userCreationModel.userEmail,
        password: userCreationModel.password!,
      );

      // Store user in Firestore
      userCreationModel.userID = userCredential.user!.uid;
      await _firebaseFirestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(
            userCreationModel.toMap(),
          );

      // Open User Wishlist Box
      await getIt
          .get<OpenBoxes>()
          .openUserWishlistBox(userID: userCredential.user!.uid);

      return const Right(
        'Your Account has been created! Verify email to continue',
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    } catch (e) {
      return const Left('There was an error, please try again');
    }
  }

  @override
  Future<Either> signin(UserSigninModel userSigninModel) async {
    try {
      UserCredential userCredential = await _user.signInWithEmailAndPassword(
        email: userSigninModel.uerEmail,
        password: userSigninModel.password,
      );

      // Open User Wishlist Box
      await getIt
          .get<OpenBoxes>()
          .openUserWishlistBox(userID: userCredential.user!.uid);

      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }

      return Left(message);
    } catch (e) {
      return const Left('There was an error, please try again');
    }
  }

  @override
  Future<Either> sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return const Right('Email verification sent successfully');
    } catch (e) {
      return const Left('There was an error, please try again');
    }
  }

  @override
  Future<bool> isVerifiedEmail(User? user) async {
    try {
      if (user != null) {
        // await user.reload(); // Refresh user data
        return user.emailVerified;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('User not found: ${e.message}');
        }
      } else {
        if (kDebugMode) {
          print('FirebaseAuthException: ${e.message}');
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      return false;
    }
  }

  @override
  Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      // final GoogleSignInAccount? googleUser = await GoogleSignIn.signIn();

      // // Obtain the auth details from the request
      // final GoogleSignInAuthentication? googleAuth =
      //     googleUser?.authentication;

      // // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );

      // // Once signed in, return the UserCredential
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithCredential(credential);

      // // Storage User Data to Firestore
      // await SaveUserDataToFirestore.saveUserRecord(userCredential);

      // // Open User Wishlist Box
      // await getIt
      //     .get<OpenBoxes>()
      //     .openUserWishlistBox(userID: userCredential.user!.uid);

      return Right(
        await FirebaseAuth.instance.signInWithPopup(
          GoogleAuthProvider(),
        ),
      );
    } catch (e) {
      return const Left('Google sign-in failed');
    }
  }
}
