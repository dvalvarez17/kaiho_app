import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';
import 'package:kaiho_app/features/products/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;

  GetProductByIdUseCase({required this.repository});

  Future<ProductEntity> call(String id) async {
    return await repository.getProductById(id);
  }
}
