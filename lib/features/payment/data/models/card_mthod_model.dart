import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';

class CardMethodModel {
  final String? id;
  final String? name;
  final String? logoUrl;
  final PaymentMethods? method;
  final bool? isOnline;

  CardMethodModel({
    this.id,
    this.name,
    this.logoUrl,
    this.method,
    this.isOnline,
  });
}

extension CardMthodModelMapper on CardMethodModel {
  CardMethodEntity toEntity() {
    return CardMethodEntity(
      id: id ?? '',
      name: name ?? '',
      logoUrl: logoUrl ?? '',
      isOnline: isOnline ?? false,
      method: method ?? PaymentMethods.stripe,
    );
  }
}
