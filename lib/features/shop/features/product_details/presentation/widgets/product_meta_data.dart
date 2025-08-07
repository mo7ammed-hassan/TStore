import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/discount_rate.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
    required this.product,
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final cubit = getIt.get<ProductsCubit>();
    final salePersentage = cubit.calculateProductDiscount(
        product.price.toDouble(), product.salePrice!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            product.salePrice! > 0
                ? TDiscountRate(
                    rate: '$salePersentage%',
                  )
                : const SizedBox(),
            const SizedBox(width: TSizes.spaceBtwItems),

            // Discount price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice! > 0)
              Text(
                product.price.toDouble().toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
          ],
        ),
        if (product.productType == ProductType.single.toString() &&
            product.salePrice! > 0)
          const SizedBox(width: TSizes.spaceBtwItems / 2),
        TProductPriceText(price: cubit.getProductPrice(product), isLarge: true),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        TProductTitleText(
          title: product.title,
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const TProductTitleText(
              title: 'Status',
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              cubit.getPrroductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            TCircularImage(
              image: product.brand?.image ?? TImages.defaultProductImage,
              width: 32,
              height: 32,
              backgroundColor: isDark ? AppColors.black : AppColors.white,
            ),
            const SizedBox(width: 5),
            TBrandTitleWithVerifiedIcon(
              title: product.brand?.name ?? '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
