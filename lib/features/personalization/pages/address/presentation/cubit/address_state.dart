import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

enum AddressStatus { initial, loading, success, failure, empty, addedSuccess }

class AddressState {
  final AddressStatus status;
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;
  final String? errorMessage;

  const AddressState({
    this.status = AddressStatus.initial,
    this.addresses = const [],
    this.selectedAddress,
    this.errorMessage,
  });

  AddressState copyWith({
    AddressStatus? status,
    List<AddressEntity>? addresses,
    AddressEntity? selectedAddress,
    String? errorMessage,
  }) {
    return AddressState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
