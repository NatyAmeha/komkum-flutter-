// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: json['price'] as int?,
      priceRange: json['priceRange'] == null
          ? null
          : PriceRange.fromJson(json['priceRange'] as Map<String, dynamic>),
      business: json['business'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String?,
      user: json['user'] as String?,
      status: json['status'] as String?,
      expireDate: json['expireDate'] == null
          ? null
          : DateTime.parse(json['expireDate'] as String),
      moreInfo: (json['moreInfo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      type: json['type'] as String?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'priceRange': instance.priceRange?.toJson(),
      'business': instance.business,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'code': instance.code,
      'user': instance.user,
      'status': instance.status,
      'expireDate': instance.expireDate?.toIso8601String(),
      'moreInfo': instance.moreInfo,
      'type': instance.type,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'address': instance.address?.toJson(),
      'contact': instance.contact?.toJson(),
    };

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) => PriceRange(
      min: json['min'] as int?,
      max: json['max'] as int?,
    );

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['_id'] as String?,
      serviceItem: json['serviceItem'] as String?,
      productInfo: json['productInfo'] as String?,
      productName: json['productName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      qty: json['qty'] as int?,
      coupon: json['coupon'] as String?,
      business: json['business'] as String?,
      service: json['service'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      '_id': instance.id,
      'serviceItem': instance.serviceItem,
      'productInfo': instance.productInfo,
      'price': instance.price,
      'productName': instance.productName,
      'qty': instance.qty,
      'coupon': instance.coupon,
      'business': instance.business,
      'service': instance.service,
      'image': instance.image,
    };

OrderItemWithProductInfo _$OrderItemWithProductInfoFromJson(
        Map<String, dynamic> json) =>
    OrderItemWithProductInfo(
      id: json['_id'] as String?,
      serviceItem: json['serviceItem'] == null
          ? null
          : Product.fromJson(json['serviceItem'] as Map<String, dynamic>),
      productInfo: json['productInfo'] as String?,
      productName: json['productName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      qty: json['qty'] as int?,
      coupon: json['coupon'] as String?,
      business: json['business'] as String?,
      service: json['service'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$OrderItemWithProductInfoToJson(
        OrderItemWithProductInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'serviceItem': instance.serviceItem?.toJson(),
      'productInfo': instance.productInfo,
      'price': instance.price,
      'productName': instance.productName,
      'qty': instance.qty,
      'coupon': instance.coupon,
      'business': instance.business,
      'service': instance.service,
      'image': instance.image,
    };
