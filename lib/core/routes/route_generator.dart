import 'package:flutter/material.dart';
import 'package:meal_tracking/core/routes/route_navigation_helper.dart';
import 'package:meal_tracking/features/auth/login/presentation/ui/pages/login_page.dart';
import 'package:meal_tracking/features/home/presentation/ui/pages/search_page.dart';
import 'package:meal_tracking/features/navbar/ui/home_navbar.dart';

import '../../features/product_details/pages/product_details_page.dart';
import 'app_routes.dart';

abstract class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>? ?? {};
    final routeName = settings.name;

    // Define your routes with corresponding transitions
    switch (routeName) {
      case AppRoutes.login:
        return RouteNavigationHelper.buildPageRoute(
          const LoginPage(),
          PageTransitionType.fade,
        );
      case AppRoutes.homeNavbar:
        return RouteNavigationHelper.buildPageRoute(
          const HomeNavbar(),
          PageTransitionType.fade,
        );

      case AppRoutes.searchProducts:
        return RouteNavigationHelper.buildPageRoute(
          const SearchProductsPage(),
          PageTransitionType.upFade,
        );
      case AppRoutes.orderDetails:
        return RouteNavigationHelper.buildPageRoute(
          ProductDetailsPage(model: args['model']),
          PageTransitionType.upFade,
        );

      default:
        return RouteNavigationHelper.buildPageRoute(
          Scaffold(
              body: SafeArea(
            child: Center(child: Text('No route defined for $routeName')),
          )),
          PageTransitionType.fade,
        );
    }
  }
}
