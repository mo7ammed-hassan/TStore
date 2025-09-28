import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';

class ConfirmPaymentDialog {
  ConfirmPaymentDialog._();

  static Future<bool?> confirmDialog(
    BuildContext context,
    OrderEntity? order,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const ResponsiveText('Confirm Payment'),
        content: ResponsiveText(
          maxLines: 3,
          fontSize: 14,
          'Are you sure you want to pay \$${order!.checkoutModel.total.toStringAsFixed(2)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const ResponsiveText('Cancel', fontSize: 14),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
            child: const ResponsiveText('Confirm'),
          ),
        ],
      ),
    );
  }
}
