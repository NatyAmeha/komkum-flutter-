import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/address.dart';
import 'package:komkum/model/contact.dart';
part 'business.g.dart';

@JsonSerializable(explicitToJson: true)
class Business {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? description;
  String? category;
  int? likeCount;
  bool? verified;
  bool? featured;

  List<String>? services;
  List<String>? servicesName;
  List<String>? coupons;
  List<String>? images;
  List<Address>? addresses;
  Contact? contact;
  DateTime? dateCreated;
  String? creator;
  List<String>? reviews;

  Business({
    this.id,
    this.name,
    this.description,
    this.category,
    this.likeCount,
    this.verified,
    this.featured,
    this.services,
    this.servicesName = const ["service name 1", "servce name 2"],
    this.coupons,
    this.images,
    this.addresses,
    this.contact,
    this.dateCreated,
    this.creator,
    this.reviews,
  });

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
