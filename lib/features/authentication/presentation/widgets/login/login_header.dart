import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(
            isDark ? TImages.lightAppLogo : TImages.darkAppLogo,
          ),
          height: HelperFunctions.screenWidth() * 0.5,
        ),
        ResponsiveText(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ResponsiveGap.vertical(TSizes.sm),
        ResponsiveText(
          TTexts.loginSubTitle,
          maxLines: 2,
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.5),
        ),
      ],
    );
  }
}
