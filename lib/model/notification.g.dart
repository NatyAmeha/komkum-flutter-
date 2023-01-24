// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      order: json['order'] as String?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      seen: json['seen'] as bool?,
      recepient: json['recepient'] as String?,
      business: json['business'] as String?,
      businessName: json['businessName'] as String?,
      service: json['service'] as String?,
      serviceName: json['serviceName'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'seen': instance.seen,
      'recepient': instance.recepient,
      'business': instance.business,
      'businessName': instance.businessName,
      'service': instance.service,
      'serviceName': instance.serviceName,
    };
