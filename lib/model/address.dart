import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(name: "_id")
  String? id;
  GeoSpacial? location;
  String? localAddress;

  Address({this.id, this.location, this.localAddress});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GeoSpacial {
  String? type;
  List<double>? coordinates;

  GeoSpacial({
    this.type,
    this.coordinates,
  });

  factory GeoSpacial.fromJson(Map<String, dynamic> json) =>
      _$GeoSpacialFromJson(json);
  Map<String, dynamic> toJson() => _$GeoSpacialToJson(this);
}
