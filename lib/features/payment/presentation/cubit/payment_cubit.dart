import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/payment_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/update_order_status.dart';
import 'package:t_store/utils/constants/enums.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._paymentUsecases) : super(PaymentState());
  final PaymentUsecases _paymentUsecases;

  void fetchPaymentMethods() async {
    emit(state.copyWith(
      action: PaymentAction.fetch,
      status: PaymentStateStatus.loading,
    ));

    final fetchedMethods =
        await _paymentUsecases.getPaymnetMethodUsecase.call();
    emit(state.copyWith(
      action: PaymentAction.fetch,
      status: PaymentStateStatus.success,
      methods: fetchedMethods,
    ));
  }

  void selectMethod(PaymentMethodEntity method) {
    emit(state.copyWith(
      action: PaymentAction.selectMethod,
      status: PaymentStateStatus.success,
      selectedMethod: method,
    ));
  }

  void confirmPayment(
    PaymentDetails details,
    PaymentStatus paymnetStatus,
  ) async {
    if (state.selectedMethod == null) return;

    emit(state.copyWith(
      action: PaymentAction.processPayment,
      status: PaymentStateStatus.loading,
    ));

    final result = await _paymentUsecases.payUseCase
        .pay(method: state.selectedMethod!.method, details: details);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            action: PaymentAction.processPayment,
            status: PaymentStateStatus.failure,
            error: error.message,
          ),
        );
      },
      (paymentResult) async {
        await getIt<UpdateOrderStatusUsecase>().call(
          orderId: details.orderId,
          orderStatus: OrderStatus.processing,
          paymentStatus: paymnetStatus,
        );

        emit(state.copyWith(
          action: PaymentAction.processPayment,
          status: PaymentStateStatus.success,
          paymentResult: paymentResult,
          message: 'Payment successful',
        ));
      },
    );
  }
}
