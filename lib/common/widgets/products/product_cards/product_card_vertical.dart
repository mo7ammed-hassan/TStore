import 'package:flutter/material.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/product_card_body.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/product_card_footer.dart';
import 'package:t_store/common/widgets/products/product_cards/sections/product_card_header.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/product_details/presentation/pages/product_detail_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class TVerticalProductCard extends StatelessWidget {
  final ProductEntity product;
  const TVerticalProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ProductsCubit cubit = ProductsCubit();
    final isDark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) {
              return ProductDetailPage(product: product);
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          boxShadow: [TShadowStyle.verticalProductShadow],
          color: isDark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: TProductCardHeader(
                productId: product.id,
                thumbnail: product.thumbnail,
                discountPrice: product.discountPercentage.toString(),
              ),
            ),
            ResponsiveGap.vertical(TSizes.spaceBtwItems / 1.8),
            TProductCardBody(
              title: product.title,
              brandTitle: product.brand?.name ?? '',
            ),
            ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
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
