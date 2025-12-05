import 'package:kaiho_app/core/network/api_client.dart';
import 'package:kaiho_app/features/products/data/models/product_model.dart';
import 'package:kaiho_app/features/products/data/models/category_model.dart';

abstract class ProductRemoteDataSource {
  /// Obtiene una lista de productos
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int perPage = 20,
    String? search,
    String? category,
    bool? featured,
    String? orderBy,
    String? order,
  });

  /// Obtiene un producto por ID
  Future<ProductModel> getProductById(int id);

  /// Obtiene las categorías de productos
  Future<List<CategoryModel>> getCategories({
    int page = 1,
    int perPage = 20,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int perPage = 20,
    String? search,
    String? category,
    bool? featured,
    String? orderBy,
    String? order,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'page': page,
        'per_page': perPage,
      };

      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }

      if (category != null && category.isNotEmpty) {
        queryParameters['category'] = category;
      }

      if (featured != null) {
        queryParameters['featured'] = featured;
      }

      if (orderBy != null) {
        queryParameters['orderby'] = orderBy;
      }

      if (order != null) {
        queryParameters['order'] = order;
      }

      final response = await apiClient.get(
        '/products',
        queryParameters: queryParameters,
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      }

      throw Exception('Formato de respuesta inesperado');
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await apiClient.get('/products/$id');

      if (response.data is Map<String, dynamic>) {
        return ProductModel.fromJson(response.data);
      }

      throw Exception('Formato de respuesta inesperado');
    } catch (e) {
      throw Exception('Error al obtener producto $id: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories({
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await apiClient.get(
        '/products/categories',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => CategoryModel.fromJson(json))
            .toList();
      }

      throw Exception('Formato de respuesta inesperado');
    } catch (e) {
      throw Exception('Error al obtener categorías: $e');
    }
  }
}
