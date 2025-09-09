import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorageServices {
  Future<void> storeData<T>({required List<T> data, required String box});
  Future<List<T>> fetchData<T>({required String box});
  Future<void> clearData<T>({required String box});
}

class LocalStorageServicesImpl extends LocalStorageServices {
  @override
  Future<void> storeData<T>(
      {required List<T> data, required String box}) async {
    // First open Box
    var openBox = await Hive.openBox<T>(box);

    // Then store data in the box
    await openBox.addAll(data);

    // Finally, close the box
    await Hive.close();
  }

  @override
  Future<List<T>> fetchData<T>({required String box}) async {
    // First open Box
    var openBox = await Hive.openBox<T>(box);

    // Then fetch all data from the box
    var data = openBox.values.toList();

    // Finally, close the box
    await Hive.close();

    return data;
  }

  @override
  Future<void> clearData<T>({required String box}) async {
    // First open Box
    var openBox = await Hive.openBox<T>(box);

    // Then clear all data from the box
    await openBox.clear();

    // Finally, close the box
    await Hive.close();
  }
}
