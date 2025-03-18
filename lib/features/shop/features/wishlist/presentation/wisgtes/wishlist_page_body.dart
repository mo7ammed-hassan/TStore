import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/wisgtes/build_wishlist_item.dart';
import 'package:t_store/utils/constants/sizes.dart';

class WishlistPageBody extends StatelessWidget {
  const WishlistPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spaceBtwItems,
          vertical: AppSizes.defaultSpace,
        ),
        child: BuildWishlistItems(),
      ),
    );
  }
}
