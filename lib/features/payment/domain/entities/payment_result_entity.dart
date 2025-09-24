import 'package:t_store/features/checkout/domain/entities/order_summary_entity.dart';

class PaymentResultEntity {
  final bool success;
  final String? clientSecret; // for stripe
  final String? transactionId; // for Vodafone / DVD
  final String? paymentIntentId;
  final String? card;
  final String message;
  final OrderSummaryEntity? orderSummary;

  PaymentResultEntity({
    required this.success,
    this.clientSecret,
    this.transactionId,
    this.paymentIntentId,
    this.card,
    required this.message,
    this.orderSummary,
  });

  // copyWith method to create a copy of the entity with modified fields
  PaymentResultEntity copyWith({
    bool? success,
    String? clientSecret,
    String? transactionId,
    String? paymentIntentId,
    String? card,
    String? message,
    OrderSummaryEntity? orderSummary,
  }) {
    return PaymentResultEntity(
      success: success ?? this.success,
      clientSecret: clientSecret ?? this.clientSecret,
      transactionId: transactionId ?? this.transactionId,
      paymentIntentId: paymentIntentId ?? this.paymentIntentId,
      card: card ?? this.card,
      message: message ?? this.message,
      orderSummary: orderSummary ?? this.orderSummary,
    );
  }
}
