import 'package:get/get.dart';
import 'package:meal_tracking/features/my_cart/data/repo/my_cart_repo.dart';
import 'package:meal_tracking/features/my_cart/model/my_cart_model.dart';

import '../../../user/controller/user_controller.dart';

class MyCartsController extends GetxController {
  final MyCartRepo myCartRepo;

  MyCartsController(this.myCartRepo);

  @override
  void onInit() {
    super.onInit();
    getMyCart();
  }

  MyCartModel? myCart;
  bool loading = true;
  getMyCart() async {
    final userId = Get.find<UserController>().user!.id;
    final res = await myCartRepo.getMyCart(userId: userId);
    loading = false;
    update();
    res.fold((ifLeft) => Get.snackbar('Error', ifLeft.message), (r) {
      myCart = r;
    });
  }

  updateProductQuantity({required int id, required int quantity}) async {
    loading = true;
    update();
    final res = await myCartRepo.updateProductQuantity(
        cartId: myCart!.id, productId: id, quantity: quantity);
    loading = false;
    update();
    res.fold((ifLeft) => Get.snackbar('Error', ifLeft.message), (r) {
      myCart = r;
      loading = false;
      update();
    });
  }

  deleteCart() async {
    loading = true;
    update();
    final res = await myCartRepo.deleteCart(cartId: myCart!.id);
    loading = false;
    update();
    res.fold((ifLeft) => Get.snackbar('Error', ifLeft.message), (r) {
      myCart = r;
      loading = false;
      update();
    });
  }
}
