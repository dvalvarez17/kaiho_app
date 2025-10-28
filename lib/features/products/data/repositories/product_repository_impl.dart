import 'package:kaiho_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts({
    int page = 1,
    int perPage = 20,
    String? search,
    String? category,
    bool? featured,
    String? orderBy,
    String? order,
  }) async {
    try {
      final productModels = await remoteDataSource.getProducts(
        page: page,
        perPage: perPage,
        search: search,
        category: category,
        featured: featured,
        orderBy: orderBy,
        order: order,
      );

      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    try {
      final productModel = await remoteDataSource.getProductById(int.parse(id));
      return productModel.toEntity();
    } catch (e) {
      throw Exception('Error al obtener producto $id: $e');
    }
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts({
    int page = 1,
    int perPage = 10,
  }) async {
    return getProducts(
      page: page,
      perPage: perPage,
      featured: true,
      orderBy: 'popularity',
      order: 'desc',
    );
  }

  @override
  Future<List<ProductEntity>> getNewArrivals({
    int page = 1,
    int perPage = 10,
  }) async {
    return getProducts(
      page: page,
      perPage: perPage,
      orderBy: 'date',
      order: 'desc',
    );
  }
}
