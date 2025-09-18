import 'package:flutter/material.dart';
import 'package:t_store/common/common.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';

class ConfimPaymentScreen extends StatefulWidget {
  const ConfimPaymentScreen({super.key});

  @override
  State<ConfimPaymentScreen> createState() => _ConfimPaymentScreenState();
}

class _ConfimPaymentScreenState extends State<ConfimPaymentScreen> {
  final TextEditingController cvcController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cvcController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final order = args?['order'] as OrderEntity?;
    final method = args?['method'] as StripeCardMethodEntity?;
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
                              Expanded(
                                child: CardTextField(
                                  hint: 'CVC',
                                  maxLength: 4,
                                  controller: cvcController,
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
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  width: context.horzSize(60),
                                  height: context.horzSize(35),
                                  margin:
                                      context.responsiveInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.darkerGrey
                                        : AppColors.light,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: context.responsiveInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 2,
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: ResponsiveText(
                                        '${method?.card?.brand}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: CardTextField(
                                  hint: '**** **** **** ${method?.card?.last4}',
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
                  PayButton(
                    order: order!,
                    paymentMethodId: method?.id,
                    cvc: cvcController.text,
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
