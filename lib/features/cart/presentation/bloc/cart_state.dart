part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  final double total;
  final int itemCount;

  const CartLoaded({
    required this.items,
    required this.total,
    required this.itemCount,
  });

  @override
  List<Object?> get props => [items, total, itemCount];
}
