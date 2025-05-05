import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({super.key, this.showBorder = true, required this.brand});
  final bool showBorder;
  final BrandEntity brand;
  @override
  Widget build(BuildContext context) {
    final bool isDark = HelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: const EdgeInsets.all(AppSizes.sm),
      showBorder: showBorder,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Flexible(
            child: TCircularImage(
              image: brand.image,
              isNetworkImage: true,
              backgroundColor: Colors.transparent,
              imageColor: (isDark ? AppColors.light : AppColors.dark),
            ),
          ),
          const SizedBox(width: AppSizes.spaceBtwItems / 2),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandTitleWithVerifiedIcon(
                  title: brand.name,
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  '${brand.productCount} Products',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
