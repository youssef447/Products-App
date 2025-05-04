part of '../pages/my_cart_page.dart';

class EditProductBottomSheet extends StatefulWidget {
  final CartProductModel product;
  const EditProductBottomSheet({super.key, required this.product});

  @override
  State<EditProductBottomSheet> createState() => _EditProductBottomSheetState();
}

class _EditProductBottomSheetState extends State<EditProductBottomSheet> {
  int quantity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = widget.product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 40.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (quantity > 0) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
                child: Icon(
                  Icons.remove_circle,
                  size: 24.sp,
                ),
              ),
              const HorizontalSpace(16),
              Text(
                quantity.toString(),
                style: AppTextStyles.font20BoldABeeZeeText(context),
              ),
              const HorizontalSpace(16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    quantity++;
                  });
                },
                child: Icon(
                  Icons.add_circle,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          const VerticalSpace(30),
          AppDefaultButton(
            text: 'Save',
            height: 35.h,
            onPressed: () {
              Navigator.of(context).pop(quantity);
            },
          ),
        ],
      ),
    );
  }
}
