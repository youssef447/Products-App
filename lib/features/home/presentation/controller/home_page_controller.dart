import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_tracking/core/widgets/dialog/app_default_dialog.dart';
import 'package:meal_tracking/core/widgets/loading/loading_dialog.dart';
import 'package:meal_tracking/features/my_cart/data/repo/my_cart_repo.dart';
import 'package:meal_tracking/features/user/controller/user_controller.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:meal_tracking/core/services/local/app_cache_service.dart';
import 'package:meal_tracking/features/home/data/model/product_model.dart';

import '../../../../core/helpers/app_context.dart';
import '../../data/repo/product_remote_repo.dart';

class HomePageController extends GetxController {
  final ProductRepo productRepo;
  final MyCartRepo myCartRepo;

  HomePageController({
    required this.productRepo,
    required this.myCartRepo,
  });
  ScrollController scrollController = ScrollController();
  int skip = 0;
  int limit = 5;
  bool loadingPagination = false;
  bool hasMore = true;

  @override
  void onInit() async {
    super.onInit();
    await Future.wait(
      [
        getProducts(),
        getCategories(),
      ],
    );
    update();

    handleShowcase();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMore) {
          loadingPagination = true;
          update();
          skip += limit;
          getProducts(
            selectedCategoryIndex == 0
                ? null
                : categoriesList[selectedCategoryIndex].toString(),
          );
        }
      }
    });
  }

  addToCart(int productId) async {
    showLoadingIndicator();
    int quantity = 1;
    final userId = Get.find<UserController>().user!.id;
    final res = await myCartRepo.addToCart(userId: userId, products: [
      {
        'id': userId,
        'quantity': quantity,
      }
    ]);
    hideLoadingIndicator();
    res.fold((ifLeft) => Get.snackbar('Error', ifLeft.message), (right) {
      AppResultDialog.success(msg: 'Product added to cart');
    });
  }

  List<ProductModel> allProducts = [];
  bool loading = true;
  bool loadingCategoryProducts = false;

  Future getProducts([String? category]) async {
    final result = await productRepo.getProducts(
        category: category, skip: skip, limit: limit);
    loading = false;
    loadingCategoryProducts = false;
    loadingPagination = false;
    update();

    result.fold((fail) {
      Get.snackbar('Error', fail.message);
    }, (r) async {
      if (r.isEmpty) {
        hasMore = false;
      } else {
        allProducts.addAll(r);
      }
    });
  }

  List<dynamic> categoriesList = ['All'];

  Future getCategories() async {
    final result = await productRepo.getCategories();
    result.fold((fail) {
      Get.snackbar('Error', fail.message);
    }, (r) {
      categoriesList.addAll(r);
    });
  }

  int selectedCategoryIndex = 0;
  selectCategroy(int v) {
    if (v != selectedCategoryIndex) {
      selectedCategoryIndex = v;
      hasMore = true;
      loadingCategoryProducts = true;
      allProducts = [];
      skip = 0;
      update();
      getProducts(v == 0 ? null : categoriesList[v].toString());
    }
  }

  //-------- Navbar --------//
  int currentNavIndex = 0;
  selectNavIndex(int index) {
    currentNavIndex = index;
    update();
  }
  //-------- Showcase --------//

  final GlobalKey<State> showcaseTheme = GlobalKey<State>();
  final GlobalKey<State> showcaseAdd = GlobalKey<State>();
  handleShowcase() {
    if (AppCacheService.getData(key: 'launched') == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ShowCaseWidget.of(AppContext.getContext!).startShowCase([
            showcaseTheme,
            showcaseAdd,
          ]);
          AppCacheService.saveData(key: 'launched', value: true);
        },
      );
    }
  }
}
