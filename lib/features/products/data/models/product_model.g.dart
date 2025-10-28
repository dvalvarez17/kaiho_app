// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  permalink: json['permalink'] as String?,
  type: json['type'] as String,
  status: json['status'] as String,
  featured: json['featured'] as bool,
  catalogVisibility: json['catalog_visibility'] as String,
  description: json['description'] as String,
  shortDescription: json['short_description'] as String,
  sku: json['sku'] as String,
  price: json['price'] as String,
  regularPrice: json['regular_price'] as String,
  salePrice: json['sale_price'] as String?,
  onSale: json['on_sale'] as bool,
  purchasable: json['purchasable'] as bool,
  stockStatus: json['stock_status'] as String,
  stockQuantity: (json['stock_quantity'] as num?)?.toInt(),
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => ProductTagModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'permalink': instance.permalink,
      'type': instance.type,
      'status': instance.status,
      'featured': instance.featured,
      'catalog_visibility': instance.catalogVisibility,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'sku': instance.sku,
      'price': instance.price,
      'regular_price': instance.regularPrice,
      'sale_price': instance.salePrice,
      'on_sale': instance.onSale,
      'purchasable': instance.purchasable,
      'stock_status': instance.stockStatus,
      'stock_quantity': instance.stockQuantity,
      'images': instance.images,
      'categories': instance.categories,
      'tags': instance.tags,
    };

ProductImageModel _$ProductImageModelFromJson(Map<String, dynamic> json) =>
    ProductImageModel(
      id: (json['id'] as num).toInt(),
      src: json['src'] as String,
      name: json['name'] as String,
      alt: json['alt'] as String,
    );

Map<String, dynamic> _$ProductImageModelToJson(ProductImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'src': instance.src,
      'name': instance.name,
      'alt': instance.alt,
    };

ProductCategoryModel _$ProductCategoryModelFromJson(
  Map<String, dynamic> json,
) => ProductCategoryModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
);

Map<String, dynamic> _$ProductCategoryModelToJson(
  ProductCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
};

ProductTagModel _$ProductTagModelFromJson(Map<String, dynamic> json) =>
    ProductTagModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$ProductTagModelToJson(ProductTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
