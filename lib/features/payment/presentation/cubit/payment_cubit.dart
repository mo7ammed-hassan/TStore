import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/payment_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._paymentUsecases) : super(PaymentState());
  final PaymentUsecases _paymentUsecases;

  void fetchPaymentMethods() async {
    emit(state.copyWith(
      action: PaymentAction.fetch,
      status: PaymentStatus.loading,
    ));

    final fetchedMethods =
        await _paymentUsecases.getPaymnetMethodUsecase.call();
    emit(state.copyWith(
      action: PaymentAction.fetch,
      status: PaymentStatus.success,
      methods: fetchedMethods,
    ));
  }

  void selectMethod(PaymentMethodEntity method) {
    emit(state.copyWith(
      action: PaymentAction.selectMethod,
      status: PaymentStatus.success,
      selectedMethod: method,
    ));
  }

  void confirmPayment(PaymentDetails details) async {
    if (state.selectedMethod == null) return;

    emit(state.copyWith(
      action: PaymentAction.processPayment,
      status: PaymentStatus.loading,
    ));

    final result = await _paymentUsecases.payUseCase
        .pay(method: state.selectedMethod!.method, details: details);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            action: PaymentAction.processPayment,
            status: PaymentStatus.failure,
            error: error.message,
          ),
        );
      },
      (paymentResult) {
        emit(state.copyWith(
          action: PaymentAction.processPayment,
          status: PaymentStatus.success,
          paymentResult: paymentResult,
          message: 'Payment successful',
        ));
      },
    );
  }
}
