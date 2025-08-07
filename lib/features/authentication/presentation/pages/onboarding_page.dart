import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/onboarding/onboarding_cubit.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/authentication/presentation/widgets/onboarding/onbboarding_page_view.dart';
import 'package:t_store/features/authentication/presentation/widgets/onboarding/onboarding_dots_indicator.dart';
import 'package:t_store/features/authentication/presentation/widgets/onboarding/onboarding_next_button.dart';
import 'package:t_store/features/authentication/presentation/widgets/onboarding/onboarding_skip.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, int>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          final cubit = context.read<OnboardingCubit>();
          if (cubit.hasCompletedOnboarding) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              const OnboardingPageView(),
              const OnBoardingSkip(),
              const OnboardingDotsIndicator(),
              const OnBoardingNextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
