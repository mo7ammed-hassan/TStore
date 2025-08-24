import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/domain/use_cases/reset_password_usecase.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/forget_password/reset_password_state.dart';
import 'package:t_store/config/service_locator.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordLoadingState());

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void resetPassword() async {
    if (!validateForm()) return;

    emit(ResetPasswordLoadingState());

    var result = await getIt<ResetPasswordUsecase>()
        .call(params: emailController.text.trim());
    result.fold(
      (error) => emit(
        ResetPasswordErrorState(error),
      ),
      (success) => emit(
        ResetPasswordSuccessState(success),
      ),
    );
  }

  // validation
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
