import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/address.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: "_id")
  String? id;
  String? phoneNumber;
  String? profileImage;
  String? username;
  String? password;
  String? accountType;
  List<String>? favoriteBusinesses;
  String? favoriteService;
  DateTime? dateCreate;
  List<String>? orders;
  List<Address>? addresses;
  List<String>? fcmToken;
  List<String>? userBusinesses;
  List<String>? favoriteProducts;

  User(
      {this.id,
      this.phoneNumber,
      this.username,
      this.profileImage,
      this.password,
      this.accountType,
      this.favoriteBusinesses,
      this.favoriteService,
      this.dateCreate,
      this.orders,
      this.addresses,
      this.userBusinesses,
      this.favoriteProducts,
      this.fcmToken});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
