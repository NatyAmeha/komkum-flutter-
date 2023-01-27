// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusienssViewmodel _$BusienssViewmodelFromJson(Map<String, dynamic> json) =>
    BusienssViewmodel(
      businessInfo: json['businessInfo'] == null
          ? null
          : Business.fromJson(json['businessInfo'] as Map<String, dynamic>),
      reviewInfo: json['reviewInfo'] == null
          ? null
          : ReviewViewmodel.fromJson(
              json['reviewInfo'] as Map<String, dynamic>),
      relatedBusinesses: (json['relatedBusinesses'] as List<dynamic>?)
          ?.map((e) => BusienssViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isInUserFavorite: json['isInUserFavorite'] as bool?,
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CouponViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      trendingProducts: (json['trendingProducts'] as List<dynamic>?)
          ?.map((e) => ProductViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusienssViewmodelToJson(BusienssViewmodel instance) =>
    <String, dynamic>{
      'businessInfo': instance.businessInfo?.toJson(),
      'reviewInfo': instance.reviewInfo?.toJson(),
      'relatedBusinesses':
          instance.relatedBusinesses?.map((e) => e.toJson()).toList(),
      'isInUserFavorite': instance.isInUserFavorite,
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
      'services': instance.services?.map((e) => e.toJson()).toList(),
      'trendingProducts':
          instance.trendingProducts?.map((e) => e.toJson()).toList(),
    };
