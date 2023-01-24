// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceViewmodel _$ServiceViewmodelFromJson(Map<String, dynamic> json) =>
    ServiceViewmodel(
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      serviceItems: (json['serviceItems'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewInfo: json['reviewInfo'] == null
          ? null
          : ReviewViewmodel.fromJson(
              json['reviewInfo'] as Map<String, dynamic>),
      relatedServices: (json['relatedServices'] as List<dynamic>?)
          ?.map((e) => ServiceViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CouponViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceViewmodelToJson(ServiceViewmodel instance) =>
    <String, dynamic>{
      'service': instance.service?.toJson(),
      'serviceItems': instance.serviceItems?.map((e) => e.toJson()).toList(),
      'reviewInfo': instance.reviewInfo?.toJson(),
      'relatedServices':
          instance.relatedServices?.map((e) => e.toJson()).toList(),
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
    };
