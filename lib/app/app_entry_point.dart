import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/app/cubits/launch_app_cubit.dart';
import 'package:t_store/app/cubits/launch_app_state.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/authentication/presentation/pages/onboarding_page.dart';
import 'package:t_store/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LaunchAppCubit, LaunchAppState>(
      listener: (context, state) {
        if (state is FirstLaunchState) {
          // In case of first launch, navigate to Onboarding page
          context.pushAndClearAll(const OnBoardingPage());
        } else if (state is AuthenticatedState) {
          // In case of authenticated user, navigate to the main menu
          context.pushAndClearAll(const NavigationScreen());
        } else if (state is VerifingEmailState) {
          // In case of email verification needed, navigate to Verify Email page
          context.pushAndClearAll(VerifyEmailPage(email: state.email));
        } else {
          // If no user is authenticated, navigate to Login page
          context.pushAndClearAll(const LoginPage());
        }
      },
      child: const Scaffold(
        body: Center(
          child: SingleChildScrollView(),
        ),
      ),
    );
  }
}
