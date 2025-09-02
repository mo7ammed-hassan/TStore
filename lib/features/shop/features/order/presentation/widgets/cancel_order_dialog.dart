import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_cubit.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

Future<bool> showCancelOrderDialog(BuildContext context,
    {required String orderId}) async {
  final cubit = context.read<OrderCubit>();
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const ResponsiveText('Cancel Order'),
        content: const ResponsiveText(
          'Are you sure you want to cancel this order?\n\n'
          'This action is not reversible and all of your order will be removed permanently.',
          maxLines: 7,
          fontSize: 13,
          textAlign: TextAlign.center,
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: const ResponsiveText('Undow', fontSize: 13),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              side: BorderSide.none,
            ),
            onPressed: () {
              cubit.cancelOrder(orderId);
              Navigator.pop(context, true);
            },
            child: Padding(
              padding:
                  context.responsiveInsets.symmetric(horizontal: TSizes.lg),
              child: const ResponsiveText('Cancel', fontSize: 13),
            ),
          ),
        ],
      );
    },
  );
}
