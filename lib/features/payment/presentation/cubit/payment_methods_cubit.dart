import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/get_default_payment_method.dart';
import 'package:t_store/features/payment/domain/usecases/get_saved_payment_methods_usecase.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodState> {
  final GetSavedPaymentMethodsUsecase _getPaymentMethods;
  final GetDefaultPaymentMethod _defaultMethodUsecase;

  PaymentMethodsCubit(this._getPaymentMethods, this._defaultMethodUsecase)
      : super(PaymentMethodState());

  Future<void> loadPaymentMethods(String? customerId) async {
    emit(
      state.copyWith(
        action: PaymentMethodAction.fetch,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result = await _getPaymentMethods(customerId ?? '');

    result.fold(
      (failure) => emit(
        state.copyWith(
          action: PaymentMethodAction.fetch,
          status: PaymentMethodStateStatus.failure,
        ),
      ),
      (methods) => emit(
        state.copyWith(
          action: PaymentMethodAction.fetch,
          status: PaymentMethodStateStatus.success,
          methods: methods,
        ),
      ),
    );
  }

  void getDefaultPaymentMethod(
      {required String? customerId, required CardMethodEntity method}) async {
    emit(
      state.copyWith(
        action: PaymentMethodAction.fetchDefaultMethod,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result = await _defaultMethodUsecase.call(customerId);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            action: PaymentMethodAction.fetchDefaultMethod,
            status: PaymentMethodStateStatus.failure,
            error: error.message,
          ),
        );
      },
      (defaultMethod) {
        emit(
          state.copyWith(
            action: PaymentMethodAction.fetchDefaultMethod,
            status: PaymentMethodStateStatus.success,
            defaultMethod: defaultMethod,
            message: 'Payment Loaded Successfully',
          ),
        );
      },
    );
  }
}
