import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';
part 'service_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceViewmodel {
  Service? service;
  BusienssViewmodel? business;
  List<Product>? serviceItems;
  ReviewViewmodel? reviewInfo;
  List<ServiceViewmodel>? relatedServices;
  List<CouponViewmodel>? coupons;

  ServiceViewmodel({
    this.service,
    this.business,
    this.serviceItems,
    this.reviewInfo,
    this.relatedServices,
    this.coupons,
  });

  factory ServiceViewmodel.fromJson(Map<String, dynamic> json) =>
      _$ServiceViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceViewmodelToJson(this);
}
