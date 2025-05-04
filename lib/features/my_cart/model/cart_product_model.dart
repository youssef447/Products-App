class CartProductModel {
  final int id;
  final String title;
  final String thumbnail;
  final double total;
  final double? discountTotal;

  final int quantity;
  CartProductModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.total,
    this.discountTotal,
    required this.quantity,
  });

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      thumbnail: map['thumbnail'] as String,
      total: map['total'] as double,
      discountTotal: map['discountedTotal'] != null
          ? map['discountedTotal'] as double
          : null,
      quantity: map['quantity'] as int,
    );
  }
}
