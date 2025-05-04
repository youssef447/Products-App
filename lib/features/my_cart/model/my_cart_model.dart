import 'cart_product_model.dart';

class MyCartModel {
  int id;
  List<CartProductModel> products;
  final int totalQuantity;
  final double total;
  final double? discountTotal;
  bool? isDeleted;

  MyCartModel({
    required this.id,
    required this.products,
    required this.totalQuantity,
    required this.total,
    this.isDeleted,
    this.discountTotal,
  });

  /* Map<String, dynamic> toMap(
      {required String userId,
      required String productId,
      required int quantity}) {
    return <String, dynamic>{
      'userId': id,
      'products': [
        {
          'productId': productId,
          'quantity': quantity,
        }
      ],
    };
  } */

  factory MyCartModel.fromMap(Map<String, dynamic> map) {
    return MyCartModel(
      id: map['id'] as int,
      products: (map["products"] as List<dynamic>)
          .map((e) => CartProductModel.fromMap(e))
          .toList(),
      totalQuantity: map["totalQuantity"] as int,
      isDeleted: map["isDeleted"] as bool?,
      total: map['total'] as double,
      discountTotal: map['discountedTotal'] != null
          ? double.parse(map['discountedTotal'].toString())
          : null,
    );
  }
}
