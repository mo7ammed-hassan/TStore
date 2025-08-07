import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/onboarding/onboarding_cubit.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return BlocBuilder<OnboardingCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return PageView.builder(
          controller: cubit.pageController,
          onPageChanged: cubit.changePage,
          itemCount: cubit.totalPages,
          itemBuilder: (_, index) {
            return cubit.onboardingPages[index];
          },
        );
      },
    );
  }
}
