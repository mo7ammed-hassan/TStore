import 'package:t_store/features/payment/data/models/card_details_model.dart';
import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';

abstract class IPaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMethods(String customerId);
  Future<PaymentMethodModel?> getDefaultPaymentMethod(String? customerId);
  Future<PaymentMethodModel> addPaymentMethod(
    String? customerId,
    CardDetailsModel cardDetails,
  );
  Future<PaymentMethodModel> updateDefaultPaymentMethod(
      String? customerId, String? methodId);
  Future<void> deletePaymentMethod(String customerId, String methodId);
}
