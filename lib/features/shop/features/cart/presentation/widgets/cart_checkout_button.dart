import 'package:flutter/material.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/presentation/screens/payment_flow_screen.dart';
import 'package:t_store/features/payment/presentation/routes/payment_flow_args.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class CartCheckoutButton extends StatelessWidget {
  const CartCheckoutButton({
    super.key,
    required this.items,
    required this.total,
  });
  final List<CartItemEntity> items;
  final double total;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsivePadding.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
        child: ElevatedButton(
          onPressed: () => context.pushPage(
            PaymentFlowScreen(
              args: PaymentFlowArgs(items: items, removeCartItems: true),
              entryPoint: PaymentEntryPoint.homePage,
            ),
          ),
          child: ResponsiveText(
            'Procced to Buy \$${total.toStringAsFixed(2)}',
          ),
        ),
      ),
    );
  }
}
