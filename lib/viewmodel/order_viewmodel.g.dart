// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderViewmodel _$OrderViewmodelFromJson(Map<String, dynamic> json) =>
    OrderViewmodel(
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
      userReviewInfo: json['userReviewInfo'] == null
          ? null
          : ReviewViewmodel.fromJson(
              json['userReviewInfo'] as Map<String, dynamic>),
      business: json['business'] == null
          ? null
          : Business.fromJson(json['business'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              OrderItemWithProductInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderViewmodelToJson(OrderViewmodel instance) =>
    <String, dynamic>{
      'order': instance.order?.toJson(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'business': instance.business?.toJson(),
      'userReviewInfo': instance.userReviewInfo?.toJson(),
    };
