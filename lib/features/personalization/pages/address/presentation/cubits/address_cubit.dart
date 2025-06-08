import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/add_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/delete_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/fetch_all_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';
import 'package:t_store/service_locator.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  // keys and controllers
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // selected address
  var selectedAddress = AddressEntity.empty();

  // flage to check if first time or not
  bool isFirstTime = true;

  // -- Previous Address--
  AddressEntity? previousAddress = AddressEntity.empty();

  // -- Fetch Addresses--
  Future<void> fetchAllAddresses() async {
    if (isFirstTime) {
      emit(FetchAddressesLoadingState());
    }

    var result = await getIt.get<FetchAllAddressUseCase>().call();

    result.fold(
      (failure) {
        emit(FetchAddressesFailureState());
      },
      (addresses) {
        selectedAddress = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressEntity.empty(),
        );
        isFirstTime = false;
        if (addresses.isNotEmpty) {
          previousAddress = addresses.last;
        }

        emit(FetchAddressesSuccessState(addresses));
      },
    );
  }

  // --Selected Address--
  Future<void> selecteAddress(AddressEntity newSelectedAddress) async {
    emit(SelectedAddressLoadingState());
    try {
      if (selectedAddress.id.isNotEmpty) {
        await getIt.get<AddressRepository>().updateSelectedAddress(
              addressId: selectedAddress.id,
              isSelected: false,
            );
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress = newSelectedAddress;

      await getIt.get<AddressRepository>().updateSelectedAddress(
            addressId: selectedAddress.id,
            isSelected: true,
          );

      emit(SelectedAddressSuccessState(selectedAddress));
    } catch (e) {
      emit(
        SelectedAddressFailureState(e.toString()),
      );
    }
  }

  // -- Add Address--
  Future<void> addNewAddress() async {
    emit(AddAddressLoadingState());

    // Save address data
    final AddressModel addressData = AddressModel(
      id: '',
      name: nameController.text,
      phoneNumber: phoneController.text,
      street: streetController.text,
      postalCode: postalCodeController.text,
      city: cityController.text,
      state: stateController.text,
      country: countryController.text,
      createdAt: DateTime.now(),
      selectedAddress: true,
    );

    var result = await getIt.get<AddAddressUseCase>().call(params: addressData);

    result.fold(
      (failure) {
        emit(AddAddressFailureState());
      },
      (addressId) async {
        // Save address id
        addressData.id = addressId;
        // trigger SelectedAddress
        await selecteAddress(addressData.toEntity());
        // trigger FetchAddresses
        await fetchAllAddresses();
        resetForm();
        emit(AddAddressSuccessState(addressId));
      },
    );
  }

  // -- Delete Address--
  Future<void> deleteAddress({required String addressId}) async {
    emit(DeleteAddressLoadingState());
    try {
      await getIt.get<DeleteAddressUseCase>().call(params: addressId);
      await fetchAllAddresses();
      await selecteAddress(previousAddress!);
      emit(DeleteAddressSuccessState());
    } catch (e) {
      emit(DeleteAddressFailureState());
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    return super.close();
  }

  // -- Validate Form--
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // -- Reset Form--
  void resetForm() {
    nameController.clear();
    phoneController.clear();
    streetController.clear();
    postalCodeController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
  }

  // -- Reset Selected Address--
  void resetSelectedAddress() {
    selectedAddress = AddressEntity.empty();
  }
}
