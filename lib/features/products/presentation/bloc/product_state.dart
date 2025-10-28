part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final int currentPage;

  const ProductsLoaded({
    required this.products,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  ProductsLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [products, hasReachedMax, currentPage];
}

class ProductsLoadingMore extends ProductState {
  final List<ProductEntity> products;
  final int currentPage;

  const ProductsLoadingMore({
    required this.products,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [products, currentPage];
}

class FeaturedProductsLoaded extends ProductState {
  final List<ProductEntity> products;

  const FeaturedProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class NewArrivalsLoaded extends ProductState {
  final List<ProductEntity> products;

  const NewArrivalsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductDetailLoaded extends ProductState {
  final ProductEntity product;

  const ProductDetailLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
