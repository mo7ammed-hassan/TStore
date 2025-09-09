import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class TBottomAddToCart extends StatefulWidget {
  const TBottomAddToCart({super.key, required this.product});
  final ProductEntity product;

  @override
  State<TBottomAddToCart> createState() => _TBottomAddToCartState();
}

class _TBottomAddToCartState extends State<TBottomAddToCart> {
  final ValueNotifier<int> quantityNotifier = ValueNotifier<int>(1);
  String? _lastVariationId;

  void _updateQuantityIfNeeded(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final selectedVariation =
        context.watch<ProductVariationCubit>().selectedVariation;

    if (_lastVariationId != selectedVariation.id) {
      final itemQuantity = cartCubit.getVariationItemQuantity(
        variationId: selectedVariation.id,
      );

      quantityNotifier.value = itemQuantity > 0 ? itemQuantity : 1;
      _lastVariationId = selectedVariation.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    _updateQuantityIfNeeded(context);
    final cartCubit = context.read<CartCubit>();

    return Container(
      padding: context.responsiveInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems / 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                backgroundColor: AppColors.darkGrey,
                icon: Iconsax.minus,
                width: 40,
                height: 40,
                color: AppColors.white,
                onPressed: () {
                  if (quantityNotifier.value > 1) {
                    quantityNotifier.value--;
                  }
                },
              ),
              ResponsiveGap.horizontal(TSizes.spaceBtwItems),
              ValueListenableBuilder(
                valueListenable: quantityNotifier,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  );
                },
              ),
              ResponsiveGap.horizontal(TSizes.spaceBtwItems),
              TCircularIcon(
                backgroundColor: AppColors.black,
                icon: Iconsax.add,
                width: 40,
                height: 40,
                color: AppColors.white,
                onPressed: () {
                  quantityNotifier.value++;
                },
              ),
            ],
          ),
          ResponsiveGap.horizontal(TSizes.spaceBtwSections),
          ElevatedButton(
            onPressed: () async {
              await cartCubit.addItemToCart(
                showMessage: true,
                quantity: quantityNotifier.value,
                product: widget.product,
                selectedVariation:
                    context.read<ProductVariationCubit>().selectedVariation,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: context.responsiveInsets.all(TSizes.md),
              backgroundColor: AppColors.black,
              side: const BorderSide(color: AppColors.black),
            ),
            child: const ResponsiveText('Add to cart'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    quantityNotifier.dispose();
    super.dispose();
  }
}
