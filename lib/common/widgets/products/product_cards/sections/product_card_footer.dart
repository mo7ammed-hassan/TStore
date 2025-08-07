import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/icons/add_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/utils/constants/sizes.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: TSizes.sm),
          child: TProductPriceText(price: price ?? '', isLarge: false),
        ),
        const SizedBox(width: TSizes.sm),
        Flexible(
          child: TAddIcon(
            product: product,
          ),
        ),
      ],
    );
  }
}
