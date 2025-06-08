import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class SuccessPage extends StatelessWidget {
  final String image, title, subtitle;
  final VoidCallback? onPressed;
  final bool json;
  const SuccessPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onPressed,
    this.json = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              json
                  ? Lottie.asset(
                      image,
                      width: HelperFunctions.screenWidth() * 0.6,
                    )
                  : Image.asset(image,
                      width: HelperFunctions.screenWidth() * 0.5),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
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
