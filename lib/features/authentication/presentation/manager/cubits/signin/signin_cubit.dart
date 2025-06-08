import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/data/models/user_signin_model.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_verified_email_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/signin_usecase.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_state.dart';
import 'package:t_store/service_locator.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SigninInitialState());

  // Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Storage
  final _storage = GetStorage();

  // validation
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // show email and password that is storage in get storage
  void getStorageEmailAndPassword() {
    emailController.text = _storage.read('REMEMBER_ME_EMAIL') ?? '';
    passwordController.text = _storage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  void signIn(bool isRememberMe) async {
    if (!validateForm()) return;

    // Start Loading
    emit(SignInLoadingState());

    if (isRememberMe) {
      _storage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
      _storage.write('REMEMBER_ME_PASSWORD', passwordController.text.trim());
    } else {
      _storage.remove('REMEMBER_ME_EMAIL');
      _storage.remove('REMEMBER_ME_PASSWORD');
    }

    // Construct user creation model
    final user = UserSigninModel(
      uerEmail: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Call SignIn use case
    var userResult = await getIt<SignInUsecase>().call(params: user);

    userResult.fold((errorMessage) => emit(SignInErrorState(errorMessage)),
        (user) async {
      if (!await getIt<IsVerifiedEmailUseCase>().call(params: user)) {
        emit(NotVerifiedState(user.email));
      } else {
        emit(SignInSuccessState('Successfully signed in'));
      }
    });
  }

  @override
  Future<void> close() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
