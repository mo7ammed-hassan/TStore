
class AddressEntity {
  final String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final DateTime? createdAt;
  bool selectedAddress;

  AddressEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.createdAt,
    required this.selectedAddress,
  });

  AddressEntity.empty()
      : id = '',
        name = '',
        phoneNumber = '',
        street = '',
        city = '',
        state = '',
        country = '',
        postalCode = '',
        createdAt = null,
        selectedAddress = false;

  /// copyWith method to create a copy of the AddressEntity with modified fields
  AddressEntity copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? street,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    DateTime? createdAt,
    bool? selectedAddress,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      createdAt: createdAt ?? this.createdAt,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}
