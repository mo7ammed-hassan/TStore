import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/payment/domain/usecases/get_saved_payment_methods_usecase.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  final GetSavedPaymentMethodsUsecase _getPaymentMethods;

  PaymentMethodsCubit(this._getPaymentMethods) : super(PaymentMethodsInitial());

  Future<void> loadPaymentMethods(String? customerId) async {
    emit(PaymentMethodsLoading());

    final result = await _getPaymentMethods(customerId ?? '');

    result.fold(
      (failure) => emit(PaymentMethodsError(failure.message)),
      (methods) => emit(PaymentMethodsLoaded(methods)),
    );
  }
}
