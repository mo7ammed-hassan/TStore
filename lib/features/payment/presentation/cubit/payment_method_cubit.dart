import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/usecases/payment_method_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final PaymentMethodUsecases _paymentMethodUsecases;

  PaymentMethodCubit(this._paymentMethodUsecases) : super(PaymentMethodState());

  Future<void> loadPaymentMethods(String? customerId) async {
    emit(
      state.copyWith(
        action: PaymentMethodAction.fetch,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result =
        await _paymentMethodUsecases.getPaymentMethods.call(customerId ?? '');

    result.fold((failure) {
      emit(
        state.copyWith(
          action: PaymentMethodAction.fetch,
          status: PaymentMethodStateStatus.failure,
        ),
      );
    }, (methods) {
      emit(
        state.copyWith(
          action: PaymentMethodAction.fetch,
          status: PaymentMethodStateStatus.success,
          defaultMethod: methods.isNotEmpty
              ? methods.firstWhere((element) => element.defaultMethod == true)
              : null,
          methods: methods,
        ),
      );
    });
  }

  Future<void> getDefaultPaymentMethod(
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

  Future<void> updateDefaultMethod(
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

  Future<void> addPaymentMethod(CardDetailsEntity details) async {
    emit(
      state.copyWith(
        action: PaymentMethodAction.updateDefaultMethod,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result = await _paymentMethodUsecases.addPaymentMethodUsecase
        .call(customerId: details.userData?.customerId, cardDetails: details);

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
          title: 'Add Method',
          message: state.error ?? '',
        );
      },
      (defaultMethod) {
        final methods = state.methods..add(defaultMethod);
        emit(
          state.copyWith(
            action: PaymentMethodAction.updateDefaultMethod,
            status: PaymentMethodStateStatus.success,
            defaultMethod: defaultMethod,
            methods: methods,
            message: 'New method added successfully',
          ),
        );
        Loaders.successSnackBar(
          duration: 1,
          title: 'Add Method',
          message: state.message ?? '',
        );
      },
    );
  }

  Future<void> deletePaymentMethod(
      {required String customerId, required String methodId}) async {
    emit(
      state.copyWith(
        action: PaymentMethodAction.updateDefaultMethod,
        status: PaymentMethodStateStatus.loading,
      ),
    );

    final result = await _paymentMethodUsecases.deletePaymentMethodUsecase
        .call(customerId: customerId, methodId: methodId);

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
          title: 'delete Method',
          message: state.error ?? '',
        );
      },
      (_) {
        final index =
            state.methods.indexWhere((element) => element.id == methodId);
        state.methods.removeAt(index);

        emit(
          state.copyWith(
            action: PaymentMethodAction.updateDefaultMethod,
            status: PaymentMethodStateStatus.success,
            methods: [...state.methods],
            message: 'method deleted successfully',
          ),
        );
        Loaders.successSnackBar(
          duration: 1,
          title: 'delete Method',
          message: state.message ?? '',
        );
      },
    );
  }
}
