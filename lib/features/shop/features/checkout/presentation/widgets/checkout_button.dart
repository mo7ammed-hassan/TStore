import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/payment/presentation/screens/payment_screen.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return Padding(
      padding: context.responsiveInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentScreen(),
            ),
          );
        },
        child: ResponsiveText(
          'Confirm Order \$${cartCubit.orderTotal.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
