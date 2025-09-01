import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

extension AddressModelMapper on AddressModel {
  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      name: name,
      phoneNumber: phoneNumber,
      street: street,
      city: city,
      state: state,
      country: country,
      postalCode: postalCode,
      createdAt: createdAt,
      selectedAddress: selectedAddress,
    );
  }
}

extension AddressEntityMapper on AddressEntity {
  AddressModel toModel() {
    return AddressModel(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      street: street,
      city: city,
      state: state,
      country: country,
      postalCode: postalCode,
      createdAt: createdAt,
      selectedAddress: selectedAddress,
    );
  }
}
