import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class ReAuthUserAccountUseCase extends UseCases<Either, UserSigninModel> {
  @override
  Future<Either> call({UserSigninModel? params}) async {
    return await getIt<UserRepository>()
        .reAuthenticateWithEmailAndPassword(params!.uerEmail, params.password);
  }
}
