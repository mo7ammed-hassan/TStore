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
class _PaymentMethodEntityImpl
    extends PaymentMethodEntity<PaymentMethodEntity> {
  _PaymentMethodEntityImpl({
    required super.id,
    super.defaultMethod,
    super.email,
    super.phone,
    super.type,
  });

  @override
  PaymentMethodEntity get method => _PaymentMethodEntityImpl(id: id);

  @override
  String get cardType => type ?? 'Card';

  @override
  PaymentMethodEntity copyWith({required bool defaultMethod}) {
    return _PaymentMethodEntityImpl(id: id, defaultMethod: defaultMethod);
  }
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
