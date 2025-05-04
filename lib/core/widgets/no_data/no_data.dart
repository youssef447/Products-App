import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:product_tracking/core/widgets/animations/scale_animation.dart';
import 'package:product_tracking/core/widgets/spacing/vertical_space.dart';

import '../../assets/app_assets.dart';
import '../../theme/data/app_text_style.dart';

/// Objectives: This file is responsible for providing the default no data gif.
class NoData extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final String? text;
  const NoData({
    super.key,
    this.height,
    this.width,
    this.image,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ScaleAnimation(
            child: SvgPicture.asset(
              height: Get.height * 0.3,
              width: Get.width * 0.3,
              image ?? AppAssets.noMeal,
            ),
          ),
        ),
        const VerticalSpace(20),
        Text(
          text ?? 'No Products Found'.tr,
          style: AppTextStyles.font18BoldText(context),
        ),
      ],
    );
  }
}
