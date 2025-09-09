import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/authentication/domain/repository/authentication_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class SigninWithGoogleUseCase
    extends UseCases<Either<String, UserCredential>, dynamic> {
  @override
  Future<Either<String, UserCredential>> call({params}) async {
    return await getIt<AuthenticationRepository>().signInWithGoogle();
  }
}
