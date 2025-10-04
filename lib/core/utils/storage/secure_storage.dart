import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _userIdKey = 'user_id';

  Future<String?> getAccessToken() async =>
      await _storage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refresh_token');

  Future<String?> getUserId() async => await _storage.read(key: _userIdKey);

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<void> saveAuthData({
    required String accessToken,
    required String userId,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<void> clearAuthData() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _userIdKey);
  }

  Future<void> deleteAllTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: 'refresh_token');
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: _userIdKey);
  }

  Future<void> saveToken({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<dynamic>? read({required String key}) async {
    await _storage.read(key: key);
  }
  

  Future<void> saveKey({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> deleteKey({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<String?> readKey({required String key}) async {
    return await _storage.read(key: key);
  }

}
