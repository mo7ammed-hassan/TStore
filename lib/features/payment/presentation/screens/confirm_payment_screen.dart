import 'package:flutter/material.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_form.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final order = args?['order'] as OrderEntity?;
    final method = args?['method'] as PaymentMethodEntity?;
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
    
                  // Payment Form
                  PaymentForm(
                    order: order,
                    method: method,
                  ),
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
                        arguments: order,
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
