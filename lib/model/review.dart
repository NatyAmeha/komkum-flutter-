import 'package:json_annotation/json_annotation.dart';
part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  @JsonKey(name: "_id")
  String? id;
  String? description;
  String? serviceName;
  String? businessName;
  String? service;
  String? business;
  List<KeyReview>? keyPoints;
  DateTime? dateCreated;

  Review({
    this.id,
    this.description,
    this.serviceName,
    this.business,
    this.businessName,
    this.service,
    this.dateCreated,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable(explicitToJson: true)
class KeyReview {
  String? key;
  String? rating;
  KeyReview({this.key, this.rating});

  factory KeyReview.fromJson(Map<String, dynamic> json) =>
      _$KeyReviewFromJson(json);
  Map<String, dynamic> toJson() => _$KeyReviewToJson(this);
}
