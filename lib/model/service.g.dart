// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      business: json['business'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      viewCount: json['viewCount'] as int?,
      callToAction: json['callToAction'] as String?,
      active: json['active'] as bool?,
      creator: json['creator'] as String?,
      serviceItems: (json['serviceItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      coupons:
          (json['coupons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
      reviewPoints: (json['reviewPoints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    )..businessName = json['businessName'] as String?;

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'business': instance.business,
      'businessName': instance.businessName,
      'images': instance.images,
      'tags': instance.tags,
      'viewCount': instance.viewCount,
      'active': instance.active,
      'creator': instance.creator,
      'serviceItems': instance.serviceItems,
      'callToAction': instance.callToAction,
      'coupons': instance.coupons,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'reviews': instance.reviews,
      'reviewPoints': instance.reviewPoints,
      'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
      'contact': instance.contact?.toJson(),
    };
