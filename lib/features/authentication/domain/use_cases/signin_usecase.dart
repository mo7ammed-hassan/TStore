import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/authentication/domain/repository/authentication_repository.dart';
import 'package:t_store/config/service_locator.dart';

class SignInUsecase extends UseCases<Either, UserSigninModel> {
  @override
  Future<Either> call({UserSigninModel? params}) async {
    return await getIt<AuthenticationRepository>().signIn(params!);
  }
}
