import 'package:json_annotation/json_annotation.dart';
part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  String? id;
  String? title;
  String? description;
  String? order;
  DateTime? dateCreated;
  bool? seen;
  String? recepient;
  String? business;
  String? businessName;
  String? service;
  String? serviceName;

  Notification({
    this.id,
    this.title,
    this.description,
    this.order,
    this.dateCreated,
    this.seen,
    this.recepient,
    this.business,
    this.businessName,
    this.service,
    this.serviceName,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
