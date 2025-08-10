import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/success_pages/success_page.dart';
import 'package:t_store/features/shop/features/order/presentation/pages/order_page.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessPage(
                title: 'Payment Success!',
                subtitle: 'Your items will be shipping soon!',
                image: TImages.successfulPaymentIcon,
                onPressed: () {
                  // Navigate to success page after payment success
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          );
        },
        child: const Text('Checkout \$300'),
      ),
    );
  }
}
