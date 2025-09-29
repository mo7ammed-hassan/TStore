import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';

class PaymentMethodsListView extends StatelessWidget {
  const PaymentMethodsListView(
      {super.key, required this.order, required this.methods});

  final OrderEntity? order;
  final List<PaymentMethodEntity<dynamic>> methods;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: methods.length,
            itemBuilder: (context, index) => CardItemWidget(
              key: ValueKey(methods[index].id),
              paymentMethod: methods[index],
            ),
            separatorBuilder: (context, index) => ResponsiveGap.vertical(16),
          ),
        ),
        SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
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
        ),
      ],
    );
  }
}
