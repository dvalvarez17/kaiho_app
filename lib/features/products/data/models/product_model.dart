import 'package:json_annotation/json_annotation.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String name;
  final String slug;
  final String? permalink;
  final String type;
  final String status;
  final bool featured;
  @JsonKey(name: 'catalog_visibility')
  final String catalogVisibility;
  final String description;
  @JsonKey(name: 'short_description')
  final String shortDescription;
  final String sku;
  final String price;
  @JsonKey(name: 'regular_price')
  final String regularPrice;
  @JsonKey(name: 'sale_price')
  final String? salePrice;
  @JsonKey(name: 'on_sale')
  final bool onSale;
  final bool purchasable;
  @JsonKey(name: 'stock_status')
  final String stockStatus;
  @JsonKey(name: 'stock_quantity')
  final int? stockQuantity;
  final List<ProductImageModel> images;
  final List<ProductCategoryModel> categories;
  final List<ProductTagModel> tags;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    this.permalink,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    this.salePrice,
    required this.onSale,
    required this.purchasable,
    required this.stockStatus,
    this.stockQuantity,
    this.images = const [],
    this.categories = const [],
    this.tags = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // Convertir a Entity del dominio
  ProductEntity toEntity() {
    return ProductEntity(
      id: id.toString(),
      name: name,
      description: shortDescription.isNotEmpty ? shortDescription : description,
      price: double.tryParse(price) ?? 0.0,
      regularPrice: double.tryParse(regularPrice) ?? 0.0,
      imageUrl: images.isNotEmpty ? images.first.src : '',
      category: categories.isNotEmpty ? categories.first.name : 'General',
      isFeatured: featured,
      inStock: stockStatus == 'instock',
      images: images
          .map((img) => ProductImageEntity(
                src: img.src,
                name: img.name,
                alt: img.alt,
              ))
          .toList(),
    );
  }
}

@JsonSerializable()
class ProductImageModel {
  final int id;
  final String src;
  final String name;
  final String alt;

  ProductImageModel({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageModelToJson(this);
}

@JsonSerializable()
class ProductCategoryModel {
  final int id;
  final String name;
  final String slug;

  ProductCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryModelToJson(this);
}

@JsonSerializable()
class ProductTagModel {
  final int id;
  final String name;
  final String slug;

  ProductTagModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ProductTagModel.fromJson(Map<String, dynamic> json) =>
      _$ProductTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTagModelToJson(this);
}
