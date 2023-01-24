import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? description;
  List<String>? images;
  Map<String, String>? moreInfo;
  String? service;
  String? servieName;
  String? business;
  String? businesName;
  String? category;
  List<String>? tags;
  int? fixedPrice;
  int? minPrice;
  int? maxPrice;
  int? maxAmount;
  int? likeCount;
  int? viewCount;
  bool? featured;
  String? callToAction;
  DateTime? expireDate;
  List<ProductVariant>? variants;
  DateTime? dateCreated;

  Product({
    this.id,
    this.name,
    this.images,
    this.description,
    this.moreInfo,
    this.service,
    this.servieName,
    this.businesName,
    this.business,
    this.category,
    this.tags,
    this.fixedPrice,
    this.minPrice,
    this.maxAmount,
    this.maxPrice,
    this.likeCount,
    this.viewCount,
    this.featured,
    this.variants,
    this.callToAction,
    this.expireDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductVariant {
  List<String>? images;
  Map<String, String>? moreInfo;
  int? fixedPrice;
  int? minPrice;
  int? maxPrice;

  ProductVariant({
    this.images,
    this.moreInfo,
    this.fixedPrice,
    this.minPrice,
    this.maxPrice,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);
}
