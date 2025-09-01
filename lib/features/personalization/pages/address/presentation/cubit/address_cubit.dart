import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/address/data/mapper/address_mapper.dart';
import 'package:t_store/features/personalization/pages/address/data/source/address_local_datasource.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/address_usecases.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubit/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.localDataSource, this._addressUsecases)
      : super(const AddressState());

  final AddressLocalDataSource localDataSource;
  final AddressUsecases _addressUsecases;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool firstTime = true;

  Future<void> fetchAllAddresses() async {
    emit(state.copyWith(status: AddressStatus.loading));

    // -- Local Data Source --
    final localAddresses = await localDataSource.getAllAddresses(userId);
    if (localAddresses.isNotEmpty && !firstTime) {
      final userAddresses = localAddresses.map((e) => e.toEntity()).toList();

      emit(state.copyWith(
        status:
            userAddresses.isEmpty ? AddressStatus.empty : AddressStatus.success,
        addresses: userAddresses,
        selectedAddress: userAddresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressEntity.empty(),
        ),
      ));
      return;
    }

    // -- Remote Data Source --
    final result = await _addressUsecases.fetchAllAddressUseCase();
    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          errorMessage: failure.toString(),
        ));
      },
      (addresses) async {
        // Save locally
        final added = addresses
            .map((e) => localDataSource.addAddress(userId, e.toModel()))
            .toList();
        await Future.wait(added);

        emit(state.copyWith(
          status:
              addresses.isEmpty ? AddressStatus.empty : AddressStatus.success,
          addresses: addresses,
          selectedAddress: addresses.firstWhere(
            (e) => e.selectedAddress,
            orElse: () => AddressEntity.empty(),
          ),
        ));

        firstTime = true;
      },
    );
  }

  Future<void> addAddress(AddressEntity address) async {
    emit(state.copyWith(status: AddressStatus.loading));

    final result =
        await _addressUsecases.addressUseCase(params: address.toModel());
    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          errorMessage: failure.toString(),
        ));
      },
      (addressId) async {
        final newAddress = address.toModel().copyWith(id: addressId);
        await localDataSource.addAddress(userId, newAddress);

        List<AddressEntity> updated = List.from(state.addresses)
          ..add(newAddress.toEntity());

        if (newAddress.selectedAddress) {
          await updateSelectAddress(newAddress.toEntity());
        } else {
          updated.add(newAddress.toEntity());
        }

        emit(state.copyWith(
          status: AddressStatus.addedSuccess,
          addresses: updated,
          selectedAddress: newAddress.toEntity(),
        ));
      },
    );
  }

  Future<AddressEntity?> updateSelectAddress(AddressEntity address) async {
    final updatedAddress = address.toModel().copyWith(selectedAddress: true);
    final previuslySelected =
        state.selectedAddress?.copyWith(selectedAddress: false);

    final updatedList = state.addresses.map((addr) {
      if (addr.id == address.id) {
        return updatedAddress.toEntity();
      } else {
        return addr.copyWith(selectedAddress: false);
      }
    }).toList();

    emit(state.copyWith(
      status: AddressStatus.success,
      addresses: updatedList,
      selectedAddress: updatedAddress.toEntity(),
    ));

    final result = await _addressUsecases.updateAddressUsecase(
      params: (address.id, true),
    );

    return await result.fold(
      (failure) {
        emit(state.copyWith(
          status: AddressStatus.failure,
          errorMessage: failure.toString(),
        ));
        return null;
      },
      (_) async {
        await localDataSource.updateAddress(userId, updatedAddress);

        if (state.addresses.isNotEmpty &&
            previuslySelected != null &&
            previuslySelected.id.isNotEmpty &&
            previuslySelected.id != address.id) {
          await localDataSource.updateAddress(
            userId,
            previuslySelected.toModel(),
          );
          await _addressUsecases.updateAddressUsecase(
            params: (previuslySelected.id, false),
          );
        }

        return updatedAddress.toEntity();
      },
    );
  }

  Future<void> deleteAddress(String addressId) async {
    final oldAddresses = List<AddressEntity>.from(state.addresses);
    final index = oldAddresses.indexWhere((a) => a.id == addressId);

    if (index == -1) {
      emit(state.copyWith(
        status: AddressStatus.failure,
        errorMessage: 'Address not found',
      ));
      return;
    }

    AddressEntity? newSelected;
    if (oldAddresses[index].selectedAddress) {
      if (oldAddresses.length > 1) {
        newSelected = oldAddresses.firstWhere((a) => a.id != addressId);
        await updateSelectAddress(newSelected);
      } else {
        newSelected = AddressEntity.empty();
      }
    }

    // optimistic remove
    final updated = List<AddressEntity>.from(oldAddresses)..removeAt(index);
    emit(state.copyWith(
      status: updated.isEmpty ? AddressStatus.empty : AddressStatus.success,
      addresses: updated,
      selectedAddress: newSelected,
    ));

    final result =
        await _addressUsecases.deleteAddressUseCase(params: addressId);

    result.fold(
      (failure) {
        // rollback
        emit(state.copyWith(
          status: AddressStatus.failure,
          errorMessage: failure.toString(),
          addresses: oldAddresses,
          selectedAddress: state.selectedAddress,
        ));
      },
      (_) async {
        await localDataSource.deleteAddress(userId, addressId);
      },
    );
  }

  // List<AddressEntity> _reorderAddresses(List<AddressEntity> addresses) {
  //   final selected = addresses.where((a) => a.selectedAddress).toList();
  //   final others = addresses.where((a) => !a.selectedAddress).toList();
  //   return [...selected, ...others];
  // }
}
