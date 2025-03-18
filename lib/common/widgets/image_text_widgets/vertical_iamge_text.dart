import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AppColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            TCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              padding: AppSizes.sm * 1.4,
              imageColor: (isDark ? AppColors.light : AppColors.dark),
            ),
            // Container(
            //   width: 56,
            //   height: 56,
            //   padding: const EdgeInsets.all(TSizes.fontSizeSm),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(100),
            //     color:
            //         backgroundColor ?? (isDark ? TColors.black : TColors.white),
            //   ),
            //   child: Center(
            //     child: Image(
            //       image: AssetImage(image),
            //       fit: BoxFit.cover,
            //       color: (isDark ? TColors.light : TColors.dark),
            //     ),
            //   ),
            // ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            SizedBox(
              width: 60,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
