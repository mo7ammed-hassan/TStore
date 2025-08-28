import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/icons/add_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class TProductCartFooter extends StatelessWidget {
  const TProductCartFooter({
    super.key,
    this.price,
    required this.product,
  });
  final String? price;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsiveInsets.only(
        left: TSizes.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentGeometry.centerLeft,
              child: TProductPriceText(price: price ?? '', isLarge: false),
            ),
          ),
          ResponsiveGap.horizontal(TSizes.sm),
          
          TAddIcon(
            product: product,
          ),
        ],
      ),
    );
  }
}
