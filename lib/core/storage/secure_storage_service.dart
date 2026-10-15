import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: ApiConstants.keyAccessToken, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConstants.keyAccessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: ApiConstants.keyRefreshToken, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConstants.keyRefreshToken);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: ApiConstants.keyUserId, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: ApiConstants.keyUserId);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
