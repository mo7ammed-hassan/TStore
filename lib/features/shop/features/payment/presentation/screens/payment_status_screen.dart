import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/payment/presentation/widgets/payment_summary.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen({
    super.key,
    this.animation = false,
    required this.imagePath,
    this.paymentSuccess = true,
    this.subTitle = 'There are many variations',
    this.title = 'Payment In Progress',
    this.onTap,
  });
  final bool animation;
  final String imagePath;
  final bool paymentSuccess;
  final String subTitle;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text(TTexts.paymentStatus),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 3,
              child: (animation ? Lottie.asset : Image.asset)(imagePath,
                  fit: BoxFit.scaleDown),
            ),
            SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              subTitle,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
            ),
            Spacer(
              flex: 2,
            ),
            if (paymentSuccess) ...[
              _buildRow(context, label: TTexts.paymentMethod, value: 'VISA'),
              SizedBox(height: 14),
              _buildRow(context, label: 'Date', value: '26 Oct 2025'),
              SizedBox(height: 14),
              _buildRow(context, label: 'Transaction ID', value: 'FT54JN0'),
              SizedBox(height: 14),
              PaymentSummary(),
            ],
            SizedBox(height: 24),
            SafeArea(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: onTap,
                child: Text('Back to Home'),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context,
      {required String label, required String value, TextStyle? style}) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: style ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey : Color(0xFF5a5e64),
                  ),
        ),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
