import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';
import 'package:t_store/features/personalization/data/source/remote/user_firebase_services.dart';
import 'package:t_store/features/personalization/domain/entites/user_entity.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/config/service_locator.dart';

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

  @override
  Future<Either> updateUserField(Map<String, dynamic> data) async {
    var result =
        await getIt<UserFirebaseServices>().updateUserField(data: data);
    return result.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }

  @override
  Future<Either> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    var result = await getIt<UserFirebaseServices>()
        .reAuthenticateWithEmailAndPassword(email, password);
    return result.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }

  @override
  Future<Either> deleteUserAccount() async {
    var result = await getIt<UserFirebaseServices>().deleteUserAccount();

    return result.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }

  @override
  Future<Either> deleteAccount() async {
    var result = await getIt<UserFirebaseServices>().deleteAccount();

    return result.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }

  @override
  Future<Either> uploadUserImage(String path, XFile? image) async {
    var result =
        await getIt<UserFirebaseServices>().uploadUserImage(path, image!);

    return result.fold(
      (error) {
        return Left(error);
      },
      (url) {
        return Right(url);
      },
    );
  }
}
