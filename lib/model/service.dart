import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/address.dart';
import 'package:komkum/model/contact.dart';
import 'package:komkum/utils/constants.dart';

part 'service.g.dart';

@JsonSerializable(explicitToJson: true)
class Service {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? description;
  String? business;
  String? businessName;
  List<String>? images;
  List<String>? tags;
  int? viewCount;
  bool? active;
  String? creator;
  List<String>? serviceItems;
  String type;
  String? callToAction;
  List<String>? coupons;
  DateTime? dateCreated;
  List<String>? reviews;
  List<String>? reviewPoints;
  List<Address>? addresses;
  Contact? contact;

  @JsonSerializable(explicitToJson: true)
  Service(
      {this.id,
      this.name,
      this.description,
      this.business,
      this.images,
      this.tags,
      this.viewCount,
      this.callToAction,
      this.type = "BOOKING",
      this.active,
      this.creator,
      this.serviceItems,
      this.coupons,
      this.dateCreated,
      this.reviews,
      this.reviewPoints,
      this.addresses,
      this.contact});

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
