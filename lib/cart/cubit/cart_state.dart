// lib/cart/cubit/cart_state.dart
part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {
  const CartEmpty();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final Map<String, CartItem> items;

  const CartLoaded({required this.items});

  int get itemCount => items.length;

  int get totalQuantity => items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get subtotal => totalAmount;

  double get deliveryFee => items.isEmpty ? 0.0 : 0.0;

  double get discount => totalAmount * 0.22;

  double get finalTotal => subtotal + deliveryFee - discount;

  bool get isEmpty => items.isEmpty;

  @override
  List<Object> get props => [items];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}