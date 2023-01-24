// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      phoneNumber: (json['phoneNumber'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      links: (json['links'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'links': instance.links,
    };
