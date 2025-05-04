import 'package:dio/dio.dart';
import 'package:product_tracking/core/constants/api_constants.dart';
import 'package:product_tracking/core/services/remote/dio_service.dart';

class MyCartService {
  Future<Response> getMyCart({required int userId}) async {
    return await DioService.getData(
      method: '${ApiConstants.myCart}/user/20',
    );
  }

  Future<Response> updateProductQuantity(
      {required int cartId,
      required int quantity,
      required int productId}) async {
    return await DioService.putData(
        method: '${ApiConstants.myCart}/$cartId',
        data: {
          'merge': true,
          'products': [
            {
              'id': productId,
              'quantity': quantity,
            },
          ]
        });
  }

  Future<Response> deleteProduct({
    required int cartId,
  }) async {
    return await DioService.deleteData(
      method: '${ApiConstants.myCart}/$cartId',
    );
  }

  Future<Response> addToCart(
      {required int userId,
      required List<Map<String, dynamic>> products}) async {
    return await DioService.postData(
      method: ApiConstants.addToCart,
      data: {
        'userId': userId,
        'products': products,
      },
    );
  }
}
