import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
import 'package:komkum/viewmodel/service_viewmodel.dart';
part 'browse_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseViewmodel {
  List<CouponViewmodel>? coupons;
  List<Product>? products;
  List<ServiceViewmodel>? featuredServices;
  List<BusienssViewmodel>? featuredBusinesses;

  BrowseViewmodel({
    this.coupons,
    this.products,
    this.featuredServices,
    this.featuredBusinesses,
  });

  factory BrowseViewmodel.fromJson(Map<String, dynamic> json) =>
      _$BrowseViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseViewmodelToJson(this);
}
