import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:t_store/common/cubits/password_and_selection/password_and_selection_state.dart';
import 'package:t_store/common/widgets/checkbox/custom_checkbox.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TTermAndCondationCheckbox extends StatelessWidget {
  const TTermAndCondationCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Row(
      children: [
        BlocBuilder<PasswordAndSelectionCubit, PasswordAndSelectionState>(
          builder: (context, state) {
            return CustomCheckbox(
              value: state.isPrivacyAccepted,
              onChanged: (value) {
                context
                    .read<PasswordAndSelectionCubit>()
                    .togglePrivacyAcceptance();
              },
            );
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${TTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${TTexts.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: isDark ? AppColors.white : AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            isDark ? AppColors.white : AppColors.primary,
                      ),
                ),
                TextSpan(
                  text: '${TTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: TTexts.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: isDark ? AppColors.white : AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            isDark ? AppColors.white : AppColors.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
