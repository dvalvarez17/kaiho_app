part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  final int page;
  final int perPage;

  const LoadProductsEvent({
    this.page = 1,
    this.perPage = 20,
  });

  @override
  List<Object?> get props => [page, perPage];
}

class LoadFeaturedProductsEvent extends ProductEvent {
  final int page;
  final int perPage;

  const LoadFeaturedProductsEvent({
    this.page = 1,
    this.perPage = 10,
  });

  @override
  List<Object?> get props => [page, perPage];
}

class LoadNewArrivalsEvent extends ProductEvent {
  final int page;
  final int perPage;

  const LoadNewArrivalsEvent({
    this.page = 1,
    this.perPage = 10,
  });

  @override
  List<Object?> get props => [page, perPage];
}

class LoadProductByIdEvent extends ProductEvent {
  final String id;

  const LoadProductByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SearchProductsEvent extends ProductEvent {
  final String query;
  final int page;
  final int perPage;

  const SearchProductsEvent({
    required this.query,
    this.page = 1,
    this.perPage = 20,
  });

  @override
  List<Object?> get props => [query, page, perPage];
}

class LoadMoreProductsEvent extends ProductEvent {
  final int page;
  final int perPage;

  const LoadMoreProductsEvent({
    required this.page,
    this.perPage = 20,
  });

  @override
  List<Object?> get props => [page, perPage];
}
