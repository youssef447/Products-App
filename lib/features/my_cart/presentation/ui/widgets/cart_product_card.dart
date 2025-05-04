part of '../pages/my_cart_page.dart';

class CartProductCard extends GetView<MyCartsController> {
  const CartProductCard({
    super.key,
    required this.product,
  });

  final CartProductModel product;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.discountTotal != null;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: product.thumbnail,
            width: 80.w,
            fit: BoxFit.cover,
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
          const HorizontalSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: AppTextStyles.font14BoldText(context),
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
                                    text: product.discountTotal!
                                        .toStringAsFixed(2),
                                    style: AppTextStyles.font14BoldText(context)
                                        .copyWith(),
                                  ),
                                ],
                              ),
                            ],
                            style:
                                AppTextStyles.font14BoldText(context).copyWith(
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
                                text: product.total.toStringAsFixed(2),
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
                const VerticalSpace(8),
                Text(
                  'Quantity: ${product.quantity}',
                  style: AppTextStyles.font12BoldText(context),
                ),
                const VerticalSpace(8),
                if (controller.myCart!.isDeleted != null &&
                    controller.myCart!.isDeleted!)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      'Removed',
                      style: AppTextStyles.font12BoldText(context).copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                if (controller.myCart!.isDeleted == null ||
                    controller.myCart!.isDeleted == false)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppDefaultButton(
                        text: 'Edit',
                        height: 35.h,
                        width: 75.w,
                        borderColor: Colors.grey,
                        onPressed: () async {
                          final quantity = await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return EditProductBottomSheet(product: product);
                              });
                          if (quantity != product.quantity &&
                              quantity != null) {
                            controller.updateProductQuantity(
                              id: product.id,
                              quantity: quantity,
                            );
                          }
                        },
                        color: Colors.transparent,
                      ),
                      const HorizontalSpace(8),
                      AppDefaultButton(
                        text: 'Remove',
                        height: 35.h,
                        width: 75.w,
                        onPressed: () {
                          controller.deleteCart();
                        },
                        color: Colors.red,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
