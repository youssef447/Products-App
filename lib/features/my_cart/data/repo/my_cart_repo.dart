import 'package:dartz/dartz.dart';
import 'package:meal_tracking/core/error_handler/error_handler_mixin.dart';
import 'package:meal_tracking/core/error_handler/failure.dart';
import 'package:meal_tracking/features/my_cart/model/my_cart_model.dart';

import '../service/my_cart_service.dart';

class MyCartRepo with ErrorHandlerMixin {
  final MyCartService myCartService;
  MyCartRepo({
    required this.myCartService,
  });

  Future<Either<Failure, MyCartModel?>> getMyCart({required int userId}) async {
    return errorHandler(() async {
      final response = await myCartService.getMyCart(userId: userId);
      if (response.data["carts"] == null ||
          (response.data["carts"] as List).isEmpty) {
        return null;
      }
      final result = MyCartModel.fromMap(response.data["carts"][0]);
      return result;
    });
  }

  Future<Either<Failure, MyCartModel?>> updateProductQuantity(
      {required int cartId,
      required int quantity,
      required int productId}) async {
    return errorHandler(() async {
      final response = await myCartService.updateProductQuantity(
          cartId: cartId, productId: productId, quantity: quantity);
      if (response.data == null ||
          (response.data["products"] as List).isEmpty) {
        return null;
      }
      final result = MyCartModel.fromMap(response.data);
      return result;
    });
  }

  Future<Either<Failure, MyCartModel?>> deleteCart({
    required int cartId,
  }) async {
    return errorHandler(() async {
      final response = await myCartService.deleteProduct(
        cartId: cartId,
      );
      if (response.data == null ||
          (response.data["products"] as List).isEmpty) {
        return null;
      }
      final result = MyCartModel.fromMap(response.data);
      return result;
    });
  }

  Future<Either<Failure, MyCartModel>> addToCart(
      {required int userId,
      required List<Map<String, dynamic>> products}) async {
    return errorHandler(() async {
      final res =
          await myCartService.addToCart(userId: userId, products: products);
      return MyCartModel.fromMap(res.data);
    });
  }
}
