import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/cart/product_quantity_button.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text_span.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    this.showAddRemoveButtons = true,
    required this.cartItem,
  });
  final bool showAddRemoveButtons;
  final CartItemEntity cartItem;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final sizeValue = cartItem.product.variation.attributeValues['Size'] ??
        cartItem.product.variation.attributeValues['Sizes'];
    final colorValue = cartItem.product.variation.attributeValues['Colors'] ??
        cartItem.product.variation.attributeValues['Color'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TRoundedImage(
              imageUrl: cartItem.product.imageUrl,
              width: 65,
              height: 65,
              padding: context.responsiveInsets.all(TSizes.sm),
              backgroundColor: isDark ? AppColors.darkerGrey : AppColors.light,
            ),
            ResponsiveGap.horizontal(TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBrandTitleWithVerifiedIcon(title: 'Nike'),
                  TProductTitleText(
                    title: cartItem.product.title,
                    maxLines: 1,
                  ),

                  /// --- Colors ----
                  if (colorValue != null)
                    ResponsiveTextSpan(
                      text: 'Color  ',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                      children: [
                        ResponsiveTextSpan(
                          text: '$colorValue  ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),

                  // --- Sizes --
                  if (sizeValue != null)
                    ResponsiveTextSpan(
                      text: 'Size  ',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                      children: [
                        ResponsiveTextSpan(
                          text: '$sizeValue  ',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  if (showAddRemoveButtons) ...[
                    ResponsiveGap.vertical(TSizes.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TProductQuantityButtons(
                          isDark: isDark,
                          cartItem: cartItem,
                        ),
                        TProductPriceText(
                          price: cartItem.totalPrice.toString(),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () =>
                  context.read<CartCubit>().removeItemFromCart(item: cartItem),
              icon: Icon(
                Iconsax.trash,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ],
    );
  }
}
