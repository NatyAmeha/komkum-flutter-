import 'package:json_annotation/json_annotation.dart';
import 'package:komkum/model/user.dart';
part "user_viewmodel.g.dart";

@JsonSerializable(explicitToJson: true)
class UserViewmodel {
  User? user;

  UserViewmodel({this.user});

  factory UserViewmodel.fromJson(Map<String, dynamic> json) =>
      _$UserViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$UserViewmodelToJson(this);
}
