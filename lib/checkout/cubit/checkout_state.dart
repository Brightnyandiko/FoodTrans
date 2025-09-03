part of 'checkout_cubit.dart';

enum CheckoutStatus { initial, loading, success, failure }

class CheckoutState extends Equatable {
  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.cartItems = const <CartItem>[],
    this.deliveryFee = 0.0,
    this.taxRate = 0.0,
    this.totalPrice = 0.0,
    this.deliveryAddress = const DeliveryAddress(),
  });

  final CheckoutStatus status;
  final List<CartItem> cartItems;
  final double deliveryFee;
  final double taxRate;
  final double totalPrice;
  final DeliveryAddress deliveryAddress;

  CheckoutState copyWith({
    CheckoutStatus? status,
    List<CartItem>? cartItems,
    double? deliveryFee,
    double? taxRate,
    double? totalPrice,
    DeliveryAddress? deliveryAddress,
  }) {
    return CheckoutState(
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

