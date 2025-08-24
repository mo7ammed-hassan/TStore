import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/domain/use_cases/delete_user_account_use_case.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/delete_user_account_state.dart';
import 'package:t_store/config/service_locator.dart';

class DeleteUserAccountCubit extends Cubit<DeleteUserAccountState> {
  DeleteUserAccountCubit() : super(DeleteUserAccountInitialState());

  Future<void> deleteUserAccount() async {
    var result = await getIt<DeleteUserAccountUseCase>().call();

    result.fold(
      (error) {
        emit(DeleteUserAccountFailure());
      },
      (message) {
        if (message == 'google.com') {
          emit(DeleteUserAccountSuccess());
        } else if (message == 'password') {
          emit(ReAuthUserState());
        }
      },
    );
  }
}
