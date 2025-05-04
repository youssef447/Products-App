import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_tracking/core/theme/data/app_colors.dart';
import 'package:product_tracking/core/widgets/buttons/app_default_button.dart';
import 'package:product_tracking/core/widgets/spacing/horizontal_space.dart';
import 'package:product_tracking/core/widgets/spacing/vertical_space.dart';
import 'package:product_tracking/features/my_cart/presentation/controller/my_cart_controller.dart';

import '../../../../../core/assets/app_assets.dart';
import '../../../../../core/theme/data/app_text_style.dart';
import '../../../../../core/widgets/dialog/app_default_dialog.dart';
import '../../../../../core/widgets/loading/app_circle_progress.dart';
import '../../../../../core/widgets/no_data/no_data.dart';
import '../../../model/cart_product_model.dart';
part '../widgets/cart_product_card.dart';
part '../widgets/edit_product_bottom_sheet.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppTextStyles.font18BoldText(context),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<MyCartsController>(builder: (controller) {
          if (controller.loading) {
            return const AppCircleProgress();
          }
          if (controller.myCart == null ||
              controller.myCart!.products.isEmpty) {
            return const NoData(
              text: 'Cart is empty',
              image: AppAssets.cart,
            );
          }
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final products = controller.myCart!.products[index];
                      return CartProductCard(
                        product: products,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const VerticalSpace(8),
                    itemCount: controller.myCart!.products.length,
                  ),
                  const VerticalSpace(8),
                  Row(
                    children: [
                      Text(
                        'Total Price: ',
                        style: AppTextStyles.font14BoldText(context),
                      ),
                      const HorizontalSpace(8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$',
                              children: [
                                TextSpan(
                                  text: controller.myCart!.total
                                      .toStringAsFixed(2),
                                  style: AppTextStyles.font18BoldText(context)
                                      .copyWith(),
                                ),
                              ],
                            ),
                          ],
                          style: AppTextStyles.font14BoldText(context).copyWith(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpace(16),
                  AppDefaultButton(
                      text: 'Checkout',
                      onPressed: () {
                        AppResultDialog.success(
                          msg: 'Transaction made successfully',
                        );
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
