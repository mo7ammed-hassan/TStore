import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/payment_method_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodState> {
  final PaymentMethodUsecases _paymentMethodUsecases;

  PaymentMethodsCubit(this._paymentMethodUsecases)
      : super(PaymentMethodState());

  Future<void> loadPaymentMethods(String? customerId) async {
    emit(
      state.copyWith(
        action: PaymentMethodAction.fetch,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result =
        await _paymentMethodUsecases.getPaymentMethods.call(customerId ?? '');

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
          defaultMethod:
              methods.firstWhere((element) => element.defaultMethod == true),
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

    final result =
        await _paymentMethodUsecases.defaultMethodUsecase.call(customerId);

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

  void updateDefaultMethod(
    PaymentMethodEntity method,
    String? customerId,
  ) async {
    if (customerId == null || state.defaultMethod?.id == method.id) return;

    emit(
      state.copyWith(
        action: PaymentMethodAction.updateDefaultMethod,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result = await _paymentMethodUsecases.updateDefaultMethodUsecase
        .call(customerId: customerId, methodId: method.id);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            action: PaymentMethodAction.updateDefaultMethod,
            status: PaymentMethodStateStatus.failure,
            error: error.message,
          ),
        );
        Loaders.errorSnackBar(
          duration: 1,
          title: 'Update Default Method',
          message: state.error ?? '',
        );
      },
      (defaultMethod) {
        emit(
          state.copyWith(
            action: PaymentMethodAction.updateDefaultMethod,
            status: PaymentMethodStateStatus.success,
            defaultMethod: defaultMethod,
            message: 'Default method updated successfully',
          ),
        );
        Loaders.successSnackBar(
          duration: 1,
          title: 'Update Default Method',
          message: state.message ?? '',
        );
      },
    );
  }
}
