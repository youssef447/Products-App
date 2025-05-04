import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:meal_tracking/core/theme/data/app_text_style.dart';
import 'package:meal_tracking/core/widgets/animations/horizontal_animation.dart';
import 'package:meal_tracking/core/widgets/spacing/horizontal_space.dart';
import 'package:meal_tracking/core/widgets/spacing/vertical_space.dart';
import 'package:meal_tracking/features/home/data/model/product_model.dart';
import 'package:meal_tracking/features/home/presentation/controller/home_page_controller.dart';

import '../../../core/theme/data/app_colors.dart';
import '../../../core/widgets/buttons/app_default_button.dart';
part '../widgets/product_summary_card.dart';
part '../widgets/product_reviews.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel model;
  const ProductDetailsPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        model.discountPercentage != 0 && model.discountPercentage != null;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Product Details',
        style: AppTextStyles.font18BoldText(context),
      )),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductSummaryCard(
                  model: model,
                  pageController: PageController(initialPage: 0),
                ),
                const VerticalSpace(16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (hasDiscount)
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$',
                                children: [
                                  TextSpan(
                                    text:
                                        model.discountPrice.toStringAsFixed(2),
                                    style: AppTextStyles.font18BoldText(context)
                                        .copyWith(),
                                  ),
                                ],
                              ),
                            ],
                            style:
                                AppTextStyles.font18BoldText(context).copyWith(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$',
                            children: [
                              TextSpan(
                                text: model.price.toStringAsFixed(2),
                                style: AppTextStyles.font16BoldText(context)
                                    .copyWith(
                                  color: hasDiscount ? Colors.grey : null,
                                  fontSize: hasDiscount ? 10.sp : null,
                                  decorationColor: Colors.red,
                                  decoration: hasDiscount
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ],
                        style: AppTextStyles.font16BoldText(context).copyWith(
                          fontSize: hasDiscount ? 10.sp : null,
                          color: Colors.orange,
                          decoration: hasDiscount
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(6),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    model.stock == 0 ? 'Out Of Stock' : 'In Stock',
                    style: AppTextStyles.font10BoldText(context).copyWith(
                      color: model.stock == 0 ? Colors.red : Colors.green,
                    ),
                  ),
                ),
                const VerticalSpace(6),
                StarRating(
                  mainAxisAlignment: MainAxisAlignment.start,
                  size: 14.sp,
                  color: AppColors.primary,
                  rating: model.rating ?? 0,
                  allowHalfRating: true,
                  filledIcon: Icons.star_rounded,
                  halfFilledIcon: Icons.star_half_rounded,
                ),
                const VerticalSpace(16),
                Text(
                  'Description',
                  style: AppTextStyles.font16BoldText(context)
                      .copyWith(color: Colors.red),
                ),
                const VerticalSpace(8),
                Text(
                  model.description,
                  style: AppTextStyles.font12RegularText(context),
                ),
                const VerticalSpace(16),
                ProductReviews(productModel: model),
                const VerticalSpace(16),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: AppDefaultButton(
                    height: 30.h,
                    width: 150.w,
                    text: 'Add To Cart',
                    onPressed: () {
                      Get.find<HomePageController>().addToCart(model.id);
                    },
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
