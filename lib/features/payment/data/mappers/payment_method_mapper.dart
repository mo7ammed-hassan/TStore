import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/data/models/payment_method_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

extension PaymentMethodMapper on PaymentMethodModel {
  PaymentMethodEntity toEntity() {
    return PaymentMethodEntity(
      id: id ?? '',
      name: name ?? '',
      logoUrl: logoUrl ?? '',
      method: method ?? PaymentMethods.stripe,
      isOnline: isOnline ?? false,
    );
  }
}
