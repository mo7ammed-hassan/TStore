import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/overall_product_rating.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/rating_bar_indicator.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/widgets/user_review_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'Review & Rating',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ResponsiveText(
                'Ratings and reviews are verified and are from people who use the same type of product that you see',
                maxLines: 5,
                fontSize: 13,
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwItems),

              // overall Product Rating
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 4.5),
              ResponsiveText(
                '12,611 Reviews',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 12),
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
