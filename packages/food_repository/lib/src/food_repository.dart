// repositories/food_repository.dart
// import 'package:food_delivery_app/home/home.dart';

import 'models/food_category.dart';
import 'models/food_item.dart';

class FoodRepository {
  Future<List<FoodItem>> getFoodItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const FoodItem(
        id: '1',
        name: 'Ordinary Burgers',
        category: 'Burger',
        price: 17230,
        rating: 4.9,
        distance: 190,
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      ),
      const FoodItem(
        id: '2',
        name: 'Burger With Meat',
        category: 'Burger',
        price: 17230,
        rating: 4.9,
        distance: 190,
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
      ),
      const FoodItem(
        id: '3',
        name: 'Veggie Burger',
        category: 'Burger',
        price: 15500,
        rating: 4.7,
        distance: 250,
        imageUrl: 'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=400&h=300&fit=crop',
      ),
      const FoodItem(
        id: '4',
        name: 'Double Cheese Burger',
        category: 'Burger',
        price: 19800,
        rating: 4.8,
        distance: 180,
        imageUrl: 'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=400&h=300&fit=crop',
      ),
    ];
  }

  Future<List<FoodCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      const FoodCategory(name: 'Burger', icon: '🍔', isSelected: true),
      const FoodCategory(name: 'Taco', icon: '🌮'),
      const FoodCategory(name: 'Drink', icon: '🥤'),
      const FoodCategory(name: 'Pizza', icon: '🍕'),
    ];
  }

  Future<String> getCurrentLocation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 'New York City';
  }
}