import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_tracking/features/navbar/controller/home_navbar_controller.dart';

import '../../../core/theme/data/app_colors.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeNavbarController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentNavIndex,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (value) {
                controller.setCurrentNavIndex(value);
              },
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.home,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.search,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                    size: 24.sp,
                  ),
                ),
              ]),
          body: controller.pages[controller.currentNavIndex],
        );
      },
    );
  }
}
