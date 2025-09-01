import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

abstract class AddressRepository {
  Future<Either<String, List<AddressEntity>>> fetchAllAddresses();
  Future<Either> addNewAddress({required AddressModel address});
  Future<Either<Failure, Unit>> deleteAddress({required String addressId});
  Future<void> updateSelectedAddress(
      {required String addressId, required bool isSelected});
  Future<AddressEntity> getSelectedAddress();
}
