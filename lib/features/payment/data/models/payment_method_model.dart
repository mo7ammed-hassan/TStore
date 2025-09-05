import 'package:t_store/features/payment/core/enums/payment_method.dart';

class PaymentMethodModel {
  final String? id;
  final String? name;
  final String? logoUrl;
  final PaymentMethods? method;
  final bool? isOnline;

  PaymentMethodModel(
      {this.id, this.name, this.logoUrl, this.method, this.isOnline});
}
