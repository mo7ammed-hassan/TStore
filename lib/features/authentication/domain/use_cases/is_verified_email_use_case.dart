import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/authentication/domain/repository/authentication_repository.dart';
import 'package:t_store/config/service_locator.dart';

class IsVerifiedEmailUseCase extends UseCases<bool, User> {
  @override
  Future<bool> call({User? params}) async {
    return await getIt<AuthenticationRepository>().isVerifiedEmail(params);
  }
}
