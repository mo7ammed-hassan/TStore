import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/onboarding/onboarding_cubit.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/device/device_utlity.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Positioned(
      top: TDeviceUtils.getAppBarHeight() / 1.5,
      right: 4,
      child: TextButton(
        onPressed: () {
          context.read<OnboardingCubit>().skipPage();
        },
        child: BlocBuilder<OnboardingCubit, int>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            final shouldShowSkip = state < cubit.totalPages - 1;

            return shouldShowSkip
                ? TextButton(
                    onPressed: cubit.skipPage,
                    child: ResponsiveText(
                      TTexts.skip,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
