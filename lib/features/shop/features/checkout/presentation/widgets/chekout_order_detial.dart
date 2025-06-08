import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/address/address_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/payment/payment_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/pricing_section.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ChekoutOrderDetial extends StatelessWidget {
  const ChekoutOrderDetial({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TRoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      showBorder: true,
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      child: const Column(
        children: [
          PricingSection(),
          SizedBox(height: AppSizes.spaceBtwItems),
          Divider(),
          SizedBox(height: AppSizes.spaceBtwItems),
          PaymentSection(),
          SizedBox(height: AppSizes.spaceBtwSections),
          AddressSection(),
        ],
      ),
    );
  }
}
