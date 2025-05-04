import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/widgets/form_field/app_form_field.dart';
import '../../../controller/product_search_controller.dart';

class ProductSearchField extends GetView<SearchProductsController> {
  final bool enabled;
  const ProductSearchField({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: AppFormField(
        enabled: enabled,
        controller: !enabled ? null : controller.searchController,
        onChanged: (value) {
          controller.searchProducts(value);
        },
        hintText: 'Search for products...',
        suffixIcon: Icon(
          Icons.search,
          size: 20.sp,
        ),
      ),
    );
  }
}
