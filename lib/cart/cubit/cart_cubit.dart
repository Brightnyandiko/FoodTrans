import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../home/models/food_item.dart';
import '../models/cart_item.dart';
// import '../models/food_item.dart';
import '../repository/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(CartInitial());

  final CartRepository _cartRepository;

  Future<void> loadCart() async {
    try {
      emit(CartLoading());
      final items = await _cartRepository.getCartItems();
      final recommendedItems = await _cartRepository.getRecommendedItems();

      if (items.isEmpty) {
        emit(const CartEmpty());
      } else {
        emit(CartLoaded(items: items, recommendedItems: recommendedItems));
      }
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  Future<void> addToCart(FoodItem foodItem, int quantity) async {
    try {
      await _cartRepository.addToCart(foodItem, quantity);
      await loadCart();
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  Future<void> updateQuantity(String foodItemId, int quantity) async {
    try {
      if (quantity <= 0) {
        await _cartRepository.removeFromCart(foodItemId);
      } else {
        await _cartRepository.updateQuantity(foodItemId, quantity);
      }
      await loadCart();
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  Future<void> toggleItemSelection(String foodItemId) async {
    try {
      await _cartRepository.toggleItemSelection(foodItemId);
      await loadCart();
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  Future<void> removeFromCart(String foodItemId) async {
    try {
      await _cartRepository.removeFromCart(foodItemId);
      await loadCart();
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartRepository.clearCart();
      emit(const CartEmpty());
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }
}