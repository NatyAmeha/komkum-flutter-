// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponViewmodel _$CouponViewmodelFromJson(Map<String, dynamic> json) =>
    CouponViewmodel(
      couponInfo: json['couponInfo'] == null
          ? null
          : Coupon.fromJson(json['couponInfo'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      business: json['business'] == null
          ? null
          : Business.fromJson(json['business'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CouponViewmodelToJson(CouponViewmodel instance) =>
    <String, dynamic>{
      'couponInfo': instance.couponInfo?.toJson(),
      'services': instance.services?.map((e) => e.toJson()).toList(),
      'business': instance.business?.toJson(),
    };
