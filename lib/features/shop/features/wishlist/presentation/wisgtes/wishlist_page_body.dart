import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/wisgtes/build_wishlist_item.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class WishlistPageBody extends StatelessWidget {
  const WishlistPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: context.responsiveInsets.symmetric(
          horizontal: TSizes.spaceBtwItems,
          vertical: TSizes.defaultSpace,
        ),
        child: const BuildWishlistItems(),
      ),
    );
  }
}
