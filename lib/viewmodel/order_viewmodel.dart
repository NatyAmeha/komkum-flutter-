import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/business.dart';
import 'package:komkum/model/order.dart';
import 'package:komkum/model/product.dart';
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
