import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/coupon.dart';
import 'package:komkum/model/order.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/service.dart';
import 'package:komkum/viewmodel/review_viewmodel.dart';
part 'order_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderViewmodel {
  Order? order;
  List<OrderItemWithProductInfo>? items;
  Business? business;
  ReviewViewmodel? userReviewInfo;

  OrderViewmodel({this.order, this.userReviewInfo, this.business, this.items});

  factory OrderViewmodel.fromJson(Map<String, dynamic> json) =>
      _$OrderViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderViewmodelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemViewmodel {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  Product? product;
  Business? business;
  int? price;
  int qty;
  Coupon? coupon;
  Service? service;
  String? image;

  OrderItemViewmodel({
    this.id,
    this.name,
    this.product,
    this.business,
    this.service,
    this.price,
    this.qty = 1,
    this.coupon,
    this.image,
  });

  factory OrderItemViewmodel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemViewmodelToJson(this);
}
