import 'package:t_store/features/personalization/pages/address/domain/usecases/add_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/delete_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/fetch_all_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/get_selected_address_usecase.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/update_address_usecase.dart';

class AddressUsecases {
  final AddAddressUseCase addressUseCase;
  final FetchAllAddressUseCase fetchAllAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final UpdateAddressUsecase updateAddressUsecase;
  final GetSelectedAddressUsecase getSelectedAddressUseCase;

  AddressUsecases(
    this.addressUseCase,
    this.fetchAllAddressUseCase,
    this.deleteAddressUseCase,
    this.updateAddressUsecase,
    this.getSelectedAddressUseCase,
  );
}
