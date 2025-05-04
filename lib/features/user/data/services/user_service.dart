import 'package:product_tracking/core/constants/api_constants.dart';
import 'package:product_tracking/core/services/remote/dio_service.dart';

class UserDataSource {
  Future<Map<String, dynamic>?> getUser(String id) async {
    final res = await DioService.getData(method: '${ApiConstants.users}/id');
    return res.data;
  }
}
