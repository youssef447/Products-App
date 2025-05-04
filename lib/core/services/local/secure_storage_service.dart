import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  static late FlutterSecureStorage storage;

  static init() async {
    storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  static Future<String?> getSecureData({
    required String key,
  }) async {
    return await storage.read(key: key);
  }

  static Future<void> saveSecureData({
    required String key,
    required String value,
  }) async {
    return await storage.write(key: key, value: value);
  }

  static Future<void> removeSecureData({
    required String key,
  }) async {
    return await storage.delete(key: 'user');
  }
}
