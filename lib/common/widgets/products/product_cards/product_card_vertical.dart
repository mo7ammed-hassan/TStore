import 'package:flutter/material.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/product_card_body.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/product_card_footer.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/product_card_header.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/product_details/presentation/pages/product_detail_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TVerticalProductCard extends StatelessWidget {
  final ProductEntity product;
  const TVerticalProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ProductsCubit cubit = ProductsCubit();
    final isDark = HelperFunctions.isDarkMode(context);

    return OpenContainerWrapper(
      radius: const Radius.circular(TSizes.productImageRadius),
      nextScreen: ProductDetailPage(product: product),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          boxShadow: [TShadowStyle.verticalProductShadow],
          color: isDark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TProductCardHeader(
              productId: product.id,
              thumbnail: product.thumbnail,
              discountPrice: product.discountPercentage.toString(),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            TProductCardBody(
              title: product.title,
              brandTitle: product.brand?.name ?? '',
            ),
            const Spacer(),
            TProductCartFooter(
              price: cubit.getProductPrice(product),
              product: product,
            ),
          ],
        ),
      ),
    );
  }
}
