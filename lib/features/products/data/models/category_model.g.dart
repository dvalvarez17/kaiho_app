// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      parent: (json['parent'] as num).toInt(),
      description: json['description'] as String,
      display: json['display'] as String,
      image:
          json['image'] == null
              ? null
              : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      menuOrder: (json['menu_order'] as num).toInt(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'parent': instance.parent,
      'description': instance.description,
      'display': instance.display,
      'image': instance.image,
      'menu_order': instance.menuOrder,
      'count': instance.count,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
  id: (json['id'] as num).toInt(),
  src: json['src'] as String,
  name: json['name'] as String,
  alt: json['alt'] as String,
);

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'src': instance.src,
      'name': instance.name,
      'alt': instance.alt,
    };
