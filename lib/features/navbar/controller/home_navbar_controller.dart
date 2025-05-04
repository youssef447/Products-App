import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_tracking/features/home/presentation/ui/pages/home_page.dart';
import 'package:product_tracking/features/home/presentation/ui/pages/search_page.dart';
import 'package:product_tracking/features/my_cart/presentation/ui/pages/my_cart_page.dart';

class HomeNavbarController extends GetxController {
  int currentNavIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const SearchProductsPage(),
    const MyCartPage(),
  ];
  setCurrentNavIndex(int index) {
    currentNavIndex = index;
    update();
  }
}
