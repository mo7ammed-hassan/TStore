import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/forget_password/reset_password_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/forget_password/reset_password_state.dart';
import 'package:t_store/features/authentication/presentation/pages/reset_password_page.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/validators/validation.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.clear),
            onPressed: () => context.removePage(const ForgetPasswordPage()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Form(
            key: context.read<ResetPasswordCubit>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TTexts.forgetPassword,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  TTexts.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections * 2),
                _emailField(context),
                const SizedBox(height: AppSizes.spaceBtwSections),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: context.read<ResetPasswordCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      decoration: const InputDecoration(
        labelText: TTexts.email,
        prefixIcon: Icon(Iconsax.direct_right),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoadingState) {
            TFullScreenLoader.openLoadingDialog(
              'We are processing your information...',
              TImages.docerAnimation,
            );
          } else if (state is ResetPasswordErrorState) {
            TFullScreenLoader.stopLoading();
            Loaders.errorSnackBar(
              title: 'Error',
              message: state.errorMessage,
            );
          } else if (state is ResetPasswordSuccessState) {
            TFullScreenLoader.stopLoading();
            context.pushPage(BlocProvider.value(
              value: context.read<ResetPasswordCubit>(),
              child: const ResetPasswordPage(),
            ));
            Loaders.successSnackBar(
              title: 'Success',
              message: state.successMessage,
            );
          }
        },
        child: ElevatedButton(
          onPressed: () {
            context.read<ResetPasswordCubit>().resetPassword();
          },
          child: const Text(TTexts.submit),
        ),
      ),
    );
  }
}
