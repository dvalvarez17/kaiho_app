import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/domain/repositories/product_repository.dart';

class GetNewArrivalsUseCase {
  final ProductRepository repository;

  GetNewArrivalsUseCase({required this.repository});

  Future<List<ProductEntity>> call({
    int page = 1,
    int perPage = 10,
  }) async {
    return await repository.getNewArrivals(
      page: page,
      perPage: perPage,
    );
  }
}
