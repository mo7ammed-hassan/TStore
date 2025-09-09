import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/core/styles/spacing_styles.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class SuccessPage extends StatelessWidget {
  final String image, title, subtitle;
  final VoidCallback? onPressed;
  final bool animation;
  const SuccessPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onPressed,
    this.animation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight(context) * 2,
          child: Column(
            children: [
              (animation ? Lottie.asset : Image.asset)(
                image,
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              ResponsiveText(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwItems),
              ResponsiveText(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              _continueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _continueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const ResponsiveText(TTexts.tContinue),
      ),
    );
  }
}
