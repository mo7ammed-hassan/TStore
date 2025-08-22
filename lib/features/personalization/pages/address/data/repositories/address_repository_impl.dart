import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/data/source/address_firebase_services.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';

class AddressRepositoryImpl extends AddressRepository {
  final AddressFirebaseServices addressFirebaseServices;

  AddressRepositoryImpl(this.addressFirebaseServices);

  @override
  Future<Either<String, String>> addNewAddress(
      {required AddressModel address}) async {
    var returnedData =
        await addressFirebaseServices.addNewAddress(address: address);

    return returnedData.fold(
      (error) => Left(error),
      (addressId) => Right(addressId),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(
      {required String addressId}) async {
    try {
      await addressFirebaseServices.deleteAddress(addressId: addressId);

      return Right(unit);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, List<AddressEntity>>> fetchAllAddresses() async {
    var returnedData = await addressFirebaseServices.fetchAddresses();

    return returnedData.fold(
      (error) => Left(error),
      (data) {
        List<AddressEntity> addresses = List.from(data)
            .map((document) => AddressModel.fromSnapshot(document).toEntity())
            .toList();

        return Right(addresses);
      },
    );
  }

  @override
  Future<void> updateSelectedAddress(
      {required String addressId, required bool isSelected}) async {
    await addressFirebaseServices.updateSelectedAddress(
        addressId: addressId, isSelected: isSelected);
  }
}
