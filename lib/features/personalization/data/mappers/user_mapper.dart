import 'package:t_store/features/personalization/domain/entites/user_entity.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';

extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userID,
      firstName: firstName,
      lastName: lastName,
      username: username,
      userEmail: userEmail,
      userPhone: userPhone,
      profilePicture: profilePicture,
    );
  }
}

extension UserEntityExtension on UserEntity {
  UserModel toModel() {
    return UserModel(
      userID: userId,
      firstName: firstName,
      lastName: lastName,
      username: username,
      userEmail: userEmail,
      userPhone: userPhone,
      profilePicture: profilePicture,
    );
  }
}
