import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/presentation/manager/password_and_selection/password_and_selection_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/password_and_selection/password_and_selection_state.dart';
import 'package:t_store/common/widgets/checkbox/custom_checkbox.dart';
import 'package:t_store/common/widgets/text_filed/password_field.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/forget_password/reset_password_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_state.dart';
import 'package:t_store/features/authentication/presentation/pages/forget_password_page.dart';
import 'package:t_store/features/authentication/presentation/pages/signup_page.dart';
import 'package:t_store/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/popups/full_screen_loader.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/common/validators/validation.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: AutofillGroup(
        child: Form(
          key: context.read<SignInCubit>().formKey,
          child: Padding(
            padding: context.responsiveInsets.symmetric(
              vertical: TSizes.spaceBtwSections,
            ),
            child: Column(
              children: [
                _emailField(context),
                ResponsiveGap.vertical(TSizes.spaceBtwInputFields),
                PasswordField(
                  controller: context.read<SignInCubit>().passwordController,
                ),
                ResponsiveGap.vertical(TSizes.spaceBtwInputFields / 2),
                // Remember Me & Forget Password
                _rememberMeAndForgetPassword(context),
                ResponsiveGap.vertical(TSizes.spaceBtwSections - 6),
                _signIn(context),
                ResponsiveGap.vertical(TSizes.spaceBtwItems),
                _createAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _emailField(BuildContext context) {
    return TextFormField(
      controller: context.read<SignInCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      decoration: const InputDecoration(
        labelText: TTexts.email,
        prefixIcon: Icon(Iconsax.direct_right),
      ),
    );
  }

  Widget _rememberMeAndForgetPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            BlocBuilder<PasswordAndSelectionCubit, PasswordAndSelectionState>(
              builder: (context, state) {
                return CustomCheckbox(
                  value: state.isRememberMe,
                  onChanged: (value) => context
                      .read<PasswordAndSelectionCubit>()
                      .toggleRememberMe(),
                );
              },
            ),
            const SizedBox(width: 5),
            const ResponsiveText(
              TTexts.rememberMe,
              fontSize: 13,
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            context.pushPage(
              BlocProvider(
                create: (context) => ResetPasswordCubit(),
                child: const ForgetPasswordPage(),
              ),
            );
          },
          child: const ResponsiveText(
            TTexts.forgetPassword,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      ],
    );
  }

  SizedBox _signIn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInLoadingState) {
            TFullScreenLoader.openLoadingDialog(
              'Logging you in...',
              TImages.docerAnimation,
            );
          } else if (state is SignInErrorState) {
            TFullScreenLoader.stopLoading();
            Loaders.errorSnackBar(
              title: 'Error',
              message: state.errorMessage,
            );
          } else if (state is SignInSuccessState) {
            TFullScreenLoader.stopLoading();
            _navigateToMenuPage(context);
          } else if (state is NotVerifiedState) {
            TFullScreenLoader.stopLoading();
            context.pushAndClearAll(VerifyEmailPage(email: state.email));
            Loaders.successSnackBar(
              title: 'Email Not Verified',
              message: 'Please Check your inbox and verify email.',
            );
          }
        },
        child: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () {
              var isRememberMe =
                  context.read<PasswordAndSelectionCubit>().state.isRememberMe;

              context.read<SignInCubit>().signIn(isRememberMe);
            },
            child: const ResponsiveText(TTexts.signIn),
          );
        }),
      ),
    );
  }

  SizedBox _createAccount(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          // Navigate to Sign Up screen
          context.pushPage(const SignupPage());
        },
        child: const ResponsiveText(TTexts.createAccount),
      ),
    );
  }

  void _navigateToMenuPage(BuildContext context) {
    context.read<UserCubit>().fetchUserData(forchFetch: true);
    context.pushAndClearAll(const NavigationScreen());
  }
}
