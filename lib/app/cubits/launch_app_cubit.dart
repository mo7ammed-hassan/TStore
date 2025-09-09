import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/hive_boxes/open_boxes.dart';
import 'package:t_store/app/cubits/launch_app_state.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_first_launch_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_verified_email_use_case.dart';
import 'package:t_store/core/config/service_locator.dart';

class LaunchAppCubit extends Cubit<LaunchAppState> {
  LaunchAppCubit() : super(LaunchAppInitial());

  void launchApp() async {
    // Check if it is the first time launching the app
    bool isFirstLaunch = await getIt<IsFirstLaunchUseCase>().call();

    // Get the current user from Firebase
    User? user = FirebaseAuth.instance.currentUser;

    if (isFirstLaunch) {
      // If it is the first launch, show the Onboarding page
      emit(FirstLaunchState());
    } else if (user != null) {
      // If there is a user, check the email verification status
      //bool isVerifiedEmail = user.emailVerified;
      bool isVerifiedEmail =
          await getIt<IsVerifiedEmailUseCase>().call(params: user);

      if (isVerifiedEmail) {
        // If the email is verified, show the main page
        await getIt.get<OpenBoxes>().openUserWishlistBox(userID: user.uid);
        emit(AuthenticatedState());
      } else {
        // If the email is not verified, show the email verification page
        emit(VerifingEmailState(user.email));
      }
    } else {
      // If there is no user, show the login page
      emit(UnAuthenticatedState());
    }
  }
}
