import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/domain/entites/user_entity.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/config/service_locator.dart';

class FetchUserDataUseCase
    extends UseCases<Either<String, UserEntity>, dynamic> {
  @override
  Future<Either<String, UserEntity>> call({params}) async {
    return await getIt<UserRepository>().fetchUserData();
  }
}
