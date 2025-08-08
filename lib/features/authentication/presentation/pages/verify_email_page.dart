import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/success_pages/success_page.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/verify_email_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/verify_email_state.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/personalization/domain/use_cases/delete_account_use_case.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/loaders.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailCubit()
        ..checkEmailVerification()
        ..sendVerifyEmail(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.clear),
              onPressed: () async {
                context.removeAll(const LoginPage());
                await getIt<DeleteAccountUseCase>().call();
              },
            ),
          ],
        ),
        body: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is SuccessSendVerifyEmailState) {
              Loaders.successSnackBar(
                  title: 'Email Sent',
                  message: 'Please Check your inbox and verify email.');
              // } else if (state is VerifyEmailErrorState) {
              //   TLoaders.errorSnackBar(
              //     title: 'Oh Snap!',
              //     message: state.errorMessage.toString(),
              //   );
            } else if (state is VerifiyEmailSuccessState) {
              context.removeAllSaveStack(
                SuccessPage(
                  title: TTexts.yourAccountCreatedTitle,
                  subtitle: TTexts.yourAccountCreatedSubTitle,
                  image: TImages.successfullRegisterAnimation,
                  onPressed: () async {
                    context.removeAll(const NavigationScreen());
                  },
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Image(
                    width: HelperFunctions.screenWidth() * 0.6,
                    image: const AssetImage(TImages.deliveredEmailIllustration),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    TTexts.confirmEmail,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  _userEmail(context),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    TTexts.confirmEmailSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  _continueButton(context),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  _resendButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _userEmail(BuildContext context) {
    return Text(
      email ?? '',
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }

  SizedBox _continueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Builder(builder: (context) {
        return ElevatedButton(
          onPressed: () {
            context.read<VerifyEmailCubit>().checkEmailVerification();
          },
          child: const Text(TTexts.tContinue),
        );
      }),
    );
  }

  SizedBox _resendButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Builder(builder: (context) {
        return TextButton(
          onPressed: () {
            context.read<VerifyEmailCubit>().sendVerifyEmail();
          },
          child: Text(
            TTexts.resendEmail,
            style: const TextStyle()
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        );
      }),
    );
  }
}
