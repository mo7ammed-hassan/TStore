import 'package:t_store/features/personalization/domain/entites/user_entity.dart';

abstract class UserState {}

class FetchUserDataLoadingState extends UserState {}

class FetchUserDataLoadedState extends UserState {
  final UserEntity userData;

  FetchUserDataLoadedState(this.userData);
}

class FetchUserDataFailedState extends UserState {
  final String errorMessage;

  FetchUserDataFailedState(this.errorMessage);
}

class UpdateUserSuccessState extends UserState {
  final String message;

  UpdateUserSuccessState(this.message);
}

class UpdateUserFailureState extends UserState {
  final String errorMessage;

  UpdateUserFailureState(this.errorMessage);
}

class UpdateUserDataLoadingState extends UserState {}

class LogoutState extends UserState {}

class LogoutLoading extends UserState {}

class LogoutError extends UserState {}
