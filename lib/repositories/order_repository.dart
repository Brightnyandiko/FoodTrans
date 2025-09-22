// lib/repositories/order_repository.dart
import '../profile/models/order.dart';

class OrderRepository {
  Future<List<Order>> getUserOrders() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      const Order(
        id: '888333777',
        itemName: 'Burger With Meat',
        itemImage: 'assets/images/burger.png',
        price: 12230,
        quantity: 14,
        status: OrderStatus.inDelivery,
      ),
      // Add more orders as needed
    ];
  }

  Future<List<Order>> getAllUserOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Return complete order history
    return [
      const Order(
        id: '888333777',
        itemName: 'Burger With Meat',
        itemImage: 'assets/images/burger.png',
        price: 12230,
        quantity: 14,
        status: OrderStatus.inDelivery,
      ),
      const Order(
        id: '888333778',
        itemName: 'Pizza Margherita',
        itemImage: 'assets/images/pizza.png',
        price: 8500,
        quantity: 2,
        status: OrderStatus.delivered,
      ),
    ];
  }
}