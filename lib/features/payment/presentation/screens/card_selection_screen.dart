import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text_span.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/presentation/widgets/card_text_field.dart';
import 'package:t_store/features/payment/presentation/widgets/input_card_box.dart';
import 'package:t_store/features/payment/presentation/widgets/pay_button.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/features/payment/routes/payment_routes.dart';

class CardSelectionScreen extends StatelessWidget {
  const CardSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final order = ModalRoute.of(context)?.settings.arguments as OrderEntity?;
    final orderSummary = order?.checkoutModel.orderSummary;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : AppColors.light,
      appBar: const TAppBar(
        title: 'Bank Card',
        showBackArrow: true,
        nestedNavigator: true,
      ),
      body: Padding(
        padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TRoundedContainer(
              radius: 12,
              padding: context.responsiveInsets
                  .symmetric(horizontal: 12, vertical: 16),
              width: double.infinity,
              child: ResponsiveTextSpan(
                text: 'Order ID: ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  ResponsiveTextSpan(
                    text: '${order?.orderId}',
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
            ResponsiveGap.vertical(26),
            TRoundedContainer(
              padding: context.responsiveInsets
                  .symmetric(horizontal: 12, vertical: 20),
              child: Column(
                children: [
                  PaymentSummaryRow(
                    label: 'Total:',
                    value: '\$${orderSummary?.total}',
                  ),
                  ResponsiveGap.vertical(20),
                  const Divider(),
                  ResponsiveGap.vertical(20),
                  Row(
                    children: [
                      // CVV Box
                      Expanded(
                        child: InputCardBox(
                          child: Row(
                            children: [
                              const Expanded(
                                child: CardTextField(
                                  hint: 'CVV',
                                  maxLength: 4,
                                  obscureText: true,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                width: context.horzSize(16),
                                height: context.horzSize(16),
                                decoration: ShapeDecoration(
                                  color: isDark
                                      ? AppColors.darkerGrey
                                      : AppColors.light,
                                  shape: const CircleBorder(),
                                ),
                                child: const FittedBox(
                                  child: Icon(Icons.question_mark),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGap.horizontal(10),

                      // Card Info Box
                      Expanded(
                        flex: 2,
                        child: InputCardBox(
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    context.responsiveInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.darkerGrey
                                      : AppColors.light,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: context.responsiveInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                                child: const ResponsiveText(
                                  'VISA',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Expanded(
                                child: CardTextField(
                                  hint: '**** **** **** 4512',
                                  enabled: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGap.vertical(28),

                  // Pay Button
                  PayButton(order: order!),
                  ResponsiveGap.vertical(20),

                  // another card Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        PaymentRoutes.manageCardsScreen,
                      ),
                      child: const ResponsiveText('Use another card'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
