import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  /// Obtiene una lista de productos
  Future<List<ProductEntity>> getProducts({
    int page = 1,
    int perPage = 20,
    String? search,
    String? category,
    bool? featured,
    String? orderBy,
    String? order,
  });

  /// Obtiene un producto por ID
  Future<ProductEntity> getProductById(String id);

  /// Obtiene productos destacados
  Future<List<ProductEntity>> getFeaturedProducts({
    int page = 1,
    int perPage = 10,
  });

  /// Obtiene nuevos productos
  Future<List<ProductEntity>> getNewArrivals({
    int page = 1,
    int perPage = 10,
  });
}
