// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      accountType: json['accountType'] as String?,
      favoriteBusinesses: (json['favoriteBusinesses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favoriteService: json['favoriteService'] as String?,
      dateCreate: json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String),
      orders:
          (json['orders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      userBusinesses: (json['userBusinesses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favoriteProducts: (json['favoriteProducts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'password': instance.password,
      'accountType': instance.accountType,
      'favoriteBusinesses': instance.favoriteBusinesses,
      'favoriteService': instance.favoriteService,
      'dateCreate': instance.dateCreate?.toIso8601String(),
      'orders': instance.orders,
      'addresses': instance.addresses?.map((e) => e.toJson()).toList(),
      'userBusinesses': instance.userBusinesses,
      'favoriteProducts': instance.favoriteProducts,
    };
