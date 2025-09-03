// import '../../cart/models/food_item.dart';

import 'package:food_trans/home/models/food_category.dart';

import '../../home/models/food_item.dart';

class FoodDetailsRepository {
  Future<FoodItem> getFoodItem(String foodItemId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data based on the design
    return const FoodItem(
      id: 'burger_001',
      name: 'Burger With Meat',
      category: FoodCategory.burger,
      price: 12.230,
      rating: 4.5,
      distance: '190m',
      imageUrl: 'assets/images/burger_with_meat.jpg',
      isFavorite: false,
      deliveryTime: '20 - 30',
      description: 'Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.',
      isFreeDelivery: true,
    );
  }

  Future<List<FoodItem>> getRecommendedItems() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      FoodItem(
        id: 'burger_002',
        name: 'Ordinary Burgers',
        category: FoodCategory.burger,
        price: 17.230,
        rating: 4.9,
        distance: '190m',
        imageUrl: 'assets/images/ordinary_burger_1.jpg',
        isFavorite: false,
        deliveryTime: '15 - 25',
        description: 'Delicious ordinary burger',
        isFreeDelivery: true,
      ),
      FoodItem(
        id: 'burger_003',
        name: 'Ordinary Burgers',
        category: FoodCategory.burger,
        price: 17.230,
        rating: 4.9,
        distance: '190m',
        imageUrl: 'assets/images/ordinary_burger_2.jpg',
        isFavorite: false,
        deliveryTime: '15 - 25',
        description: 'Another delicious ordinary burger',
        isFreeDelivery: true,
      ),
    ];
  }

  Future<void> toggleFavorite(String foodItemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Simulate API call to toggle favorite status
  }
}