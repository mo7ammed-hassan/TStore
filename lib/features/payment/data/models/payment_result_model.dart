import 'package:t_store/features/checkout/data/models/order_summary_model.dart';

class PaymentResultModel {
  final bool? success;
  final String? transactionId;
  final String? clientSecret;
  final String? paymentIntentId;
  final String? card;
  final String? message;
  final OrderSummaryModel? orderSummary;

  const PaymentResultModel({
    this.success,
    this.clientSecret,
    this.transactionId,
    this.paymentIntentId,
    this.message,
    this.card,
    this.orderSummary,
  });
}
