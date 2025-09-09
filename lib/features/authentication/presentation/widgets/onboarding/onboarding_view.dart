import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class OnBoardingView extends StatelessWidget {
  final String image, title, subtitle;
  const OnBoardingView({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
          ResponsiveText(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwItems),
          ResponsiveText(
            subtitle,
            maxLines: 5,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 13.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
