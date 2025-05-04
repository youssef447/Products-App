part of '../../../pages/home_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel model;
  const ProductCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (controller) {
      final hasDiscount =
          model.discountPercentage != 0 && model.discountPercentage != null;
      return GestureDetector(
        onTap: () {
          context.navigate(
            AppRoutes.orderDetails,
            arguments: {'model': model},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.1),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.thumbnail != null)
                Hero(
                  tag: model.id,
                  child: CachedNetworkImage(
                    imageUrl: model.thumbnail!,
                    width: double.infinity,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.lightGrey,
                            strokeWidth: 2.0,
                            color: AppColors.primary,
                            value: progress.progress,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: AppTextStyles.font12BoldText(context),
                    ),
                    const VerticalSpace(8),
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
                                        text: model.discountPrice
                                            .toStringAsFixed(2),
                                        style: AppTextStyles.font14BoldText(
                                                context)
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                ],
                                style: AppTextStyles.font14BoldText(context)
                                    .copyWith(
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
                            style:
                                AppTextStyles.font16BoldText(context).copyWith(
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
                    const VerticalSpace(6),
                    AppDefaultButton(
                      height: 30.h,
                      text: 'Add To Cart',
                      onPressed: () {
                        controller.addToCart(model.id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
