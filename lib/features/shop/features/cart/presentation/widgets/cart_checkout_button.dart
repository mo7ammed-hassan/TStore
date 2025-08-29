import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/checkout/presentation/pages/order_review_screen.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class CartCheckoutButton extends StatelessWidget {
  const CartCheckoutButton(
      {super.key, required this.items, required this.total});
  final List<CartItemEntity> items;
  final double total;

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding.symmetric(
      horizontal: TSizes.defaultSpace,
      vertical: TSizes.spaceBtwItems,
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderReviewScreen(
              items: items,
            ),
          ),
        ),
        child: ResponsiveText(
          'Procced to Buy \$${total.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
