import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';

abstract class AuthenticationFirebaseServices {
  Future<Either> signup(UserCreationModel usetCreationModel);
  Future<Either> signin(UserSigninModel userSigninModel);
  Future<Either> isLoggedIn();
  Future<bool> logout();
  Future<Either> resetPassword({required String email});
  Future<Either> verifyEmail({required String email});
}

class AuthenticationFirebaseServicesImpl
    extends AuthenticationFirebaseServices {
  @override
  Future<Either> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(UserCreationModel usetCreationModel) async {
    try {
      // create user
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usetCreationModel.userEmail,
        password: usetCreationModel.password,
      );

      // stor user
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(credential.user!.uid)
          .set(
            usetCreationModel.toMap(),
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
  Future<Either> signin(UserSigninModel userSigninModel) {
    // TODO: implement sihnin
    throw UnimplementedError();
  }

  @override
  Future<Either> verifyEmail({required String email}) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
