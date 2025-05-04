import 'package:dartz/dartz.dart';
import 'package:product_tracking/core/error_handler/error_handler_mixin.dart';
import 'package:product_tracking/core/error_handler/failure.dart';

import 'package:product_tracking/features/home/data/model/product_model.dart';

import '../service/product_service.dart';

class ProductRepo with ErrorHandlerMixin {
  final ProductService productService;
  ProductRepo({
    required this.productService,
  });

  Future<Either<Failure, List<ProductModel>>> searchProducts(String name,
      {int? skip, int? limit}) async {
    return errorHandler(() async {
      final res =
          await productService.searchProducts(name, skip: skip, limit: limit);
      if (res.data?['products'] == null) return [];
      final result = (res.data?['products'] as List<dynamic>)
          .map((e) => ProductModel.fromMap(e))
          .toList();
      return result;
    });
  }

  Future<Either<Failure, List<ProductModel>>> getProducts(
      {String? category, int? limit, int? skip}) async {
    return errorHandler(() async {
      final res = await productService.getProducts(
          limit: limit, category: category, skip: skip);
      if (res.data?['products'] == null) return [];
      final result = (res.data?['products'] as List<dynamic>)
          .map((e) => ProductModel.fromMap(e))
          .toList();
      return result;
    });
  }

  Future<Either<Failure, List<dynamic>>> getCategories() async {
    return errorHandler(() async {
      final res = await productService.getcategories();
      if (res.data == null) return [];
      final result = (res.data as List<dynamic>);
      return result;
    });
  }

  Future<Either<Failure, List<ProductModel>>> filterProducts(
      String category) async {
    return errorHandler(() async {
      final res = await productService.filterProducts(category);
      if (res.data?['products'] == null) return [];

      final result = (res.data?['products'] as List<dynamic>)
          .map((e) => ProductModel.fromMap(e))
          .toList();
      return result;
    });
  }
}
