import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/cart/product_quantity_button.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard(
      {super.key, this.showAddRemoveButtons = true, required this.cartItem});
  final bool showAddRemoveButtons;
  final CartItemEntity cartItem;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.md),
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TRoundedImage(
                  imageUrl: cartItem.imageUrl!,
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(AppSizes.sm),
                  backgroundColor:
                      isDark ? AppColors.darkerGrey : AppColors.light,
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TBrandTitleWithVerifiedIcon(
                          title: cartItem.brandName ?? ''),
                      TProductTitleText(
                        title: cartItem.title,
                        maxLines: 1,
                      ),
                      Text.rich(
                        TextSpan(
                          children: (cartItem.selectedVariation ?? {})
                              .entries
                              .map(
                                (entry) => TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${entry.key}  ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    TextSpan(
                                      text: '${entry.value}  ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      if (showAddRemoveButtons)
                        const SizedBox(height: AppSizes.spaceBtwItems),
                      if (showAddRemoveButtons)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TProductQuantityButtons(
                              isDark: isDark,
                              cartItem: cartItem,
                            ),
                            TProductPriceText(
                              price: (cartItem.price * cartItem.quantity)
                                  .toStringAsFixed(2),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
