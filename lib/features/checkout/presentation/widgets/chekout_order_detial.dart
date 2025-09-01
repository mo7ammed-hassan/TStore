import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/checkout/presentation/widgets/address_section.dart';
import 'package:t_store/features/checkout/presentation/widgets/payment_section.dart';
import 'package:t_store/features/checkout/presentation/widgets/pricing_section.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class ChekoutOrderDetial extends StatelessWidget {
  const ChekoutOrderDetial(
      {super.key, required this.orderSummary, this.address});
  final OrderSummaryModel? orderSummary;
  final AddressEntity? address;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TRoundedContainer(
      padding: context.responsiveInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      child: Column(
        children: [
          PricingSection(orderSummary: orderSummary),
          ResponsiveGap.vertical(TSizes.spaceBtwItems + 5),
          const Divider(),
          const PaymentSection(),
          ResponsiveGap.vertical(TSizes.spaceBtwSections / 1.8),
          AddressSection(addressEntity: address),
        ],
      ),
    );
  }
}
