import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/address_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/payment_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/pricing_section.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ChekoutOrderDetial extends StatelessWidget {
  const ChekoutOrderDetial({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      child: Column(
        children: [
          const PricingSection(),
          const SizedBox(height: TSizes.spaceBtwItems),
          const Divider(),
          const SizedBox(height: TSizes.spaceBtwItems),
          const PaymentSection(),
          const SizedBox(height: TSizes.spaceBtwSections),
          BlocProvider(
            create: (context) => getIt<AddressCubit>()..fetchAllAddresses(),
            child: const AddressSection(),
          ),
        ],
      ),
    );
  }
}
