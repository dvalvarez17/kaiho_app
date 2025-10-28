import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String description;
  final String display;
  final ImageModel? image;
  @JsonKey(name: 'menu_order')
  final int menuOrder;
  final int count;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    this.image,
    required this.menuOrder,
    required this.count,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class ImageModel {
  final int id;
  final String src;
  final String name;
  final String alt;

  ImageModel({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
