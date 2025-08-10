import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/login_signup/form_divider.dart';
import 'package:t_store/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/signup_cubit.dart';
import 'package:t_store/features/authentication/presentation/widgets/signup/signup_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.removePage(const SignupPage());
            },
            child: const Icon(Iconsax.arrow_left),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.defaultSpace,
              horizontal: TSizes.defaultSpace / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSignupForm(),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TFormDivider(dividerText: TTexts.orSignUpWith),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
