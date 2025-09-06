import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/domain/use_cases/logout_use_case.dart';
import 'package:t_store/features/personalization/data/mappers/user_mapper.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';
import 'package:t_store/features/personalization/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:t_store/features/personalization/cubit/user_state.dart';
import 'package:t_store/features/personalization/domain/use_cases/update_user_filed_use_case.dart';
import 'package:t_store/config/service_locator.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  String previousImage = '';
  bool firstTime = true;

  Future<void> fetchUserData({bool forchFetch = false}) async {
    if (!firstTime && !forchFetch) return;
    emit(state.copyWith(action: UserAction.fetch, status: UserStatus.loading));

    var returnedData = await getIt<FetchUserDataUseCase>().call();
    returnedData.fold(
      (error) {
        emit(state.copyWith(
          action: UserAction.fetch,
          status: UserStatus.failure,
          error: error,
        ));
      },
      (userData) {
        previousImage = userData.profilePicture ?? '';
        firstTime = false;

        emit(state.copyWith(
          action: UserAction.fetch,
          status: UserStatus.success,
          user: userData,
        ));
      },
    );
  }

  void updateUserFiled(Map<String, dynamic> fields) async {
    if (!fromKey.currentState!.validate()) return;
    emit(state.copyWith(action: UserAction.update, status: UserStatus.loading));

    var result = await getIt<UpdateUserFiledUseCase>().call(params: fields);
    result.fold(
      (error) {
        emit(state.copyWith(
          action: UserAction.update,
          status: UserStatus.failure,
          error: error,
        ));
      },
      (message) async {
        final updatedMap = {...?state.user?.toModel().toMap(), ...fields};
        final updatedUser = UserModel.fromMap(updatedMap).toEntity();

        emit(state.copyWith(
          action: UserAction.update,
          status: UserStatus.success,
          message: message,
          user: updatedUser,
        ));
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(action: UserAction.logout, status: UserStatus.loading));
    final result = await getIt<LogoutUseCase>().call();

    result.fold(
      (error) {
        emit(state.copyWith(
          action: UserAction.logout,
          status: UserStatus.failure,
          error: error,
        ));
      },
      (message) async {
        emit(state.copyWith(
          action: UserAction.logout,
          status: UserStatus.success,
          message: 'Logged out successfully',
          user: null,
        ));
      },
    );
  }
}
