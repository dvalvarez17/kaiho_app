import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<ProductEntity> _favorites = [];

  FavoritesBloc() : super(const FavoritesLoaded(favorites: [])) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ClearFavoritesEvent>(_onClearFavorites);
  }

  void _onToggleFavorite(ToggleFavoriteEvent event, Emitter<FavoritesState> emit) {
    final existingIndex = _favorites.indexWhere(
      (product) => product.id == event.product.id,
    );

    if (existingIndex != -1) {
      // Ya está en favoritos, removerlo
      _favorites.removeAt(existingIndex);
    } else {
      // Agregarlo a favoritos
      _favorites.add(event.product);
    }

    _emitFavoritesLoaded(emit);
  }

  void _onRemoveFavorite(RemoveFavoriteEvent event, Emitter<FavoritesState> emit) {
    _favorites.removeWhere((product) => product.id == event.productId);
    _emitFavoritesLoaded(emit);
  }

  void _onClearFavorites(ClearFavoritesEvent event, Emitter<FavoritesState> emit) {
    _favorites.clear();
    _emitFavoritesLoaded(emit);
  }

  void _emitFavoritesLoaded(Emitter<FavoritesState> emit) {
    emit(FavoritesLoaded(favorites: List.from(_favorites)));
  }
}
