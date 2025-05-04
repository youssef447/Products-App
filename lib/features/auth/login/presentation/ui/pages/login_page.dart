import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:product_tracking/core/widgets/animations/scale_animation.dart';

import '../../../../../../core/assets/app_assets.dart';
import '../../../../../../core/helpers/validation_helper.dart';
import '../../../../../../core/widgets/buttons/app_default_button.dart';
import '../../../../../../core/widgets/form_field/app_form_field.dart';
import '../../../../../../core/widgets/spacing/vertical_space.dart';
import '../../controller/login_controller.dart';
part '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleAnimation(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.r),
                            topRight: Radius.circular(60.r)),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(60.r),
                                  topRight: Radius.circular(60.r)),
                            ),
                            width: Get.width * 0.88,
                            height: Get.height * 0.43,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.r),
                            topRight: Radius.circular(60.r)),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(60.r),
                                  topRight: Radius.circular(60.r)),
                            ),
                            width: Get.width * 0.83,
                            height: Get.height * 0.38,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.08),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60.r),
                              topRight: Radius.circular(60.r)),
                        ),
                        padding: EdgeInsets.all(8.w),
                        width: Get.width * 0.77,
                        height: Get.height * 0.33,
                        child: const LoginForm(),
                      ),
                      Positioned(
                        top: -10.h,
                        child: SvgPicture.asset(
                          AppAssets.unlocked,
                          width: 55.w,
                          height: 55.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
