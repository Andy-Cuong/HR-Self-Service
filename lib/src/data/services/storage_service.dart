import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hr_self_service/src/domain/utils/hash.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();

  StorageService() {
    _initiate();
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  // For custom data
  Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getData(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> _initiate() async {
    if (!await _storage.containsKey(key: 'hmac_secret')) {
      final secretKey = generateRandomKey();
      await writeData('hmac_secret', secretKey);
    }
  }
}