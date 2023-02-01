import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/order.dart';
import 'package:komkum/model/user.dart';
import 'package:komkum/viewmodel/business_viewmodel.dart';
import 'package:komkum/viewmodel/product_viewmodel.dart';
part "user_viewmodel.g.dart";

@JsonSerializable(explicitToJson: true)
class UserViewmodel {
  User? user;
  List<BusienssViewmodel>? favoriteBusinesses;
  List<ProductViewmodel>? favoriteProducts;

  UserViewmodel({
    this.user,
    this.favoriteBusinesses,
    this.favoriteProducts,
  });

  factory UserViewmodel.fromJson(Map<String, dynamic> json) =>
      _$UserViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$UserViewmodelToJson(this);
}
