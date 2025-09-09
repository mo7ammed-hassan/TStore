import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/payment/core/constants/payment_images.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen({
    super.key,
    this.animation = true,
    this.imagePath = PaymentImages.successPyment,
    this.paymentSuccess = true,
    this.subTitle = 'There are many variations',
    this.title = 'Payment In Progress',
    this.onTap,
    this.orderSummary,
    this.buttonTitle = 'Show Orders',
    this.entryPoint,
  });
  final bool animation;
  final String imagePath;
  final bool paymentSuccess;
  final String subTitle;
  final String title;
  final String buttonTitle;
  final void Function()? onTap;
  final OrderSummaryModel? orderSummary;
  final PaymentEntryPoint? entryPoint;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: false,
          title: TTexts.paymentStatus,
        ),
        body: Padding(
          padding: context.responsiveInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: (animation ? Lottie.asset : Lottie.asset)(
                  imagePath,
                  fit: BoxFit.scaleDown,
                ),
              ),
              ResponsiveGap.vertical(14),
              ResponsiveText(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 20),
              ),
              ResponsiveGap.vertical(8),
              ResponsiveText(
                subTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 13),
              ),
              const Spacer(
                flex: 2,
              ),
              if (paymentSuccess) ...[
                const PaymentSummaryRow(
                    label: TTexts.paymentMethod, value: 'CARD'),
                ResponsiveGap.vertical(14),
                PaymentSummaryRow(
                  label: 'Date',
                  value: HelperFunctions.getFormattedDate(
                    DateTime.now(),
                  ),
                ),
                ResponsiveGap.vertical(14),
                PaymentSummaryRow(
                  label: 'Transaction ID',
                  value: orderSummary?.transactionId?.substring(0, 12) ?? '',
                ),
                ResponsiveGap.vertical(14),
                PaymentSummary(orderSummary: orderSummary),
              ],
              ResponsiveGap.vertical(24),
              SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: onTap,
                  child: ResponsiveText(buttonTitle),
                ),
              ),
              ResponsiveGap.vertical(10),
            ],
          ),
        ),
      ),
    );
  }
}
