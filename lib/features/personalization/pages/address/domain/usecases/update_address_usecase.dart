import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';

class UpdateAddressUsecase
    extends UseCases<Either, (String id, bool isSelected)> {
  final AddressRepository addressRepository;
  UpdateAddressUsecase(this.addressRepository);

  @override
  Future<Either> call({(String, bool)? params}) async {
    final (id, isSelected) = params!;

    try {
      await addressRepository.updateSelectedAddress(
        addressId: id,
        isSelected: isSelected,
      );

      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
