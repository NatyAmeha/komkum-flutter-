import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/address.dart';
import 'package:komkum/model/contact.dart';
import 'package:komkum/model/product.dart';
import 'package:komkum/model/service.dart';
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  List<String>? image;
  int? price;

  PriceRange? priceRange;
  String? business;

  List<OrderItem>? items;
  String? code;
  String? user;
  String? status;
  DateTime? expireDate;
  Map<String, String>? moreInfo;
  String? type;
  DateTime? dateCreated;
  Address? address;
  Contact? contact;

  Order({
    this.id,
    this.name,
    this.image,
    this.price,
    this.priceRange,
    this.business,
    this.items,
    this.code,
    this.user,
    this.status,
    this.expireDate,
    this.moreInfo,
    this.type,
    this.dateCreated,
    this.address,
    this.contact,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PriceRange {
  int? min;
  int? max;

  PriceRange({this.min, this.max});

  factory PriceRange.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFromJson(json);
  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(name: "_id")
  String? id;
  String? serviceItem;
  String? productInfo;
  double? price;
  String? productName;
  int? qty;
  String? coupon;
  String? business;
  String? service;
  String? image;

  OrderItem(
      {this.id,
      this.serviceItem,
      this.productInfo,
      this.productName,
      this.price,
      this.qty,
      this.coupon,
      this.business,
      this.service,
      this.image});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemWithProductInfo {
  @JsonKey(name: "_id")
  String? id;
  Product? serviceItem;
  String? productInfo;
  double? price;
  String? productName;
  int? qty;
  String? coupon;
  String? business;
  Service? service;
  String? image;

  OrderItemWithProductInfo(
      {this.id,
      this.serviceItem,
      this.productInfo,
      this.productName,
      this.price,
      this.qty,
      this.coupon,
      this.business,
      this.service,
      this.image});

  factory OrderItemWithProductInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderItemWithProductInfoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemWithProductInfoToJson(this);
}
