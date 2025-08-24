import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/config/service_locator.dart';

class UpdateUserFiledUseCase extends UseCases<Either, Map<String, dynamic>> {
  @override
  Future<Either> call({Map<String, dynamic>? params}) async {
    return await getIt<UserRepository>().updateUserField(params!);
  }
}
