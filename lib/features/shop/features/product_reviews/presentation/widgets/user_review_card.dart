import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/read_more_text.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/rating_bar_indicator.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/store_response.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

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
                const CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage1),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text('Ahmed Hossam',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Row(
          children: [
            const TRatingBarIndicator(rating: 3.5),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              '20 Nov 2024',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const TReadMoreText(
          text:
              'Ratings and reviews are verified and are from people who use the same type of product that you see',
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const StoreResponse(),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}
