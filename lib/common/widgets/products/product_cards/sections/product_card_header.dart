import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/favorite_button/favorite_button.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/discount_rate.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';

class TProductCardHeader extends StatelessWidget {
  const TProductCardHeader({
    super.key,
    this.thumbnail,
    required this.discountPrice,
    required this.productId,
  });
  final String? thumbnail;
  final String discountPrice;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      height: context.vertSize(180),
      width: double.infinity,
      padding: context.responsiveInsets.all(TSizes.sm),
      backgroundColor: isDark ? AppColors.dark : AppColors.light,
      child: Stack(
        children: [
          _productImage(),
          _discountText(context),
          _favoriteButton(),
        ],
      ),
    );
  }

  Widget _productImage() {
    return Center(
      child: TRoundedImage(
        width: double.infinity,
        height: double.infinity,
        imageUrl: thumbnail ?? TImages.defaultProductImage,
      ),
    );
  }

  Widget _favoriteButton() {
    return Positioned(
      top: 5,
      right: 0,
      child: FavoriteButton(productId: productId),
    );
  }

  Widget _discountText(BuildContext context) {
    return Positioned(
      top: 12,
      child: TDiscountRate(
        rate: '$discountPrice%',
      ),
    );
  }
}
