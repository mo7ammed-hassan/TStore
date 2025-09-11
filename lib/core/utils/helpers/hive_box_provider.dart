import 'package:hive/hive.dart';

class HiveBoxProvider {
  static Future<Box<T>> getBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }

    return Hive.box<T>(boxName);
  }
}
