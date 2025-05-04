import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meal_tracking/core/widgets/loading/app_circle_progress.dart';
import 'package:meal_tracking/features/home/presentation/ui/pages/home_page.dart';
import 'package:meal_tracking/features/home/presentation/ui/widgets/common/product_search_field.dart';
import 'package:meal_tracking/features/home/presentation/ui/widgets/common/loading_products.dart';

import '../../../../../core/theme/data/app_text_style.dart';
import '../../../../../core/widgets/spacing/vertical_space.dart';
import '../../controller/product_search_controller.dart';

class SearchProductsPage extends GetView<SearchProductsController> {
  const SearchProductsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Products',
          style: AppTextStyles.font18BoldText(context),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                const ProductSearchField(enabled: true),
                const VerticalSpace(16),
                GetBuilder<SearchProductsController>(
                  id: 'home',
                  builder: (controller) {
                    if (controller.loading) {
                      return const LoadingProducts();
                    }

                    return MasonryGridView.builder(
                      crossAxisSpacing: 8.w,
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      mainAxisSpacing: 10.h,
                      padding: EdgeInsets.only(bottom: 8.w),
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        if (index == controller.products.length &&
                            controller.loadingPagination) {
                          return AppCircleProgress(
                            width: 50.w,
                            height: 50.w,
                          );
                        }
                        return ProductCard(
                          model: controller.products[index],
                        );
                      },
                      itemCount: controller.loadingPagination
                          ? controller.products.length + 1
                          : controller.products.length,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
