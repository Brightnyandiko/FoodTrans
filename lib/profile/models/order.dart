// lib/profile/models/order.dart
import 'package:equatable/equatable.dart';

enum OrderStatus { pending, confirmed, preparing, inDelivery, delivered, cancelled }

class Order extends Equatable {
  const Order({
    required this.id,
    required this.itemName,
    required this.itemImage,
    required this.price,
    required this.quantity,
    required this.status,
  });

  final String id;
  final String itemName;
  final String itemImage;
  final double price;
  final int quantity;
  final OrderStatus status;

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.inDelivery:
        return 'In Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  List<Object> get props => [id, itemName, itemImage, price, quantity, status];
}