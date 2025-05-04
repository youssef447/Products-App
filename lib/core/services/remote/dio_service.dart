import 'package:dio/dio.dart';
import 'package:meal_tracking/core/services/remote/interceptors/jwt_interceptor.dart';

import 'interceptors/debounce_interceptor.dart';

class DioService {
  static late final Dio dio;
  static init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
        },
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        //  validateStatus: (_) => true,
      ),
    );
    dio.interceptors.addAll([
      JwtInterceptor(dio),
      DebounceInterceptor(),
    ]);
  }

  static Future<Response> getData({
    required String method,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    dio.options.headers['lang'] = lang;

    final res = await dio.get(
      method,
      queryParameters: query,
    );
    return res;
  }

  static Future<Response> postData({
    required String method,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
  }) async {
    dio.options.headers['lang'] = lang;

    return await dio.post(
      method,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String method,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
  }) async {
    dio.options.headers['lang'] = lang;

    return await dio.put(
      method,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String method,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
  }) async {
    dio.options.headers['lang'] = lang;

    return await dio.delete(
      method,
      queryParameters: query,
      data: data,
    );
  }
}
