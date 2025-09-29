import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';

class EmptyManageCardView extends StatelessWidget {
  const EmptyManageCardView({super.key, required this.order});

  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ResponsiveText(
            'No bank cards added yet.',
          ),
          ResponsiveGap.vertical(20),
          SizedBox(
            width: context.horzSize(150),
            child: ElevatedButton(
              onPressed: () => order != null
                  ? Navigator.pushNamed(
                      context,
                      PaymentRoutes.addPaymentMethodScreen,
                      arguments: order,
                    )
                  : context.pushPage(
                      MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => getIt<PaymentCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<PaymentMethodCubit>(),
                          ),
                        ],
                        child: const AddPaymentMethodScreen(),
                      ),
                    ),
              child: const ResponsiveText('Add Bank Card'),
            ),
          ),
        ],
      ),
    );
  }
}
