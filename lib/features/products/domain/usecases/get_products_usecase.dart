import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  Future<List<ProductEntity>> call({
    int page = 1,
    int perPage = 20,
    String? search,
    String? category,
    bool? featured,
    String? orderBy,
    String? order,
  }) async {
    return await repository.getProducts(
      page: page,
      perPage: perPage,
      search: search,
      category: category,
      featured: featured,
      orderBy: orderBy,
      order: order,
    );
  }
}
