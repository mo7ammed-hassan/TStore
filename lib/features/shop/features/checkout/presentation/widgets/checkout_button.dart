import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/success_pages/success_page.dart';
import 'package:t_store/features/navigation_menu/navigation_screen.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessPage(
                animation: false,
                title: 'Payment Success!',
                subtitle: 'Your items will be shipping soon!',
                image: TImages.successfulPaymentIcon,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const NavigationScreen()),
                    (route) => false,
                  );
                },
              ),
            ),
            (route) => false,
          );
        },
        child: Text('Pay Now \$${cartCubit.orderTotal.toStringAsFixed(2)}'),
      ),
    );
  }
}
