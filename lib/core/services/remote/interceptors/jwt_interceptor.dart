import 'package:dio/dio.dart';

import '../../../../features/auth/login/data/data_source/token_service.dart';

class JwtInterceptor extends Interceptor {
  final Dio client;

  JwtInterceptor(this.client);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = await TokenService.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //unauthorized
    if (err.response?.statusCode == 401) {
      final String? newAccessToken =
          await TokenService.refreshAccessToken(client);

      if (newAccessToken != null) {
        final options = err.requestOptions;

        options.headers['Authorization'] = 'Bearer $newAccessToken';

        return handler.resolve(await _retry(options));
      }
    } // Continue with the error
    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return client.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
