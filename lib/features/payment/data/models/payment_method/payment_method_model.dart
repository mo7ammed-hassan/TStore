import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

abstract class PaymentMethodModel<T extends PaymentMethodEntity> {
  final String id;
  final String? email;
  final String? phone;

  PaymentMethodModel({required this.id, this.email, this.phone});

  Map<String, dynamic> toJson();

  T toEntity();
}
