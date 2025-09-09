import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/domain/repository/authentication_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class SignupUsecase extends UseCases<Either, UserCreationModel> {
  @override
  Future<Either> call({UserCreationModel? params}) async {
    return await getIt<AuthenticationRepository>().signup(params!);
  }
}
