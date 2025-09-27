import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/authentication/data/source/authentication_source/authentication_firebase_services.dart';
import 'package:t_store/features/authentication/domain/repository/authentication_repository.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/payment/core/storage/payment_storage.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Either<String, dynamic>> resetPassword({required String email}) async {
    var returnedData = await getIt<AuthenticationFirebaseServices>()
        .resetPassword(email: email);
    return returnedData.fold(
      (errorMessage) {
        return Left(errorMessage);
      },
      (successMessage) {
        return Right(successMessage);
      },
    );
  }

  @override
  Future<Either<String, dynamic>> signIn(
      UserSigninModel userSigninModel) async {
    var returnedData =
        await getIt<AuthenticationFirebaseServices>().signin(userSigninModel);

    return returnedData.fold(
      (errorMessage) {
        return Left(errorMessage);
      },
      (successMessage) {
        return Right(successMessage);
      },
    );
  }

  @override
  Future<Either<String, dynamic>> signup(
      UserCreationModel userCreationModel) async {
    var returnedData =
        await getIt<AuthenticationFirebaseServices>().signup(userCreationModel);

    return returnedData.fold(
      (errorMessage) {
        return Left(errorMessage);
      },
      (successMessage) {
        return Right(successMessage);
      },
    );
  }

  @override
  Future<Either<String, dynamic>> sendEmailVerification() async {
    var returnedData =
        await getIt<AuthenticationFirebaseServices>().sendEmailVerification();

    return returnedData.fold(
      (errorMessage) {
        return Left(errorMessage);
      },
      (successMessage) {
        return Right(successMessage);
      },
    );
  }

  @override
  Future<bool> isVerifiedEmail(User? user) async {
    return await getIt<AuthenticationFirebaseServices>().isVerifiedEmail(user);
  }

  @override
  Future<Either<String, dynamic>> logout() async {
    var result = await getIt<AuthenticationFirebaseServices>().logout();
    return result.fold(
      (errorMessage) {
        return Left(errorMessage);
      },
      (successMessage) async {
        await PaymentStorage.instance.clear();
        return Right(successMessage);
      },
    );
  }

  @override
  Future<Either<String, UserCredential>> signInWithGoogle() async {
    var result =
        await getIt<AuthenticationFirebaseServices>().signInWithGoogle();
    return result.fold(
      (errorMessage) {
        return Left(errorMessage);
      },
      (successMessage) {
        return Right(successMessage);
      },
    );
  }
}
