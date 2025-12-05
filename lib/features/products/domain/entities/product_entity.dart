import 'package:equatable/equatable.dart';

class ProductImageEntity extends Equatable {
  final String src;
  final String name;
  final String alt;

  const ProductImageEntity({
    required this.src,
    this.name = '',
    this.alt = '',
  });

  @override
  List<Object?> get props => [src, name, alt];
}

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double regularPrice;
  final String imageUrl;
  final String category;
  final bool isFeatured;
  final bool inStock;
  final List<ProductImageEntity> images;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.regularPrice = 0.0,
    this.isFeatured = false,
    this.inStock = true,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        regularPrice,
        imageUrl,
        category,
        isFeatured,
        inStock,
        images,
      ];
}
