import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_tracking/core/routes/app_routes.dart';
import 'package:meal_tracking/core/routes/route_generator.dart';
import 'package:meal_tracking/features/auth/login/data/data_source/token_service.dart';
import 'package:meal_tracking/features/user/controller/user_controller.dart';
import 'package:showcaseview/showcaseview.dart';

import 'core/di/di.dart';
import 'core/helpers/app_context.dart';
import 'core/theme/controller/app_theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await configureDependencies();
  String initalScreen = AppRoutes.login;
  final loggedIn = await getCurrentUser();
  if (loggedIn) {
    initalScreen = AppRoutes.homeNavbar;
  }
  runApp(MyApp(initalScreen: initalScreen));
}

Future<bool> getCurrentUser() async {
  if (await TokenService.getAccessToken() == null) return false;
  await Get.find<UserController>().getCurrentUser();
  if (Get.find<UserController>().user == null) {
    return false;
  }
  return true;
}

class MyApp extends StatelessWidget {
  final String initalScreen;
  const MyApp({super.key, required this.initalScreen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) {
          return ShowCaseWidget(builder: (context) {
            return GetBuilder<AppThemeController>(builder: (controller) {
              return GetMaterialApp(
                title: 'Meal Tracker',
                debugShowCheckedModeBanner: false,
                theme: controller.currentTheme,
                navigatorKey: AppContext.appNavKey,
                initialRoute: initalScreen,
                onGenerateRoute: RouteGenerator.generateRoute,
              );
            });
          });
        });
  }
}
