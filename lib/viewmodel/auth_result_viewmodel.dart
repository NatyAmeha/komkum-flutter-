import 'package:json_annotation/json_annotation.dart';
part 'auth_result_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResultViewmodel {
  String? token;

  AuthResultViewmodel({this.token});

  factory AuthResultViewmodel.fromJson(Map<String, dynamic> json) =>
      _$AuthResultViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResultViewmodelToJson(this);
}
