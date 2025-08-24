import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';
import 'package:t_store/features/authentication/domain/use_cases/signup_usecase.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/signup_state.dart';
import 'package:t_store/config/service_locator.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // validation → user creation → API call → result handling.
  void signup(bool isPrivacyAccepted) async {
    // ------Validation checks------
    if (!validateForm()) {
      return;
    }
    if (!isPrivacyAccepted) {
      emit(
        PrivacyValidationErrorState(
          'In order create account, you must have to read and accept the Privacy Policy & Terms of Use',
        ),
      );
      return;
    }

    // Construct user creation model
    final user = UserCreationModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      username: usernameController.text.trim(),
      userEmail: emailController.text.trim(),
      password: passwordController.text.trim(),
      userPhone: phoneController.text.trim(),
      profilePicture: '',
    );

    // Start Loading
    emit(SignupLoadingState());

    // Call use case
    var result = await getIt<SignupUsecase>().call(params: user);
    // await getIt<VerifyEmailUsecase>().call();
    result.fold(
      (errorMessage) => emit(SignupErrorState(errorMessage)),
      (successMessage) => emit(SignupSuccessState(successMessage)),
    );
  }

  // Validation logic
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<void> close() {
    // Dispose controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
