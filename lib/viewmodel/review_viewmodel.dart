import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/review.dart';

part 'review_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewViewmodel {
  int? rating;
  int? count;
  List<Review>? reviews;
  List<KeyReview>? keyPoint;

  ReviewViewmodel({this.rating, this.count, this.reviews, this.keyPoint});

  factory ReviewViewmodel.fromJson(Map<String, dynamic> json) =>
      _$ReviewViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewViewmodelToJson(this);
}
