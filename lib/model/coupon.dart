import 'package:json_annotation/json_annotation.dart';
part 'coupon.g.dart';

@JsonSerializable(explicitToJson: true)
class Coupon {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? description;
  List<String>? images;
  String? couponType;
  DateTime? startDate;
  DateTime? endDate;
  int? maxAmount;
  int? totalUsed;
  int? discountAmount;
  String? businessName;
  String? serviceName;
  String? business;
  String? service;
  List<CouponCode>? couponCodes;

  bool? isActive;
  DateTime? dateCreated;
  String? creator;

  Coupon({
    this.id,
    this.name,
    this.description,
    this.images,
    this.couponType,
    this.startDate,
    this.endDate,
    this.maxAmount,
    this.totalUsed,
    this.discountAmount,
    this.businessName,
    this.serviceName,
    this.business,
    this.couponCodes,
    this.service,
    this.isActive,
    this.dateCreated,
    this.creator,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CouponCode {
  @JsonKey(name: "_id")
  String? id;
  String? value;
  bool? used;
  String? user;

  CouponCode({
    this.id,
    this.value,
    this.used,
    this.user,
  });

  factory CouponCode.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeFromJson(json);
  Map<String, dynamic> toJson() => _$CouponCodeToJson(this);
}
