// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['_id'] as String?,
      description: json['description'] as String?,
      serviceName: json['serviceName'] as String?,
      business: json['business'] as String?,
      businessName: json['businessName'] as String?,
      service: json['service'] as String?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      keyPoints: (json['keyPoints'] as List<dynamic>?)
          ?.map((e) => KeyReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      '_id': instance.id,
      'description': instance.description,
      'serviceName': instance.serviceName,
      'businessName': instance.businessName,
      'service': instance.service,
      'business': instance.business,
      'user': instance.user?.toJson(),
      'keyPoints': instance.keyPoints?.map((e) => e.toJson()).toList(),
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };

KeyReview _$KeyReviewFromJson(Map<String, dynamic> json) => KeyReview(
      key: json['key'] as String?,
      rating: json['rating'] as int?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$KeyReviewToJson(KeyReview instance) => <String, dynamic>{
      'key': instance.key,
      'rating': instance.rating,
      'count': instance.count,
    };
