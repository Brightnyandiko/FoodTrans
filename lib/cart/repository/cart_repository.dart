// import 'package:food_trans/home/models/food_category.dart';
//
// import '../../home/models/food_item.dart';
// import '../models/cart_item.dart';
// // import '../models/food_item.dart';
//
// class CartRepository {
//   // In-memory storage for demo purposes
//   final List<CartItem> _cartItems = [];
//
//   Future<List<CartItem>> getCartItems() async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     return List.from(_cartItems);
//   }
//
//   Future<List<FoodItem>> getRecommendedItems() async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     return [
//       const FoodItem(
//         id: 'rec1',
//         name: 'Ordinary Burgers',
//         price: 17230,
//         imageUrl: 'assets/images/burger1.jpg',
//         rating: 4.9,
//         distance: '300m',
//         description: 'Delicious ordinary burger',
//         category: FoodCategory.burger,
//         deliveryTime: '20-30 minutes',
//       ),
//       const FoodItem(
//         id: 'rec2',
//         name: 'Ordinary Burgers',
//         price: 17230,
//         imageUrl: 'assets/images/burger2.jpg',
//         rating: 4.9,
//         distance: '190m',
//         description: 'Another delicious ordinary burger',
//         category: FoodCategory.burger,
//         deliveryTime: '',
//       ),
//     ];
//   }
//
//   Future<void> addToCart(FoodItem foodItem, int quantity) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     final existingIndex = _cartItems.indexWhere(
//           (item) => item.foodItem.id == foodItem.id,
//     );
//
//     if (existingIndex != -1) {
//       final existingItem = _cartItems[existingIndex];
//       _cartItems[existingIndex] = existingItem.copyWith(
//         quantity: existingItem.quantity + quantity,
//       );
//     } else {
//       _cartItems.add(CartItem(
//         foodItem: foodItem,
//         quantity: quantity,
//         isSelected: true,
//       ));
//     }
//   }
//
//   Future<void> updateQuantity(String foodItemId, int quantity) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     final index = _cartItems.indexWhere(
//           (item) => item.foodItem.id == foodItemId,
//     );
//
//     if (index != -1) {
//       _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
//     }
//   }
//
//   Future<void> toggleItemSelection(String foodItemId) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     final index = _cartItems.indexWhere(
//           (item) => item.foodItem.id == foodItemId,
//     );
//
//     if (index != -1) {
//       _cartItems[index] = _cartItems[index].copyWith(
//         isSelected: !_cartItems[index].isSelected,
//       );
//     }
//   }
//
//   Future<void> removeFromCart(String foodItemId) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     _cartItems.removeWhere((item) => item.foodItem.id == foodItemId);
//   }
//
//   Future<void> clearCart() async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     _cartItems.clear();
//   }
// }