import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';

class AddAddressUseCase extends UseCases<Either, AddressModel> {
  final AddressRepository addressRepository;
  AddAddressUseCase(this.addressRepository);
  @override
  Future<Either> call({AddressModel? params}) async {
    return await addressRepository.addNewAddress(address: params!);
  }
}
