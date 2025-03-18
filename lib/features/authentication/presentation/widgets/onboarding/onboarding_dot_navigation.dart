import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/onboarding/onboarding_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utlity.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    final cubit = context.read<OnBoardingCubit>();

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: AppSizes.defaultSpace,
      right: AppSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: cubit.pageController,
        count: 3,
        onDotClicked: cubit.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: isDarkMode ? AppColors.light : AppColors.dark,
          dotHeight: 5,
        ),
      ),
    );
  }
}
