import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/authentication/presentation/manager/password_and_selection/password_and_selection_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/password_and_selection/password_and_selection_state.dart';
import 'package:t_store/common/widgets/checkbox/custom_checkbox.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text_span.dart';

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
          child: ResponsiveTextSpan(
            text: '${TTexts.iAgreeTo} ',
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            children: [
              ResponsiveTextSpan(
                text: '${TTexts.privacyPolicy} ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                      color: isDark ? AppColors.white : AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          isDark ? AppColors.white : AppColors.primary,
                    )
                    .copyWith(
                      fontSize: 13.5,
                    ),
              ),
              ResponsiveTextSpan(
                text: '${TTexts.and} ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 12),
              ),
              ResponsiveTextSpan(
                  text: TTexts.termsOfUse,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(
                        color: isDark ? AppColors.white : AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            isDark ? AppColors.white : AppColors.primary,
                      )
                      .copyWith(
                        fontSize: 13.5,
                      )),
            ],
          ),
        ),
      ],
    );
  }
}
