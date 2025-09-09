import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/login_signup/form_divider.dart';
import 'package:t_store/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/signup_cubit.dart';
import 'package:t_store/features/authentication/presentation/widgets/signup/signup_form.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.popPage(),
            child: const Icon(Iconsax.arrow_left),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: context.responsiveInsets.symmetric(
              vertical: TSizes.defaultSpace,
              horizontal: TSizes.defaultSpace / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveText(
                  TTexts.signupTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 19),
                ),
                ResponsiveGap.vertical(TSizes.spaceBtwSections),
                const TSignupForm(),
                ResponsiveGap.vertical(TSizes.spaceBtwSections),
                const TFormDivider(dividerText: TTexts.orSignUpWith),
                ResponsiveGap.vertical(TSizes.spaceBtwSections),
                const TSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
