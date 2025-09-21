import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/payment/domain/usecases/delete_customer_usecase.dart';
import 'package:t_store/features/personalization/data/source/remote/user_firebase_services.dart';
import 'package:t_store/features/personalization/domain/use_cases/re_auth_user_account_use_case.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/re_auth_user_state.dart';
import 'package:t_store/core/config/service_locator.dart';

class ReAuthUserCubit extends Cubit<ReAuthUserState> {
  ReAuthUserCubit() : super(ReAuthLoadingState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void reauthenticate({required String customerId}) async {
    if (!isValidEmail()) return;

    emit(ReAuthLoadingState());

    final params = UserSigninModel(
      uerEmail: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    var result = await getIt<ReAuthUserAccountUseCase>().call(params: params);
    result.fold(
      (error) {
        emit(ReAuthFailureState());
      },
      (success) async {
        await getIt<UserFirebaseServices>().deleteAccount();
        await getIt<DeleteCustomerUsecase>().call(customerId);
        emit(ReAuthSuccessState());
      },
    );
  }

  //validation
  bool isValidEmail() => formKey.currentState?.validate() ?? true;
}
