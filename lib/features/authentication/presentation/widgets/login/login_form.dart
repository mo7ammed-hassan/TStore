import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:t_store/common/cubits/password_and_selection/password_and_selection_state.dart';
import 'package:t_store/common/widgets/checkbox/custom_checkbox.dart';
import 'package:t_store/common/widgets/text_filed/password_field.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/forget_password/reset_password_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signin/signin_state.dart';
import 'package:t_store/features/authentication/presentation/pages/forget_password_page.dart';
import 'package:t_store/features/authentication/presentation/pages/signup_page.dart';
import 'package:t_store/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/validators/validation.dart';

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
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.spaceBtwSections,
            ),
            child: Column(
              children: [
                _emailField(context),
                const SizedBox(height: AppSizes.spaceBtwInputFields),
                PasswordField(
                  controller: context.read<SignInCubit>().passwordController,
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields / 2),
                // Remember Me & Forget Password
                _rememberMeAndForgetPassword(context),
                const SizedBox(height: AppSizes.spaceBtwSections),
                _signIn(context),
                const SizedBox(height: AppSizes.spaceBtwItems),
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
            const Text(TTexts.rememberMe),
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
          child: const Text(
            TTexts.forgetPassword,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
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
            context.removeAll(VerifyEmailPage(email: state.email));
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
            child: const Text(TTexts.signIn),
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
        child: const Text(TTexts.createAccount),
      ),
    );
  }

  void _navigateToMenuPage(BuildContext context) {
    context.removeAll(const NavigationMenu());
  }
}
