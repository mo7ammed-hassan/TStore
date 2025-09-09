import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class DeleteUserAccountUseCase extends UseCases<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await getIt<UserRepository>()
        .deleteUserAccount();
  }
}
