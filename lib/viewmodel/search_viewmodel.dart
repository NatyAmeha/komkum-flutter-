import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';
part 'search_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchViewmodel {
  List<BusienssViewmodel>? businesses;
  List<ServiceViewmodel>? services;
  List<ProductViewmodel>? products;
  List<CouponViewmodel>? coupons;

  SearchViewmodel({
    this.businesses,
    this.services,
    this.products,
    this.coupons,
  });

  factory SearchViewmodel.fromJson(Map<String, dynamic> json) =>
      _$SearchViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchViewmodelToJson(this);
}
