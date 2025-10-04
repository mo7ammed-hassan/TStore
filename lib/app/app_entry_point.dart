import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/app/cubits/launch_app_cubit.dart';
import 'package:t_store/app/cubits/launch_app_state.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/authentication/presentation/pages/onboarding_page.dart';
import 'package:t_store/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';

class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  late final LaunchAppCubit launchAppCubit;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    launchAppCubit = LaunchAppCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      launchAppCubit.launchApp();
    });
  }

  void _navigate(Widget page) {
    if (_navigated || !mounted) return;
    _navigated = true;
    context.pushAndClearAll(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: launchAppCubit,
      child: BlocListener<LaunchAppCubit, LaunchAppState>(
        listener: (context, state) {
          if (state is FirstLaunchState) {
            // In case of first launch, navigate to Onboarding page
            _navigate(const OnBoardingPage());
          } else if (state is AuthenticatedState) {
            // In case of authenticated user, navigate to the main menu
            _navigate(const NavigationScreen());
          } else if (state is VerifingEmailState) {
            // In case of email verification needed, navigate to Verify Email page
            _navigate(VerifyEmailPage(email: state.email));
          } else {
            // If no user is authenticated, navigate to Login page
            _navigate(const LoginPage());
          }
        },
        child: const Scaffold(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    launchAppCubit.close();
  }
}
