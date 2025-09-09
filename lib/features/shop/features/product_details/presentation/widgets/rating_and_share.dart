import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text_span.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          children: [
            Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: context.horzSize(TSizes.iconMd),
            ),
            ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
            ResponsiveTextSpan(
              text: '4.8 ',
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                ResponsiveTextSpan(
                  text: '(157)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        // Share button
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, size: context.horzSize(TSizes.iconMd)),
        )
      ],
    );
  }
}
