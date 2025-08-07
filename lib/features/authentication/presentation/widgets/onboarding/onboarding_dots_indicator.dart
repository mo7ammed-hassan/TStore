import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/onboarding/onboarding_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utlity.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OnboardingDotsIndicator extends StatelessWidget {
  const OnboardingDotsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return BlocBuilder<OnboardingCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, currentIndex) {
        return Positioned(
          bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
          left: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(cubit.onboardingPages.length, (index) {
              final isActive = index == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 3.5,
                width: isActive ? 43 : 20,
                decoration: BoxDecoration(
                  color: isActive
                      ? isDarkMode
                          ? AppColors.light
                          : AppColors.dark
                      : AppColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
