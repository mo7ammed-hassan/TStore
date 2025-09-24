import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';

extension PaymentMethodMapper on PaymentMethodModel {
  PaymentMethodEntity toEntity() {
    return _PaymentMethodEntityImpl(
      id: id,
      email: email,
      phone: phone,
      type: type,
    );
  }
}

extension PaymentMethodEntityMapper on PaymentMethodEntity {
  PaymentMethodModel toModel() {
    return _PaymentMethodModelImpl(
      id: id,
      email: email,
      phone: phone,
      type: type,
    );
  }
}

/// Private implementation of Entity for mapping
class _PaymentMethodEntityImpl extends PaymentMethodEntity<void> {
  _PaymentMethodEntityImpl({
    required super.id,
    super.email,
    super.phone,
    super.type,
  });

  @override
  void get method {}

  @override
  String get cardType => type ?? 'Card';
}

/// Private implementation of Model for mapping
class _PaymentMethodModelImpl extends PaymentMethodModel<PaymentMethodEntity> {
  _PaymentMethodModelImpl({
    required super.id,
    super.email,
    super.phone,
    super.type,
  });

  @override
  PaymentMethodEntity toEntity() {
    return _PaymentMethodEntityImpl(
      id: id,
      email: email,
      phone: phone,
      type: type,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'type': type,
    };
  }

  @override
  String get cardType => type ?? 'Card';
}
