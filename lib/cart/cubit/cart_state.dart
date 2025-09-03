part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartEmpty extends CartState {
  const CartEmpty();
}

class CartLoaded extends CartState {
  const CartLoaded({
    required this.items,
    required this.recommendedItems,
  });

  final List<CartItem> items;
  final List<FoodItem> recommendedItems;

  double get subtotal => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => 0.0; // Free delivery

  double get discount => subtotal * 0.225; // 22.5% discount

  double get total => subtotal - discount + deliveryFee;

  int get totalItemCount => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object> get props => [items, recommendedItems];
}

class CartError extends CartState {
  const CartError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}