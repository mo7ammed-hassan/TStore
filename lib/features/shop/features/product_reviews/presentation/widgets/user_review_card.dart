import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/read_more_text.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/rating_bar_indicator.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/store_response.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: context.horzSize(17),
                  backgroundImage: const AssetImage(TImages.userProfileImage1),
                ),
                ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
                ResponsiveText(
                  'Ahmed Hossam',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: context.horzSize(17),
              ),
            ),
          ],
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2.5),
        Row(
          children: [
            const TRatingBarIndicator(rating: 3.5),
            ResponsiveGap.horizontal(TSizes.spaceBtwItems),
            ResponsiveText(
              '20 Nov 2024',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        const TReadMoreText(
          text:
              'Ratings and reviews are verified and are from people who use the same type of product that you see',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems),
        const StoreResponse(),
        ResponsiveGap.vertical(TSizes.spaceBtwSections),
      ],
    );
  }
}
