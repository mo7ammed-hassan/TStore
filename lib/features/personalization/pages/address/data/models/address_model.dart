import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final DateTime? createdAt;
  bool selectedAddress;

  AddressModel({
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

  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return AddressModel(
      id: snapshot.id,
      name: data?['name'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      street: data?['street'] ?? '',
      city: data?['city'] ?? '',
      state: data?['state'] ?? '',
      country: data?['country'] ?? '',
      postalCode: data?['postalCode'] ?? '',
      createdAt: data?['createdAt']?.toDate(),
      selectedAddress: data?['selectedAddress'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
        'createdAt': createdAt,
        'selectedAddress': selectedAddress,
      };

      // --from json

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel( 
        id: json['id'] ?? '',
        name: json['name'], 
        phoneNumber: json['phoneNumber'], 
        street: json['street'], 
        city: json['city'], 
        state: json['state'], 
        country: json['country'], 
        postalCode: json['postalCode'], 
        createdAt:  json['createdAt'] is Timestamp ? (json['createdAt'] as Timestamp).toDate() : DateTime.tryParse(json['createdAt']) ?? DateTime.now(), 
        selectedAddress: json['selectedAddress'], 
      );

  factory AddressModel.empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        country: '',
        postalCode: '',
        createdAt: DateTime.now(),
        selectedAddress: false,
      );

  static AddressModel fromEntity(AddressEntity addressEntity) {
    return AddressModel(
      id: addressEntity.id,
      name: addressEntity.name,
      phoneNumber: addressEntity.phoneNumber,
      street: addressEntity.street,
      city: addressEntity.city,
      state: addressEntity.state,
      country: addressEntity.country,
      postalCode: addressEntity.postalCode,
      createdAt: addressEntity.createdAt,
      selectedAddress: addressEntity.selectedAddress,
    );
  }
}

extension AddressXModel on AddressModel {
  AddressEntity toEntity() {
    return AddressEntity(
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
