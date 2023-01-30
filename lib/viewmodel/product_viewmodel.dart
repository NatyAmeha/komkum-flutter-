import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/viewmodel/coupon_viewmodel.dart';
part 'product_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductViewmodel {
  Product? serviceItem;
  Service? serviceInfo;
  Business? businessInfo;
  List<ProductViewmodel>? relatedServiceItems;
  List<CouponViewmodel>? couponsInfo;

  ProductViewmodel({
    this.serviceItem,
    this.serviceInfo,
    this.businessInfo,
    this.relatedServiceItems,
    this.couponsInfo,
  });

  factory ProductViewmodel.fromJson(Map<String, dynamic> json) =>
      _$ProductViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductViewmodelToJson(this);
}
