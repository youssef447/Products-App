import 'package:dio/dio.dart';
import 'package:product_tracking/core/services/remote/dio_service.dart';

import '../../../../../core/constants/api_constants.dart';

class AuthService {
  Future<Response<dynamic>> signIn({
    required Map<String, dynamic> data,
  }) async {
    return await DioService.postData(
      method: ApiConstants.login,
      data: data,
    );
  }

  Future<Response<dynamic>> getCurrentAuthUser() async {
    return await DioService.getData(
      method: ApiConstants.currentAuthUser,
    );
  }
}
