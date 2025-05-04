import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:product_tracking/core/extensions/context_extension.dart';
import 'package:product_tracking/core/helpers/app_context.dart';
import 'package:product_tracking/core/theme/controller/app_theme_controller.dart';
import 'package:product_tracking/core/widgets/buttons/app_default_button.dart';
import 'package:product_tracking/core/widgets/loading/app_circle_progress.dart';
import 'package:product_tracking/core/widgets/no_data/no_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_tracking/core/widgets/spacing/horizontal_space.dart';
import 'package:product_tracking/core/widgets/spacing/vertical_space.dart';
import 'package:product_tracking/features/home/presentation/controller/home_page_controller.dart';
import 'package:product_tracking/features/home/presentation/ui/widgets/common/loading_products.dart';
import 'package:product_tracking/features/navbar/controller/home_navbar_controller.dart';
import 'package:product_tracking/features/user/controller/user_controller.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/theme/data/app_colors.dart';
import '../../../../../core/theme/data/app_text_style.dart';
import '../../../../../core/widgets/buttons/default_switch_button.dart';
import '../../../data/model/product_model.dart';
import '../widgets/common/product_search_field.dart';

part '../widgets/home/appbar/home_appbar.dart';
part '../widgets/home/showcase/home_showcase.dart';
part '../widgets/home/cards/product_card.dart';
part '../widgets/home/category_list/home_category_list.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().user!;
    return Scaffold(
      appBar: const HomeAppbar(),
      body: SafeArea(
        child: GetBuilder<HomePageController>(builder: (controller) {
          if (controller.loading) {
            return const AppCircleProgress();
          }
          if (controller.allProducts.isEmpty &&
              !controller.loadingCategoryProducts) {
            return const NoData();
          }
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60.r,
                          width: 60.r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Container(
                              height: 50.r,
                              width: 50.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.background(context),
                              ),
                              child: user.image == null
                                  ? SvgPicture.asset(user.getGenderProfile)
                                  : CachedNetworkImage(
                                      imageUrl: user.image!,
                                    ),
                            ),
                          ),
                        ),
                        const HorizontalSpace(6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Welcome ',
                                  style:
                                      AppTextStyles.font14RegularText(context)),
                              const VerticalSpace(4),
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: AppTextStyles.font18BoldText(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const VerticalSpace(16),

                    GestureDetector(
                      onTap: () {
                        Get.find<HomeNavbarController>().setCurrentNavIndex(1);
                      },
                      child: const ProductSearchField(enabled: false),
                    ),
                    const VerticalSpace(16),
                    const HomeCategoryList(),
                    const VerticalSpace(16),
                    //  const CalenderFilter(),
                    if (controller.loadingCategoryProducts)
                      const LoadingProducts(),
                    if (!controller.loadingCategoryProducts)
                      MasonryGridView.builder(
                        crossAxisSpacing: 5.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        mainAxisSpacing: 10.h,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          if (index == controller.allProducts.length &&
                              controller.loadingPagination) {
                            return AppCircleProgress(
                              height: 44.h,
                              width: 44.w,
                            );
                          }
                          return ProductCard(
                            model: controller.allProducts[index],
                          );
                        },
                        itemCount: controller.loadingPagination
                            ? controller.allProducts.length + 1
                            : controller.allProducts.length,
                      ),
                  ]),
            ),
          );
        }),
      ),
    );
  }
}
