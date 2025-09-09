import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/password_and_selection/password_and_selection_state.dart';

class PasswordAndSelectionCubit extends Cubit<PasswordAndSelectionState> {
  PasswordAndSelectionCubit()
      : super(PasswordAndSelectionState(
          isPasswordHidden: true,
          isPrivacyAccepted: false,
          isRememberMe: false,
        ));

  // Toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  // Toggle Privacy Acceptance
  void togglePrivacyAcceptance() {
    emit(state.copyWith(isPrivacyAccepted: !state.isPrivacyAccepted));
  }

  // Toggle Remember Me
  void toggleRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }
}
