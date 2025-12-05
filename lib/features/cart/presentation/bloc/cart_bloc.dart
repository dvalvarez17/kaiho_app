import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaiho_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:kaiho_app/features/products/domain/entities/product_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItemEntity> _items = [];

  CartBloc() : super(const CartLoaded(items: [], total: 0, itemCount: 0)) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingIndex != -1) {
      // Producto ya existe, incrementar cantidad
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + event.quantity,
      );
    } else {
      // Agregar nuevo producto
      _items.add(CartItemEntity(
        product: event.product,
        quantity: event.quantity,
      ));
    }

    _emitCartLoaded(emit);
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    _items.removeWhere((item) => item.product.id == event.productId);
    _emitCartLoaded(emit);
  }

  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<CartState> emit) {
    final index = _items.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index != -1) {
      if (event.quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: event.quantity);
      }
    }

    _emitCartLoaded(emit);
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    _items.clear();
    _emitCartLoaded(emit);
  }

  void _emitCartLoaded(Emitter<CartState> emit) {
    final total = _items.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );
    final itemCount = _items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    emit(CartLoaded(
      items: List.from(_items),
      total: total,
      itemCount: itemCount,
    ));
  }
}
