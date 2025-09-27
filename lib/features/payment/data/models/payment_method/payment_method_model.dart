import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';

abstract class PaymentMethodModel<T extends PaymentMethodEntity> {
  final String id;
  final String? email;
  final String? phone;
  final String? type;

  PaymentMethodModel({
    required this.id,
    this.email,
    this.phone,
    this.type,
  });

  Map<String, dynamic> toJson();

  String get cardType;

  T toEntity();
}
