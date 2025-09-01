import 'package:hive/hive.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';

abstract class AddressLocalDataSource {
  Future<void> addAddress(String userId, AddressModel address);
  Future<List<AddressModel>> getAllAddresses(String userId);
  Future<void> deleteAddress(String userId, String addressId);
  Future<void> updateAddress(String userId, AddressModel address);
  Future<void> clearAll(String userId);
  Future<AddressModel?> getSelectedAddress(String userId);
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  Future<Box<AddressModel>> _openUserBox(String userId) async {
    return await Hive.openBox<AddressModel>('$userId-Addresses');
  }

  @override
  Future<void> addAddress(String userId, AddressModel address) async {
    final box = await _openUserBox(userId);
    await box.put(address.id.toString(), address);
  }

  @override
  Future<List<AddressModel>> getAllAddresses(String userId) async {
    final box = await _openUserBox(userId);
    return box.values.toList();
  }

  @override
  Future<void> deleteAddress(String userId, String addressId) async {
    final box = await _openUserBox(userId);
    await box.delete(addressId.toString());
  }

  @override
  Future<void> updateAddress(String userId, AddressModel address) async {
    final box = await _openUserBox(userId);
    await box.put(address.id.toString(), address);
  }

  @override
  Future<void> clearAll(String userId) async {
    final box = await _openUserBox(userId);
    await box.clear();
  }

  @override
  Future<AddressModel?> getSelectedAddress(String userId) async {
    final box = await _openUserBox(userId);
    try {
      return box.values.firstWhere(
        (element) => element.selectedAddress == true,
      );
    } catch (_) {
      return null;
    }
  }
}
