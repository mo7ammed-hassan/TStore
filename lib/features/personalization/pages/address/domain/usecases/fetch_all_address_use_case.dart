import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';

class FetchAllAddressUseCase
    extends UseCases<Either<String, List<AddressEntity>>, dynamic> {
  final AddressRepository addressRepository;
  FetchAllAddressUseCase(this.addressRepository);
  @override
  Future<Either<String, List<AddressEntity>>> call({params}) async {
    return await addressRepository.fetchAllAddresses();
  }
}
