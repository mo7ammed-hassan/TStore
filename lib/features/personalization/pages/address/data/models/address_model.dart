import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
part 'address_model.g.dart';

@HiveType(typeId: 8)
class AddressModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phoneNumber;
  @HiveField(3)
  final String street;
  @HiveField(4)
  final String city;
  @HiveField(5)
  final String state;
  @HiveField(6)
  final String country;
  @HiveField(7)
  final String postalCode;
  @HiveField(8)
  final DateTime? createdAt;
  @HiveField(9)
  bool selectedAddress;

  AddressModel({
    this.id,
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
      id: data?['id'] ,
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
        'id': id,
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

  AddressModel copyWith({
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
    return AddressModel(
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

  factory AddressModel.empty() {
    return AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      country: '',
      postalCode: '',
      createdAt: null,
      selectedAddress: false,
    );
  }
}

extension AddressXModel on AddressModel {
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
