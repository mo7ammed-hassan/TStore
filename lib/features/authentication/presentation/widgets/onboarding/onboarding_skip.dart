import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/onboarding/onboarding_cubit.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/device/device_utlity.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          context.read<OnBoardingCubit>().skipPage();
        },
        child: BlocBuilder<OnBoardingCubit, int>(
          builder: (context, state) {
            return state != 2
                ? Text(
                    TTexts.skip,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
