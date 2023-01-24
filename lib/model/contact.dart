import 'package:json_annotation/json_annotation.dart';
part 'contact.g.dart';

@JsonSerializable(explicitToJson: true)
class Contact {
  @JsonKey(name: "_id")
  String? id;
  String? email;
  List<String>? phoneNumber;
  Map<String, String>? links;

  Contact({this.id, this.email, this.phoneNumber, this.links});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
