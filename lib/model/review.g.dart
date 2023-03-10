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
      user: json['user'] as String?,
      username: json['username'] as String?,
      profileImage: json['profileImage'] as String?,
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
      'user': instance.user,
      'username': instance.username,
      'profileImage': instance.profileImage,
      'keyPoints': instance.keyPoints?.map((e) => e.toJson()).toList(),
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };

KeyReview _$KeyReviewFromJson(Map<String, dynamic> json) => KeyReview(
      key: json['key'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$KeyReviewToJson(KeyReview instance) => <String, dynamic>{
      'key': instance.key,
      'rating': instance.rating,
      'count': instance.count,
    };
