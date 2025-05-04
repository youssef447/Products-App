import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_tracking/features/home/data/repo/product_remote_repo.dart';

import '../../data/model/product_model.dart';

class SearchProductsController extends GetxController {
  final ProductRepo productRepo;

  SearchProductsController({
    required this.productRepo,
  });
  List<ProductModel> products = [];
  final TextEditingController searchController = TextEditingController();

  bool loading = false;
  ScrollController scrollController = ScrollController();
  int skip = 0;
  int limit = 5;
  bool loadingPagination = false;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMore) {
          loadingPagination = true;
          update(['home']);
          skip += limit;
          searchProducts(
            searchController.text.trim(),
            true,
          );
        }
      }
    });
  }

  searchProducts(String value, [bool fromScroll = false]) async {
    if (value.isEmpty) {
      skip = 0;
      products = [];

      update(['home']);
    }
    if (value.isNotEmpty) {
      if (!fromScroll) {
        loading = true;
        skip = 0;
        hasMore = true;
        products = [];

        update(['home']);
      }

      final result =
          await productRepo.searchProducts(value, skip: skip, limit: limit);
      loading = false;
      loadingPagination = false;
      result.fold((l) {
        Get.snackbar('Error', l.message);
      }, (r) {
        if (r.isEmpty) {
          hasMore = false;
        } else {
          products.addAll(r);
        }
      });

      update(['home']);
    }
  }

  //----------Category-------------
  String selectedCategory = '';
  toggleCategoryFilter(String category) {
    selectedCategory = category;
    update(['home']);
  }
}
