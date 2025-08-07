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
        width: 310,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: isDark ? AppColors.darkerGrey : AppColors.softGrey,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.xs),
              backgroundColor: isDark ? AppColors.dark : AppColors.grey,
              child: Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
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
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: TSizes.sm, left: TSizes.sm, top: TSizes.sm),
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
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        TBrandTitleWithVerifiedIcon(
                          title: product.brand?.name ?? '',
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TProductPriceText(
                            price: product.price.toString(),
                            maxLines: 2,
                          ),
                        ),
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
      top: 0,
      right: 0,
      child: FavoriteButton(productId: product.id),
    );
  }

  Positioned _discountText(BuildContext context) {
    return const Positioned(
      top: 12,
      child: TDiscountRate(
        rate: '25%',
      ),
    );
  }
}
