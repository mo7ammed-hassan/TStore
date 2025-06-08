import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/overall_product_rating.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/rating_bar_indicator.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/user_review_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Review & Rating',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ratings and reviews are verified and are from people who use the same type of product that you see',
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // overall Product Rating
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 4.5),
              Text(
                '12,611 Reviews',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
