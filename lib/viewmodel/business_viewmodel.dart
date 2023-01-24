import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';
part 'business_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class BusienssViewmodel {
  Business? businessInfo;
  ReviewViewmodel? reviewInfo;
  List<Business>? relatedBusinesses;
  bool? isInUserFavorite;
  List<CouponViewmodel>? coupons;
  List<ServiceViewmodel>? services;

  List<ProductViewmodel>? trendingProducts;
  @JsonSerializable(explicitToJson: true)
  BusienssViewmodel({
    this.businessInfo,
    this.reviewInfo,
    this.relatedBusinesses,
    this.isInUserFavorite,
    this.coupons,
    this.services,
    this.trendingProducts,
  });

  factory BusienssViewmodel.fromJson(Map<String, dynamic> json) =>
      _$BusienssViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$BusienssViewmodelToJson(this);
}
