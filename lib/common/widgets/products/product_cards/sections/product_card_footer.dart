import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/icons/add_icon.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TProductCartFooter extends StatelessWidget {
  final Function()? addIconTap;
  const TProductCartFooter({
    super.key,
    this.price,
    this.addIconTap,
  });
  final String? price;
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
            onTap: addIconTap,
          ),
        ),
      ],
    );
  }
}
