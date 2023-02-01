import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/order.dart';
part 'order_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderViewmodel {
  Order? order;

  OrderViewmodel({this.order});

  factory OrderViewmodel.fromJson(Map<String, dynamic> json) =>
      _$OrderViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderViewmodelToJson(this);
}
