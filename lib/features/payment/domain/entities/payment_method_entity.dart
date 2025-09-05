import 'package:t_store/features/payment/core/enums/payment_method.dart'
    show PaymentMethods;

class PaymentMethodEntity {
  final String id;
  final String name;
  final PaymentMethods method;
  final String logoUrl;
  final bool isOnline;

  PaymentMethodEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.isOnline,
    required this.method,
  });
}
