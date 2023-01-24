// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewViewmodel _$ReviewViewmodelFromJson(Map<String, dynamic> json) =>
    ReviewViewmodel(
      rating: json['rating'] as int?,
      count: json['count'] as int?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyPoint: (json['keyPoint'] as List<dynamic>?)
          ?.map((e) => KeyReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewViewmodelToJson(ReviewViewmodel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'count': instance.count,
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
      'keyPoint': instance.keyPoint?.map((e) => e.toJson()).toList(),
    };
