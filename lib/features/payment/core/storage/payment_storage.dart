import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_store/features/payment/core/constants/storage_keys.dart';

class PaymentStorage {
  static PaymentStorage? _instance;
  PaymentStorage._internal();

  static PaymentStorage get instance =>
      _instance ??= PaymentStorage._internal();

  static late SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveDefaultMethodId(String methodId) async {
    await _prefs?.setString(StorageKeys.keyDefaultMethodId, methodId);
    await _prefs?.setInt(
      StorageKeys.keyLastUsedMethodId,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  String? getDefaultMethodId() {
    return _prefs?.getString(StorageKeys.keyDefaultMethodId);
  }

  DateTime? getLastFetchedAt() {
    final millis = _prefs?.getInt(StorageKeys.keyLastUsedMethodId);
    return millis != null ? DateTime.fromMillisecondsSinceEpoch(millis) : null;
  }

  Future<void> clear() async {
    await _prefs?.remove(StorageKeys.keyDefaultMethodId);
    await _prefs?.remove(StorageKeys.keyLastUsedMethodId);
  }

  Future<void> updateDefaultMethodId(String? methodId) async {
    await clear();
    if (methodId != null) {
      await _prefs?.setString(StorageKeys.keyDefaultMethodId, methodId);
      await _prefs?.setInt(
        StorageKeys.keyLastUsedMethodId,
        DateTime.now().millisecondsSinceEpoch,
      );
    }
  }
}
