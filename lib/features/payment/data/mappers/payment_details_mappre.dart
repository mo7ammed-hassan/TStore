import 'package:t_store/features/payment/data/models/payment_user_data.dart';
import 'package:t_store/features/payment/domain/entities/payment_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_user_data_entity.dart';
import 'package:t_store/features/payment/data/models/payment_details_model.dart';
import 'package:t_store/features/payment/data/models/card_details_model.dart';
/// ---------------- CardDetails ----------------
extension CardDetailsMapper on CardDetailsEntity {
  CardDetailsModel toModel() {
    return CardDetailsModel(
      cardNumber: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      cvcCode: cvcCode,
    );
  }
}

extension CardDetailsModelMapper on CardDetailsModel {
  CardDetailsEntity toEntity() {
    return CardDetailsEntity(
      cardNumber: cardNumber ?? '',
      expMonth: expMonth ?? 0,
      expYear: expYear ?? 0,
      cvcCode: cvcCode ?? '',
    );
  }
}


/// ---------------- PaymentUserData ----------------
extension PaymentUserDataMapper on PaymentUserDataEntity {
  PaymentUserDataModel toModel() {
    return PaymentUserDataModel(
      customerId: customerId,
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
  }
}

extension PaymentUserDataModelMapper on PaymentUserDataModel {
  PaymentUserDataEntity toEntity() {
    return PaymentUserDataEntity(
      customerId: customerId,
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
  }
}

/// ---------------- PaymentDetails ----------------
extension PaymentDetailsMapper on PaymentDetailsEntity {
  PaymentDetailsModel toModel() {
    return PaymentDetailsModel(
      amountMinor: amountMinor,
      currency: currency,
      orderId: orderId,
      meta: meta,
      cardDetails: cardDetails?.toModel(),
      user: user?.toModel(),
      paymentMethodId: paymentMethodId,
      cvc: cvc,
    );
  }
}

extension PaymentDetailsModelMapper on PaymentDetailsModel {
  PaymentDetailsEntity toEntity() {
    return PaymentDetailsEntity(
      amountMinor: amountMinor,
      currency: currency,
      orderId: orderId,
      meta: meta,
      cardDetails: cardDetails?.toEntity(),
      user: user?.toEntity(),
      paymentMethodId: paymentMethodId,
      cvc: cvc,
    );
  }
}



