// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      moreInfo: (json['moreInfo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      service: json['service'] as String?,
      servieName: json['servieName'] as String?,
      businesName: json['businesName'] as String?,
      business: json['business'] as String?,
      category: json['category'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      fixedPrice: json['fixedPrice'] as int?,
      minPrice: json['minPrice'] as int?,
      maxAmount: json['maxAmount'] as int?,
      maxPrice: json['maxPrice'] as int?,
      likeCount: json['likeCount'] as int?,
      viewCount: json['viewCount'] as int?,
      featured: json['featured'] as bool?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
      callToAction: json['callToAction'] as String?,
      expireDate: json['expireDate'] == null
          ? null
          : DateTime.parse(json['expireDate'] as String),
    )..dateCreated = json['dateCreated'] == null
        ? null
        : DateTime.parse(json['dateCreated'] as String);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'moreInfo': instance.moreInfo,
      'service': instance.service,
      'servieName': instance.servieName,
      'business': instance.business,
      'businesName': instance.businesName,
      'category': instance.category,
      'tags': instance.tags,
      'fixedPrice': instance.fixedPrice,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'maxAmount': instance.maxAmount,
      'likeCount': instance.likeCount,
      'viewCount': instance.viewCount,
      'featured': instance.featured,
      'callToAction': instance.callToAction,
      'expireDate': instance.expireDate?.toIso8601String(),
      'variants': instance.variants?.map((e) => e.toJson()).toList(),
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    ProductVariant(
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      moreInfo: (json['moreInfo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      fixedPrice: json['fixedPrice'] as int?,
      minPrice: json['minPrice'] as int?,
      maxPrice: json['maxPrice'] as int?,
    );

Map<String, dynamic> _$ProductVariantToJson(ProductVariant instance) =>
    <String, dynamic>{
      'images': instance.images,
      'moreInfo': instance.moreInfo,
      'fixedPrice': instance.fixedPrice,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };
