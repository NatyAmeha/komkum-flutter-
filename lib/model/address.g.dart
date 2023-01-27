// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['_id'] as String?,
      location: json['location'] == null
          ? null
          : GeoSpacial.fromJson(json['location'] as Map<String, dynamic>),
      localAddress: json['localAddress'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      '_id': instance.id,
      'location': instance.location?.toJson(),
      'localAddress': instance.localAddress,
    };

GeoSpacial _$GeoSpacialFromJson(Map<String, dynamic> json) => GeoSpacial(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => e as double)
          .toList(),
    );

Map<String, dynamic> _$GeoSpacialToJson(GeoSpacial instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
