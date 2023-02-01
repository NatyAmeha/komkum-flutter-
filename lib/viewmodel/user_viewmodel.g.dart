// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserViewmodel _$UserViewmodelFromJson(Map<String, dynamic> json) =>
    UserViewmodel(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      favoriteBusinesses: (json['favoriteBusinesses'] as List<dynamic>?)
          ?.map((e) => BusienssViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoriteProducts: (json['favoriteProducts'] as List<dynamic>?)
          ?.map((e) => ProductViewmodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..orders = (json['orders'] as List<dynamic>?)
        ?.map((e) => OrderViewmodel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$UserViewmodelToJson(UserViewmodel instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'favoriteBusinesses':
          instance.favoriteBusinesses?.map((e) => e.toJson()).toList(),
      'favoriteProducts':
          instance.favoriteProducts?.map((e) => e.toJson()).toList(),
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
    };
