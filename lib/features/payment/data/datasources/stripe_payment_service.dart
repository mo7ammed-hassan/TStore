import 'package:t_store/features/payment/data/datasources/payment_service.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

class StripePaymentService implements IPaymentService {
  @override
  Future<PaymentResultEntity> pay({
    required double amount,
    required String orderId,
    Map<String, dynamic>? extraData,
  }) async {
    // Call Stripe API
    return PaymentResultEntity(
      success: true,
      transactionId: 'stripe_tx_123',
      message: 'Stripe Payment Successful',
    );
  }
}
