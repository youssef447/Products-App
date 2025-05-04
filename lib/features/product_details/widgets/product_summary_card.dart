part of '../pages/product_details_page.dart';

class ProductSummaryCard extends StatelessWidget {
  final PageController pageController;

  const ProductSummaryCard({
    super.key,
    required this.model,
    required this.pageController,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: model.id,
          child: SizedBox(
            height: 300.h,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) => CachedNetworkImage(
                imageUrl: model.images[index].toString(),
                fit: BoxFit.cover,
              ),
              itemCount: model.images.length,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ],
        ),
        PositionedDirectional(
          bottom: 0,
          end: 0,
          start: 0,
          child: SlideAnimation(
            leftToRight: true,
            delay: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.w),
                  color: Colors.black.withOpacity(0.12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        model.title,
                        style: AppTextStyles.font16BoldText(context),
                      ),
                      const VerticalSpace(6),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category: ',
                              children: [
                                TextSpan(
                                  text: model.category ?? 'NA',
                                  style: AppTextStyles.font12BoldText(context)
                                      .copyWith(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                          style: AppTextStyles.font12BoldText(context),
                        ),
                      ),
                      const VerticalSpace(6),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Brand: ',
                              children: [
                                TextSpan(
                                  text: model.brand ?? 'NA',
                                  style: AppTextStyles.font12BoldText(context)
                                      .copyWith(color: Colors.green[600]),
                                ),
                              ],
                            ),
                          ],
                          style: AppTextStyles.font12BoldText(context),
                        ),
                      ),
                      const VerticalSpace(6),
                      Wrap(
                        children: List.generate(
                          model.tags.length,
                          (index) {
                            final isLast = index == model.tags.length - 1;
                            return Padding(
                              padding:
                                  EdgeInsets.only(right: isLast ? 0 : 8.0.w),
                              child: Text(
                                '@${model.tags[index]}',
                                style: AppTextStyles.font12RegularText(context)
                                    .copyWith(color: Colors.blue),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
