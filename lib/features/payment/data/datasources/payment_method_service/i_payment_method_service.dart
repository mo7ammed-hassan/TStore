import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';

abstract class IPaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMethods(String customerId);
  Future<PaymentMethodModel> addPaymentMethod(
    String customerId,
    PaymentMethodModel method,
  );
  Future<PaymentMethodModel> updatePaymentMethod(PaymentMethodModel method);
  Future<void> deletePaymentMethod(String customerId, String methodId);

  Future<PaymentMethodModel?> getDefaultPaymentMethod(String? customerId);

  Future<PaymentMethodModel> updateDefaultPaymentMethod(String? customerId, String? methodId);
}
