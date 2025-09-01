import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_verified_email_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/send_email_verification_usecase.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/verify_email_state.dart';
import 'package:t_store/config/service_locator.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  int index = 0;
  VerifyEmailCubit() : super(VerifyEmailLoadingState());

  Timer? _verificationTimer;
  var user = FirebaseAuth.instance.currentUser;

  void sendVerifyEmail() async {
    emit(VerifyEmailLoadingState());

    bool isVerified = await getIt<IsVerifiedEmailUseCase>().call(params: user);

    if (!isVerified) {
      var result = await getIt<SendEmailVerificationUsecase>().call();

      result.fold(
        (errorMessage) => emit(VerifyEmailErrorState(errorMessage)),
        (successMessage) {
          emit(SuccessSendVerifyEmailState(successMessage));
          checkEmailVerification();
        },
      );
    } else {
      checkEmailVerification();
    }
  }

  void checkEmailVerification() {
    _verificationTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        // we should use it because i use timer it is synchronous .. cubit may be closed before timer ended
        if (!isClosed) {
          // Ensure the Cubit is not closed
          try {
            await user?.reload(); // Reload user info
            user = FirebaseAuth.instance.currentUser;
            bool isVerified =
                await getIt<IsVerifiedEmailUseCase>().call(params: user);

            if (isVerified) {
              timer.cancel(); // Stop the timer if verified

              emit(VerifiyEmailSuccessState('Email Verified!'));
            }
          } catch (e) {
            timer.cancel(); // Stop timer on error
            if (!isClosed) emit(VerifyEmailErrorState(e.toString()));
          }
        } else {
          timer.cancel(); // Ensure no timer runs after close
        }
      },
    );
  }

  @override
  Future<void> close() {
    _verificationTimer?.cancel(); // Cancel the timer
    return super.close();
  }
}
