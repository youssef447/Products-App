import 'package:dio/dio.dart';
import 'package:product_tracking/core/constants/api_constants.dart';
import 'package:product_tracking/core/services/local/secure_storage_service.dart';

abstract class TokenService {
  static Future<String?> getAccessToken() async {
    return await SecureStorageService.getSecureData(key: 'accessToken');
  }

  static Future<String?> getRefreshToken() async {
    return await SecureStorageService.getSecureData(key: 'refreshToken');
  }

  static Future<void> setAccessToken(String accessToken) async {
    await SecureStorageService.saveSecureData(
        key: 'accessToken', value: accessToken);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    await SecureStorageService.saveSecureData(
        key: 'refreshToken', value: refreshToken);
  }

  static Future<void> clearTokens() async {
    await SecureStorageService.removeSecureData(key: 'accessToken');
    await SecureStorageService.removeSecureData(key: 'refreshToken');
  }

  static Future<String?> refreshAccessToken(Dio client) async {
    final String? refreshToken = await getRefreshToken();

    if (refreshToken == null) return null;

    try {
      final response = await client.post(
        ApiConstants.refresh,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final String newAccessToken = response.data['accessToken'];

        await setAccessToken(newAccessToken);
        return newAccessToken;
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 403) {
        // If refresh token expired => logout
        await clearTokens();
      }
    }
    return null;
  }
}
