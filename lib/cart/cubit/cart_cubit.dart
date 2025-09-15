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
      // print('Adding product: ${product.id} - ${product.name}');
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

      // print('Cart now has ${_items.length} items'); // Debug
      // print('Items: ${_items.keys}');

      _emitCartState();
    } catch (e) {
      // print('Error adding item: $e');
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
        // removeItem(productId);
        _items.remove(productId);
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
    print('CartCubit: Emitting state with ${_items.length} items');
    print('CartCubit: Items keys: ${_items.keys}');
    if (_items.isEmpty) {
      print('CartCubit: Emitting CartEmpty');
      emit(const CartEmpty());
    } else {
      print('CartCubit: Emitting CartLoaded with ${_items.length} items');
      emit(CartLoaded(items: Map.from(_items)));
    }
  }
}