part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final ProductEntity product;

  const ToggleFavoriteEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final String productId;

  const RemoveFavoriteEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class ClearFavoritesEvent extends FavoritesEvent {}
