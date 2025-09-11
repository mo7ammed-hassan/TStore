import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';

class DeleteAddressUseCase extends UseCases<Either<Failure, Unit>, String> {
  final AddressRepository addressRepository;
  DeleteAddressUseCase(this.addressRepository);

  @override
  Future<Either<Failure, Unit>> call({String? params}) async {
    return await addressRepository.deleteAddress(addressId: params!);
  }
}
