// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchViewmodel _$SearchViewmodelFromJson(Map<String, dynamic> json) =>
    SearchViewmodel(
      businesses: (json['businesses'] as List<dynamic>?)
          ?.map((e) => BusienssViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CouponViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchViewmodelToJson(SearchViewmodel instance) =>
    <String, dynamic>{
      'businesses': instance.businesses?.map((e) => e.toJson()).toList(),
      'services': instance.services?.map((e) => e.toJson()).toList(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
    };
