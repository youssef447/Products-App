import 'review_model.dart';

class ProductModel {
  int id;
  String description;
  String title;
  String? category;
  List<dynamic> tags;
  int stock;
  double? rating;
  double price;
  double? discountPercentage;
  List<ReviewModel> reviews;
  String? brand;
  List<dynamic> images;
  String? thumbnail;
  DateTime createdAt;
  ProductModel({
    required this.id,
    required this.description,
    required this.title,
    required this.stock,
    required this.price,
    required this.createdAt,
    this.discountPercentage,
    this.reviews = const [],
    this.images = const [],
    this.rating,
    this.category,
    this.tags = const [],
    this.thumbnail,
    this.brand,
  });

  double get discountPrice => price - (price * discountPercentage! / 100);
  factory ProductModel.fromMap(Map map) {
    return ProductModel(
      id: map['id'] as int,
      description: map['description'] as String,
      title: map['title'] as String,
      thumbnail: map['thumbnail'] as String?,
      images: map['images'] as List<dynamic>,
      category: map['category'] as String?,
      stock: map['stock'],
      createdAt: DateTime.parse(map['meta']['createdAt'] as String),
      tags: map['tags'] as List<dynamic>,
      brand: map['brand'] as String?,
      rating:
          map['rating'] != null ? double.parse(map['rating'].toString()) : null,
      price: double.parse(map['price'].toString()),
      discountPercentage: map['discountPercentage'] != null
          ? double.parse(map['discountPercentage'].toString())
          : null,
      reviews: map['reviews'] != null
          ? (map['reviews'] as List<dynamic>)
              .map((e) => ReviewModel.fromMap(e))
              .toList()
          : [],
    );
  }
}
