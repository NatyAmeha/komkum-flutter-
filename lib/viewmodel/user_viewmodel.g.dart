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
    );

Map<String, dynamic> _$UserViewmodelToJson(UserViewmodel instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };
