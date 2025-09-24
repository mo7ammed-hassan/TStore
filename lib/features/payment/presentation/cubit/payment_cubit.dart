import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/domain/entities/payment_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/payment_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/update_order_status.dart';
import 'package:t_store/core/utils/constants/enums.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._paymentUsecases) : super(PaymentState());
  final PaymentUsecases _paymentUsecases;

  void fetchServiceMethods() async {
    emit(
      state.copyWith(
        action: PaymentAction.fetch,
        status: PaymentStateStatus.loading,
      ),
    );

    final fetchedMethods =
        await _paymentUsecases.getPaymnetMethodUsecase.call();
    emit(state.copyWith(
      action: PaymentAction.fetch,
      status: PaymentStateStatus.success,
      methods: fetchedMethods,
    ));
  }

  void selectMethod(CardMethodEntity method) {
    emit(
      state.copyWith(
        action: PaymentAction.selectMethod,
        status: PaymentStateStatus.success,
        selectedMethod: method,
      ),
    );
  }

  Future<void> confirmPayment(
    PaymentDetailsEntity details,
    OrderEntity order, {
    CardFlow? cardFlow,
  }) async {
    if (state.selectedMethod == null) return;

    emit(
      state.copyWith(
        action: PaymentAction.processPayment,
        status: PaymentStateStatus.loading,
      ),
    );

    final result = await _paymentUsecases.payUseCase.pay(
      method: state.selectedMethod!.method,
      details: details,
      cardFlow: cardFlow,
    );
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
        final updatedOrder = order.copyWith(
          orderStatus: OrderStatus.processing.name,
          paymentStatus: PaymentStatus.paidPayment.name,
          transactionId: paymentResult.transactionId,
          paymentIntentId: paymentResult.paymentIntentId,
          updatedAt: Timestamp.now(),
        );
        await getIt<UpdateOrderStatusUsecase>().call(order: updatedOrder);

        final paymentResultWithSummary = paymentResult.copyWith(
          orderSummary: updatedOrder.checkoutModel.orderSummary,
          card: details.paymentMethod?.cardType,
        );

        emit(
          state.copyWith(
            action: PaymentAction.processPayment,
            status: PaymentStateStatus.success,
            paymentResult: paymentResultWithSummary,
            message: 'Payment successful',
          ),
        );
      },
    );
  }
}
