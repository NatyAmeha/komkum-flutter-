import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/user.dart';
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
  String? user;
  String? username;
  String? profileImage;
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
    this.user,
    this.username,
    this.profileImage,
    this.keyPoints,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable(explicitToJson: true)
class KeyReview {
  String? key;
  double? rating;
  int? count;
  KeyReview({this.key, this.rating, this.count});

  factory KeyReview.fromJson(Map<String, dynamic> json) =>
      _$KeyReviewFromJson(json);
  Map<String, dynamic> toJson() => _$KeyReviewToJson(this);
}
