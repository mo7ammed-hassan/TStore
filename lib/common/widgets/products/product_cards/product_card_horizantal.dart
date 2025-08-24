import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/favorite_button/favorite_button.dart';
import 'package:t_store/common/widgets/icons/add_icon.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/discount_rate.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/product_details/presentation/pages/product_detail_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class ProductCardHorizantal extends StatelessWidget {
  final ProductEntity product;
  const ProductCardHorizantal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return OpenContainerWrapper(
      radius: const Radius.circular(TSizes.productImageRadius),
      nextScreen: ProductDetailPage(product: product),
      child: Container(
        width: context.horzSize(280),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? AppColors.darkerGrey : AppColors.softGrey,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TRoundedContainer(
              height: context.horzSize(120),
              padding: context.responsiveInsets.all(TSizes.xs),
              backgroundColor: isDark ? AppColors.dark : AppColors.grey,
              child: Stack(
                children: [
                  SizedBox(
                    height: context.horzSize(110),
                    width: context.horzSize(110),
                    child: TRoundedImage(
                      fit: BoxFit.contain,
                      imageUrl: product.thumbnail,
                      aplayImageRaduis: true,
                    ),
                  ),
                  _discountText(context),
                  _favoriteButton(),
                ],
              ),
            ),
            ResponsiveGap.horizontal(TSizes.spaceBtwItems / 2),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
                        TBrandTitleWithVerifiedIcon(
                          title: product.brand?.name ?? '',
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentGeometry.centerLeft,
                            child: TProductPriceText(
                              price: product.productrice,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        ResponsiveGap.horizontal(TSizes.sm),
                        TAddIcon(product: product),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned _favoriteButton() {
    return Positioned(
      top: 4,
      right: 0,
      child: FavoriteButton(
        productId: product.id,
      ),
    );
  }

  Positioned _discountText(BuildContext context) {
    return Positioned(
      top: 10,
      child: TDiscountRate(
        rate: '${product.discountPercentage}%',
      ),
    );
  }
}
