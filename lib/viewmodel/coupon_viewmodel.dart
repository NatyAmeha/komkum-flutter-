import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';
part 'coupon_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class CouponViewmodel {
  Coupon? couponInfo;
  List<ServiceViewmodel>? services;
  Business? business;

  CouponViewmodel({this.couponInfo, this.services, this.business});

  factory CouponViewmodel.fromJson(Map<String, dynamic> json) =>
      _$CouponViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponViewmodelToJson(this);
}
