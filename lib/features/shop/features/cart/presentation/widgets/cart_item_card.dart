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
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TRoundedImage(
              imageUrl: cartItem.product.imageUrl,
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? AppColors.darkerGrey : AppColors.light,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBrandTitleWithVerifiedIcon(title: 'Nike'),
                  TProductTitleText(
                    title: cartItem.product.title,
                    maxLines: 1,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Color  ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text:
                              '${cartItem.product.variation.attributeValues['Colors']}  ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (cartItem
                                .product.variation.attributeValues['Sizes'] !=
                            null)
                          TextSpan(
                            text: 'Size  ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        if (cartItem
                                .product.variation.attributeValues['Sizes'] !=
                            null)
                          TextSpan(
                            text:
                                '${cartItem.product.variation.attributeValues['Sizes']}  ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TProductQuantityButtons(
                          isDark: isDark,
                          cartItem: cartItem,
                        ),
                        TProductPriceText(
                            price: cartItem.totalPrice.toString()),
                      ],
                    ),
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
