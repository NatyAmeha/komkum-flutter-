// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      likeCount: json['likeCount'] as int?,
      verified: json['verified'] as bool?,
      featured: json['featured'] as bool?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      servicesName: (json['servicesName'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ["service name 1", "servce name 2"],
      coupons:
          (json['coupons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      creator: json['creator'] as String?,
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'likeCount': instance.likeCount,
      'verified': instance.verified,
      'featured': instance.featured,
      'services': instance.services,
      'servicesName': instance.servicesName,
      'coupons': instance.coupons,
      'images': instance.images,
      'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
      'contact': instance.contact?.toJson(),
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'creator': instance.creator,
      'reviews': instance.reviews,
    };
