import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/address.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: "_id")
  String? id;
  String? phoneNumber;
  String? username;
  String? password;
  String? accountType;
  List<String>? favoriteBusinesses;
  String? favoriteService;
  DateTime? dateCreate;
  List<String>? orders;
  List<Address>? addresses;

  List<String>? userBusinesses;
  List<String>? favoriteProducts;

  User({
    this.id,
    this.phoneNumber,
    this.username,
    this.password,
    this.accountType,
    this.favoriteBusinesses,
    this.favoriteService,
    this.dateCreate,
    this.orders,
    this.addresses,
    this.userBusinesses,
    this.favoriteProducts,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
