import 'package:dartz/dartz.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';
import 'package:t_store/features/personalization/data/source/user_firebase_services.dart';
import 'package:t_store/features/personalization/domain/entites/user_entity.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either<String, UserEntity>> fetchUserData() async {
    var result = await getIt<UserFirebaseServices>().fetchUserData();
    return result.fold(
      (error) {
        return Left(error);
      },
      (userData) {
        return Right(UserModel.fromMap(userData).toEntity());
      },
    );
  }
}
