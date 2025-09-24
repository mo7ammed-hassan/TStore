import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';

abstract class AuthenticationRepository {
  Future<Either<String, dynamic>> signup(UserCreationModel userCreationModel);
  Future<Either<String, dynamic>> signIn(UserSigninModel userSigninModel);
  Future<Either<String, dynamic>> logout();
  Future<Either<String, dynamic>> resetPassword({required String email});
  Future<Either<String, dynamic>> sendEmailVerification();
  Future<bool> isVerifiedEmail(User? user);
  Future<Either<String, UserCredential>> signInWithGoogle();
}
