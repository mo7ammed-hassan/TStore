import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_verified_email_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/signin_with_google.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_with_google_state.dart';
import 'package:t_store/core/config/service_locator.dart';

class SignInWithGoogleCubit extends Cubit<SignInWithGoogleState> {
  SignInWithGoogleCubit() : super(SignInWithGoogleInitialState());

  void signInWithGoogle() async {
    emit(SignInWithGoogleLoadingState());

    var result = await getIt<SigninWithGoogleUseCase>().call();

    result.fold(
      (error) {
        emit(
          SignInWithGoogleFaliureState(error),
        );
      },
      (userCredential) async {
        if (await getIt<IsVerifiedEmailUseCase>()
            .call(params: userCredential.user)) {
          emit(
            SignInWithGoogleSuccessState('Success Sign In'),
          );
        } else {
          emit(
            NotVerifiedEmailState(userCredential.user?.email ?? ''),
          );
        }
      },
    );
  }
}
