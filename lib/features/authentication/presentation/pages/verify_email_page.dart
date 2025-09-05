import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/success_pages/success_page.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/verify_email_cubit.dart';
import 'package:t_store/features/authentication/presentation/manager/cubits/signup/verify_email_state.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/personalization/domain/use_cases/delete_account_use_case.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

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
              iconSize: context.horzSize(20),
              onPressed: () async {
                context.pushAndClearAll(const LoginPage());
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
              context.read<UserCubit>().fetchUserData(forchFetch: true);
              context.pushAndKeepStack(
                SuccessPage(
                  title: TTexts.yourAccountCreatedTitle,
                  subtitle: TTexts.yourAccountCreatedSubTitle,
                  image: TImages.successfullRegisterAnimation,
                  onPressed: () async {
                    context.pushAndClearAll(const NavigationScreen());
                  },
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: context.responsiveInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Image(
                    width: HelperFunctions.screenWidth() * 0.6,
                    image: const AssetImage(TImages.deliveredEmailIllustration),
                  ),
                  ResponsiveGap.vertical(TSizes.spaceBtwSections),
                  ResponsiveText(
                    TTexts.confirmEmail,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  ResponsiveGap.vertical(TSizes.spaceBtwItems),
                  _userEmail(context),
                  ResponsiveGap.vertical(TSizes.spaceBtwItems),
                  ResponsiveText(
                    TTexts.confirmEmailSubTitle,
                    maxLines: 10,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  ResponsiveGap.vertical(TSizes.spaceBtwSections),
                  _continueButton(context),
                  ResponsiveGap.vertical(TSizes.spaceBtwItems),
                  _resendButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userEmail(BuildContext context) {
    return ResponsiveText(
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
          child: const ResponsiveText(TTexts.tContinue),
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
          child: ResponsiveText(
            TTexts.resendEmail,
            style: const TextStyle()
                .copyWith(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        );
      }),
    );
  }
}
