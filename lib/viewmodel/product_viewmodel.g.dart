// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductViewmodel _$ProductViewmodelFromJson(Map<String, dynamic> json) =>
    ProductViewmodel(
      serviceItem: json['serviceItem'] == null
          ? null
          : Product.fromJson(json['serviceItem'] as Map<String, dynamic>),
      serviceInfo: json['serviceInfo'] == null
          ? null
          : Service.fromJson(json['serviceInfo'] as Map<String, dynamic>),
      businessInfo: json['businessInfo'] == null
          ? null
          : Business.fromJson(json['businessInfo'] as Map<String, dynamic>),
      relatedServiceItems: (json['relatedServiceItems'] as List<dynamic>?)
          ?.map((e) => ProductViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      couponsInfo: (json['couponsInfo'] as List<dynamic>?)
          ?.map((e) => CouponViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductViewmodelToJson(ProductViewmodel instance) =>
    <String, dynamic>{
      'serviceItem': instance.serviceItem?.toJson(),
      'serviceInfo': instance.serviceInfo?.toJson(),
      'businessInfo': instance.businessInfo?.toJson(),
      'relatedServiceItems':
          instance.relatedServiceItems?.map((e) => e.toJson()).toList(),
      'couponsInfo': instance.couponsInfo?.map((e) => e.toJson()).toList(),
    };
