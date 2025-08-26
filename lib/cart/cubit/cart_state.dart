part of 'cart_cubit.dart';

enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  const CartState({
    this.status = CartStatus.initial,
    this.cartItems = const <CartItem>[],
    this.deliveryFee = 0.0,
    this.taxRate = 0.0,
    this.totalPrice = 0.0,
    this.deliveryAddress = const DeliveryAddress(),
  });

  final CartStatus status;
  final List<CartItem> cartItems;
  final double deliveryFee;
  final double taxRate;
  final double totalPrice;
  final DeliveryAddress deliveryAddress;

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    double? deliveryFee,
    double? taxRate,
    double? totalPrice,
    DeliveryAddress? deliveryAddress,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      taxRate: taxRate ?? this.taxRate,
      totalPrice: totalPrice ?? this.totalPrice,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }

  @override
  List<Object> get props => [
        status,
        cartItems,
        deliveryFee,
        taxRate,
        totalPrice,
        deliveryAddress,
      ];
}

