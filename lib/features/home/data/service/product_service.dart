import 'package:dio/dio.dart';
import 'package:meal_tracking/core/services/remote/dio_service.dart';

import '../../../../core/constants/api_constants.dart';

class ProductService {
  Future<Response> getProducts(
      {int? limit, int? skip, String? category}) async {
    final method = category == null
        ? ApiConstants.products
        : '${ApiConstants.products}/category/$category';
    return await DioService.getData(
      method: method,
      query: limit != null ? {'limit': limit, 'skip': skip} : null,
    );
  }

  Future<Response> getcategories() async {
    return await DioService.getData(
      method: ApiConstants.categoryList,
    );
  }

  Future<Response> searchProducts(String name, {int? skip, int? limit}) async {
    return await DioService.getData(
      method: ApiConstants.search,
      query: {'q': name, 'limit': limit, 'skip': skip},
    );
  }

  Future<Response> filterProducts(String category) async {
    return await DioService.getData(
      method: ApiConstants.filter,
      query: {'c': category},
    );
  }
}
