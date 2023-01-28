// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      couponType: json['couponType'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      maxAmount: json['maxAmount'] as int?,
      totalUsed: json['totalUsed'] as int?,
      discountAmount: json['discountAmount'] as int?,
      businessName: json['businessName'] as String?,
      serviceName: json['serviceName'] as String?,
      business: json['business'] as String?,
      couponCodes: (json['couponCodes'] as List<dynamic>?)
          ?.map((e) => CouponCode.fromJson(e as Map<String, dynamic>))
          .toList(),
      service: json['service'] as List<String>?,
      isActive: json['isActive'] as bool?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      creator: json['creator'] as String?,
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'couponType': instance.couponType,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'maxAmount': instance.maxAmount,
      'totalUsed': instance.totalUsed,
      'discountAmount': instance.discountAmount,
      'businessName': instance.businessName,
      'serviceName': instance.serviceName,
      'business': instance.business,
      'service': instance.service,
      'couponCodes': instance.couponCodes?.map((e) => e.toJson()).toList(),
      'isActive': instance.isActive,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'creator': instance.creator,
    };

CouponCode _$CouponCodeFromJson(Map<String, dynamic> json) => CouponCode(
      id: json['_id'] as String?,
      value: json['value'] as String?,
      used: json['used'] as bool?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$CouponCodeToJson(CouponCode instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'value': instance.value,
      'used': instance.used,
      'user': instance.user,
    };
