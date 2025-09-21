import 'package:t_store/features/payment/data/models/customer/customer_model.dart';
import 'package:t_store/features/payment/domain/entities/customer/customer_entity.dart';

extension CustomerEntityMapper on CustomerEntity {
  CustomerModel toModel() {
    return CustomerModel(
      id: id,
      email: email,
      name: name,
      phone: phone,
      defaultSource: defaultSource,
      defaultPaymentMethod: defaultPaymentMethod,
    );
  }
}

extension CustomerModelMapper on CustomerModel {
  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      email: email,
      name: name,
      phone: phone,
      defaultSource: defaultSource,
      defaultPaymentMethod: defaultPaymentMethod,
    );
  }
}
