import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/domain/repositories/product_repository.dart';

class GetFeaturedProductsUseCase {
  final ProductRepository repository;

  GetFeaturedProductsUseCase({required this.repository});

  Future<List<ProductEntity>> call({
    int page = 1,
    int perPage = 10,
  }) async {
    return await repository.getFeaturedProducts(
      page: page,
      perPage: perPage,
    );
  }
}
