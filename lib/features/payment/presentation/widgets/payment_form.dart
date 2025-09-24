import 'package:flutter/material.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({
    super.key,
    this.order,
    this.method,
  });
  final OrderEntity? order;
  final PaymentMethodEntity? method;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final TextEditingController cvcController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cvcController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final method = widget.method as StripeCardMethodEntity?;
    return Column(
      children: [
        Row(
          children: [
            // CVC Box
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
                        color: isDark ? AppColors.darkerGrey : AppColors.light,
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
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: context.horzSize(65),
                        height: context.horzSize(35),
                        //margin: context.responsiveInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color:
                              isDark ? AppColors.darkerGrey : AppColors.light,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: context.responsiveInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
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
                    ResponsiveGap.horizontal(10),
                    // Card Number
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: CardTextField(
                        hint: 'xxxxxxx${method?.card?.last4}',
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
          order: widget.order!,
          paymentMethod: method,
          validateCVC: () {
            if (cvcController.text.isEmpty) {
              Loaders.warningSnackBar(
                title: 'CVC',
                message: 'Please enter CVC',
              );
              return null;
            }
            return cvcController.text;
          },
        ),
      ],
    );
  }
}
