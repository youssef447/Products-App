class ReviewModel {
  String? comment;
  int rating;
  DateTime date;
  String reviewerName;
  ReviewModel({
    this.comment,
    required this.rating,
    required this.date,
    required this.reviewerName,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      comment: map['comment'] != null ? map['comment'] as String : null,
      rating: map['rating'] as int,
      date: DateTime.parse(map['date'] as String),
      reviewerName: map['reviewerName'] as String,
    );
  }
}
