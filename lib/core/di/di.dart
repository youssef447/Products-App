import 'package:get/get.dart';
import 'package:meal_tracking/core/constants/api_constants.dart';
import 'package:meal_tracking/core/services/local/app_cache_service.dart';
import 'package:meal_tracking/core/services/local/secure_storage_service.dart';
import 'package:meal_tracking/core/services/remote/dio_service.dart';
import 'package:meal_tracking/core/theme/controller/app_theme_controller.dart';
import 'package:meal_tracking/features/auth/login/data/repo/login_repo.dart';
import 'package:meal_tracking/features/auth/login/presentation/controller/login_controller.dart';
import 'package:meal_tracking/features/home/data/repo/product_remote_repo.dart';
import 'package:meal_tracking/features/home/presentation/controller/home_page_controller.dart';
import 'package:meal_tracking/features/my_cart/data/repo/my_cart_repo.dart';
import 'package:meal_tracking/features/my_cart/data/service/my_cart_service.dart';
import 'package:meal_tracking/features/my_cart/presentation/controller/my_cart_controller.dart';
import 'package:meal_tracking/features/navbar/controller/home_navbar_controller.dart';
import 'package:meal_tracking/features/user/controller/user_controller.dart';

import '../../features/auth/login/data/data_source/login_service.dart';
import '../../features/home/data/service/product_service.dart';
import '../../features/home/presentation/controller/product_search_controller.dart';
import '../services/payment/payment_service.dart';

Future<void> configureDependencies() async {
  await Future.wait([_configureServices(), _configureControllers()]);
}

Future<void> _configureServices() async {
  DioService.init(baseUrl: ApiConstants.baseUrl);
  SecureStorageService.init();
  PaymentService.init();
  await AppCacheService.init();
  await Get.putAsync<AppThemeController>(() async {
    final controller = AppThemeController();
    await controller.getCurrentTheme();
    return controller;
  });
}

Future<void> _configureControllers() async {
  Get.lazyPut(
    () => UserController(authRepo: AuthRepo(AuthService())),
    fenix: true,
  );
  Get.lazyPut(
    () => LoginController(authRepo: AuthRepo(AuthService())),
    fenix: true,
  );
  Get.lazyPut(
    () => HomeNavbarController(),
    fenix: true,
  );
  Get.lazyPut(
    () => HomePageController(
        productRepo: ProductRepo(
          productService: ProductService(),
        ),
        myCartRepo: MyCartRepo(
          myCartService: MyCartService(),
        )),
    fenix: true,
  );
  Get.lazyPut(
    () => SearchProductsController(
      productRepo: ProductRepo(
        productService: ProductService(),
      ),
    ),
    fenix: true,
  );
  Get.lazyPut(
    () => MyCartsController(
      MyCartRepo(
        myCartService: MyCartService(),
      ),
    ),
    fenix: true,
  );
}
