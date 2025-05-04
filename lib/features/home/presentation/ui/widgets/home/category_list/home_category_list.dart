part of '../../../pages/home_page.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (controller) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            controller.categoriesList.length,
            (index) {
              final isLast = index == controller.categoriesList.length - 1;
              final isSelected = index == controller.selectedCategoryIndex;
              return GestureDetector(
                onTap: () {
                  controller.selectCategroy(index);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 12.0.w),
                  child: Text(
                    controller.categoriesList[index].toString(),
                    style: AppTextStyles.font14RegularText(context).copyWith(
                      color: isSelected ? AppColors.primary : Colors.grey[600],
                      decorationThickness: 2,
                      decoration: isSelected
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
