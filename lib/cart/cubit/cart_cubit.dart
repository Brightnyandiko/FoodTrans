// lib/cart/cubit/cart_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';
import '../../product/models/models.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartEmpty());

  final Map<String, CartItem> _items = {};

  void addItem(Product product, {int quantity = 1}) {
    try {
      emit(const CartLoading());

      if (_items.containsKey(product.id)) {
        // Update existing item
        final existingItem = _items[product.id]!;
        _items[product.id] = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add new item
        _items[product.id] = CartItem(
          id: DateTime.now().toString(),
          product: product,
          quantity: quantity,
        );
      }

      _emitCartState();
    } catch (e) {
      emit(CartError(message: 'Failed to add item to cart'));
    }
  }

  void removeItem(String productId) {
    try {
      emit(const CartLoading());
      _items.remove(productId);
      _emitCartState();
    } catch (e) {
      emit(CartError(message: 'Failed to remove item from cart'));
    }
  }

  void updateQuantity(String productId, int quantity) {
    try {
      emit(const CartLoading());

      if (quantity <= 0) {
        removeItem(productId);
        return;
      }

      if (_items.containsKey(productId)) {
        final existingItem = _items[productId]!;
        _items[productId] = existingItem.copyWith(quantity: quantity);
        _emitCartState();
      }
    } catch (e) {
      emit(CartError(message: 'Failed to update quantity'));
    }
  }

  void clearCart() {
    try {
      emit(const CartLoading());
      _items.clear();
      _emitCartState();
    } catch (e) {
      emit(CartError(message: 'Failed to clear cart'));
    }
  }

  void _emitCartState() {
    if (_items.isEmpty) {
      emit(const CartEmpty());
    } else {
      emit(CartLoaded(items: Map.from(_items)));
    }
  }
}