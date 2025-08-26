import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable';
import 'package:equatable/equatable.dart';

import '../models/cart_item.dart';
import '../models/delivery_address.dart';
// import 'package:payment_summary_app/cart/models/cart_item.dart';
// import 'package:payment_summary_app/cart/models/delivery_address.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void loadCart() async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      // Simulate fetching data
      await Future.delayed(const Duration(seconds: 1));
      final cartItems = [
        const CartItem(name: 'Burger With Meat', price: 12230.0, quantity: 14),
      ];
      const deliveryFee = 50.000;
      const taxRate = 0.10;
      final subtotal = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
      final tax = subtotal * taxRate;
      final totalPrice = subtotal + deliveryFee + tax;

      const deliveryAddress = DeliveryAddress(
        name: 'Albert Stevano',
        phoneNo: '+12 8347 2838 28',
        address: 'New York',
        houseNo: 'BC54 Berlin',
        city: 'New York City',
      );

      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: cartItems,
        deliveryFee: deliveryFee,
        taxRate: taxRate,
        totalPrice: totalPrice,
        deliveryAddress: deliveryAddress,
      ));
    } catch (_) {
      emit(state.copyWith(status: CartStatus.failure));
    }
  }
}

