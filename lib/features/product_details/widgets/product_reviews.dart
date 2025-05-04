part of '../pages/product_details_page.dart';

class ProductReviews extends StatelessWidget {
  final ProductModel productModel;
  const ProductReviews({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: AppTextStyles.font16BoldText(context),
        ),
        const VerticalSpace(8),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
            itemCount: productModel.reviews.length,
            itemBuilder: (context, index) {
              final review = productModel.reviews[index];
              return Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          review.reviewerName,
                          style: AppTextStyles.font16BoldText(context),
                        ),
                        const HorizontalSpace(16),
                        StarRating(
                          size: 14.sp,
                          color: AppColors.primary,
                          rating: review.rating.toDouble(),
                          allowHalfRating: true,
                          filledIcon: Icons.star_rounded,
                          halfFilledIcon: Icons.star_half_rounded,
                        ),
                      ],
                    ),
                    const VerticalSpace(4),
                    Text(
                      review.comment ?? '',
                      style: AppTextStyles.font12RegularText(context),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }
}
