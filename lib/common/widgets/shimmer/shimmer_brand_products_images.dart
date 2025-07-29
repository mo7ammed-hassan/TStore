import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ShimmerBrandProductsImages extends StatelessWidget {
  const ShimmerBrandProductsImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Row(
        children: List.generate(
          3,
          (index) => Expanded(
            child: TRoundedContainer(
              height: 100,
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.darkerGrey
                  : AppColors.light,
              margin: const EdgeInsets.only(right: TSizes.sm),
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                child: CachedNetworkImage(
                  imageUrl: TImages.defaultProductImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ShimmerWidget(
                    height: 100,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
