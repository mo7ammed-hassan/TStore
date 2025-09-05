import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/payment_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._paymentUsecases) : super(PaymentState());
  final PaymentUsecases _paymentUsecases;

  void fetchPaymentMethods() async {
    emit(state.copyWith(loading: true));

    final methods = await _paymentUsecases.getPaymnetMethodUsecase.call();
    emit(state.copyWith(methods: methods, loading: false));
  }

  void selectMethod(PaymentMethodEntity method) {
    emit(state.copyWith(selected: method));
  }

  void confirmPayment(PaymentDetails details) async {
    emit(state.copyWith(paymnetProccessLoading: true));
    if (state.selected == null) return;

    final result = await _paymentUsecases.payUseCase
        .pay(method: state.selected!.method, details: details);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            paymentFaliure: true,
            successPayment: false,
            paymnetProccessLoading: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            successPayment: true,
            paymentFaliure: false,
            paymnetProccessLoading: false,
          ),
        );
      },
    );
  }
}
