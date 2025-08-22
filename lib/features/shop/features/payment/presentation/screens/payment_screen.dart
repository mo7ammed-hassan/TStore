import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/shop/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/shop/features/payment/presentation/widgets/confirm_payment_button.dart';
import 'package:t_store/features/shop/features/payment/presentation/widgets/payment_card.dart';
import 'package:t_store/features/shop/features/payment/presentation/widgets/payment_summary.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit()..fetchPaymentMethods(),
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(TTexts.paymentDetails),
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.methods.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final method = state.methods[index];
                      return PaymentMethodCard(
                        method: method,
                        selected: state.selected?.id == method.id,
                        onTap: () =>
                            context.read<PaymentCubit>().selectMethod(method),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const PaymentSummary(),
                ),
                ConfirmPaymentButton(
                  enabled: state.selected != null,
                  onPressed: () =>
                      context.read<PaymentCubit>().confirmPayment(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
