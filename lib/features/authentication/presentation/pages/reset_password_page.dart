import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            iconSize: context.horzSize(20),
            icon: const Icon(CupertinoIcons.clear),
            onPressed: () => context.popPage(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: Column(
            children: [
              Image(
                width: HelperFunctions.screenWidth() * 0.6,
                image: const AssetImage(TImages.deliveredEmailIllustration),
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              ResponsiveText(
                TTexts.changeYourPasswordTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwItems),
              ResponsiveText(
                TTexts.changeYourPasswordSubTitle,
                maxLines: 5,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              _doneButton(context),
              ResponsiveGap.vertical(TSizes.spaceBtwItems),
              _resendEmail(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doneButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.pushAndClearAll(const LoginPage()),
        child: const ResponsiveText(TTexts.done),
      ),
    );
  }

  Widget _resendEmail(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Builder(builder: (context) {
        return TextButton(
          onPressed: () {
            context.popPage();
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
