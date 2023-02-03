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

OrderItemViewmodel _$OrderItemViewmodelFromJson(Map<String, dynamic> json) =>
    OrderItemViewmodel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      business: json['business'] == null
          ? null
          : Business.fromJson(json['business'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      price: json['price'] as int?,
      qty: json['qty'] as int? ?? 1,
      coupon: json['coupon'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$OrderItemViewmodelToJson(OrderItemViewmodel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'product': instance.product?.toJson(),
      'business': instance.business?.toJson(),
      'price': instance.price,
      'qty': instance.qty,
      'coupon': instance.coupon,
      'service': instance.service?.toJson(),
      'image': instance.image,
    };
