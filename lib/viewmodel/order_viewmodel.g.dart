// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderViewmodel _$OrderViewmodelFromJson(Map<String, dynamic> json) =>
    OrderViewmodel(
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderViewmodelToJson(OrderViewmodel instance) =>
    <String, dynamic>{
      'order': instance.order?.toJson(),
    };
