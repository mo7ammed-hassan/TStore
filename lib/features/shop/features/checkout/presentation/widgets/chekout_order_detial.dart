import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/address_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/payment_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/pricing_section.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class ChekoutOrderDetial extends StatelessWidget {
  const ChekoutOrderDetial({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TRoundedContainer(
      padding: context.responsiveInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      child: Column(
        children: [
          const PricingSection(),
          ResponsiveGap.vertical(TSizes.spaceBtwItems + 5),
          const Divider(),
          const PaymentSection(),
          ResponsiveGap.vertical(TSizes.spaceBtwSections / 1.8),
          BlocProvider(
            create: (context) => getIt<AddressCubit>()..fetchAllAddresses(),
            child: const AddressSection(),
          ),
        ],
      ),
    );
  }
}
