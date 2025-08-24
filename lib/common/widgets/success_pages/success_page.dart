import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

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
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
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
        child: const Text(TTexts.tContinue),
      ),
    );
  }
}
