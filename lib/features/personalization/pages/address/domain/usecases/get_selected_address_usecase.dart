import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';

class GetSelectedAddressUsecase extends UseCases<AddressEntity, dynamic> {
  final AddressRepository addressRepository;
  GetSelectedAddressUsecase(this.addressRepository);

  @override
  Future<AddressEntity> call({params}) async {
    return addressRepository.getSelectedAddress();
  }
}
