// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseViewmodel _$BrowseViewmodelFromJson(Map<String, dynamic> json) =>
    BrowseViewmodel(
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CouponViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredServices: (json['featuredServices'] as List<dynamic>?)
          ?.map((e) => ServiceViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredBusinesses: (json['featuredBusinesses'] as List<dynamic>?)
          ?.map((e) => BusienssViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrowseViewmodelToJson(BrowseViewmodel instance) =>
    <String, dynamic>{
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'featuredServices':
          instance.featuredServices?.map((e) => e.toJson()).toList(),
      'featuredBusinesses':
          instance.featuredBusinesses?.map((e) => e.toJson()).toList(),
    };
