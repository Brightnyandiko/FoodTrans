import 'package:equatable/equatable.dart';

import '../../home/models/food_item.dart';
// import 'food_item.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.foodItem,
    required this.quantity,
    required this.isSelected,
  });

  final FoodItem foodItem;
  final int quantity;
  final bool isSelected;

  CartItem copyWith({
    FoodItem? foodItem,
    int? quantity,
    bool? isSelected,
  }) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  double get totalPrice => foodItem.price * quantity;

  @override
  List<Object> get props => [foodItem, quantity, isSelected];
}