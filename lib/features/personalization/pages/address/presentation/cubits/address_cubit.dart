import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/personalization/pages/address/data/source/address_local_datasource.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/address_usecases.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._addressUsecases, this.localDataSource)
      : super(AddressInitial());
  final AddressLocalDataSource localDataSource;

  final AddressUsecases _addressUsecases;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  // selected address
  var selectedAddress = AddressEntity.empty();

  // flage to check if first time or not
  bool isFirstTime = true;

  // -- Fetch Addresses--
  Future<void> fetchAddresses() async {
    // final deletstorage =
    //        await  localDataSource.clearAll(userId,);
    if (isFirstTime) {
      emit(FetchAddressesLoadingState());
    }

    /// --- Local call
    final localAddresses = await localDataSource.getAllAddresses(userId);
    if (localAddresses.isNotEmpty) {
      final selectAddress = await localDataSource.getSelectedAddress(userId);
      if (selectAddress != null) {
        selectedAddress = selectAddress.toEntity();
      }

      final userAddresses = localAddresses.map((e) => e.toEntity()).toList();
      emit(FetchAddressesSuccessState(userAddresses));
      isFirstTime = false;

      return;
    }

    /// --- Remote call
    var result = await _addressUsecases.fetchAllAddressUseCase();
    result.fold(
      (failure) {
        emit(FetchAddressesFailureState());
      },
      (addresses) async {
        selectedAddress = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressEntity.empty(),
        );

        final listStorage = addresses
            .map(
              (e) => localDataSource.addAddress(userId, e.toModel()),
            )
            .toList();

        await Future.wait(listStorage);

        isFirstTime = false;
        emit(FetchAddressesSuccessState(addresses));
      },
    );
  }

  // -- Selected Address--
  Future<void> selecteAddress(AddressEntity newSelectedAddress) async {
    if (newSelectedAddress.id == selectedAddress.id) return;
    emit(SelectedAddressLoadingState());
    try {
      final currentSelected = await localDataSource.getSelectedAddress(userId);
      if (currentSelected != null && currentSelected.id!.isNotEmpty) {
        currentSelected.selectedAddress = false;
        await _addressUsecases.updateAddressUsecase(params: (
          currentSelected.id!,
          false,
        ));
        await localDataSource.updateAddress(userId, currentSelected);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress = newSelectedAddress;

      await _addressUsecases.updateAddressUsecase(params: (
        selectedAddress.id,
        true,
      ));

      await localDataSource.updateAddress(userId, selectedAddress.toModel());
      fetchAddresses();

      emit(SelectedAddressSuccessState(selectedAddress));
    } catch (e) {
      emit(SelectedAddressFailureState(e.toString()));
    }
  }

  // -- Add Address--
  Future<void> addNewAddress(AddressModel address) async {
    emit(AddAddressLoadingState());

    final addressData = address.copyWith(createdAt: DateTime.now());
    var result = await _addressUsecases.addressUseCase(params: addressData);
    result.fold(
      (failure) {
        emit(AddAddressFailureState());
      },
      (addressId) async {
        // Save address id
        final newAddress = addressData.copyWith(id: addressId);
        await localDataSource.addAddress(userId, newAddress);
        // trigger SelectedAddress
        await selecteAddress(newAddress.toEntity());
        // trigger FetchAddresses
        await fetchAddresses();
        // resetForm();
        emit(AddAddressSuccessState(addressId));
      },
    );
  }

  // -- Delete Address--
  Future<void> deleteAddress({required String addressId}) async {
    emit(DeleteAddressLoadingState());
    try {
      await _addressUsecases.deleteAddressUseCase(params: addressId);
      await localDataSource.deleteAddress(userId, addressId);
      await fetchAddresses();
      emit(DeleteAddressSuccessState());
    } catch (e) {
      emit(DeleteAddressFailureState());
    }
  }

  // -- Validate Form--
  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // -- Reset Selected Address--
  void resetSelectedAddress() {
    selectedAddress = AddressEntity.empty();
  }
}
