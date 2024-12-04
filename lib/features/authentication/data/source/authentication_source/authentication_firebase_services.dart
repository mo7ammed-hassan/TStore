import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/authentication/data/source/authentication_source/save_user_data_to_firestore.dart';

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
      await GoogleSignIn().signOut();
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
      final UserCredential credential =
          await _user.createUserWithEmailAndPassword(
        email: userCreationModel.userEmail,
        password: userCreationModel.password!,
      );

      // --  Hash the password --
      // final hashedPassword =
      //     TPasswordHelper.hashPassword(userCreationModel.password);

      // Store user in Firestore
      userCreationModel.userID = credential.user!.uid;
      //userCreationModel.password = hashedPassword; // Store hashed password
      await _firebaseFirestore
          .collection('Users')
          .doc(credential.user!.uid)
          .set(
            userCreationModel.toMap(),
          );
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
      UserCredential user = await _user.signInWithEmailAndPassword(
        email: userSigninModel.uerEmail,
        password: userSigninModel.password,
      );

      return Right(user.user);
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
        await user.reload(); // Refresh user data
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Storage User Data to Firestore
      await SaveUserDataToFirestore.saveUserRecord(userCredential);

      return Right(userCredential);
    } catch (e) {
      return const Left('Google sign-in failed');
    }
  }
}
