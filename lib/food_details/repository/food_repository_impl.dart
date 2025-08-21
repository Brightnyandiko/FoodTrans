// import '../models/food.dart';



// food_repository_impl.dart
import '../../home/models/food_category.dart';
import '../../home/models/food_item.dart';

abstract class FoodRepository {
  List<FoodItem> getAllFoods();
  List<FoodItem> getFoodsByCategory(FoodCategory category);
  FoodItem? getFoodById(String id);
}

class FoodRepositoryImpl implements FoodRepository {
  // Create static category instances
  static const _burgerCategory = FoodCategory(name: 'Burger', icon: '🍔');
  static const _tacoCategory = FoodCategory(name: 'Taco', icon: '🌮');
  static const _pizzaCategory = FoodCategory(name: 'Pizza', icon: '🍕');
  static const _drinkCategory = FoodCategory(name: 'Drink', icon: '🥤');

  final List<FoodItem> _allFoods = [
    // Burger Category - Use actual FoodCategory objects
    FoodItem(
      id: '1',
      name: 'Ordinary Burgers',
      price: 17230,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.9,
      distance: 190,
      deliveryTime: '20-30',
      description: 'Classic burger with fresh ingredients and special sauce',
      category: _burgerCategory, // Use FoodCategory object, not string
    ),
    FoodItem(
      id: '2',
      name: 'Burger With Meat',
      price: 17230,
      imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.9,
      distance: 190,
      deliveryTime: '20-30',
      description: 'Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.',
      category: _burgerCategory,
    ),
    FoodItem(
      id: '3',
      name: 'Cheese Burger',
      price: 15500,
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.7,
      distance: 200,
      deliveryTime: '15-25',
      description: 'Delicious cheese burger with melted cheese and fresh lettuce',
      category: _burgerCategory,
    ),
    FoodItem(
      id: '4',
      name: 'Double Burger',
      price: 22000,
      imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.8,
      distance: 180,
      deliveryTime: '25-35',
      description: 'Double patty burger with extra cheese and bacon',
      category: _burgerCategory,
    ),

    // Taco Category
    FoodItem(
      id: '5',
      name: 'Chicken Taco',
      price: 12000,
      imageUrl: 'https://images.unsplash.com/photo-1565299585323-38174c28d2c9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.6,
      distance: 150,
      deliveryTime: '15-20',
      description: 'Grilled chicken taco with fresh vegetables and spicy sauce',
      category: _tacoCategory,
    ),
    FoodItem(
      id: '6',
      name: 'Beef Taco',
      price: 14000,
      imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.7,
      distance: 170,
      deliveryTime: '20-25',
      description: 'Seasoned beef taco with authentic Mexican flavors',
      category: _tacoCategory,
    ),

    // Pizza Category
    FoodItem(
      id: '7',
      name: 'Margherita Pizza',
      price: 25000,
      imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.8,
      distance: 220,
      deliveryTime: '30-40',
      description: 'Classic Italian pizza with fresh mozzarella and basil',
      category: _pizzaCategory,
    ),
    FoodItem(
      id: '8',
      name: 'Pepperoni Pizza',
      price: 28000,
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.9,
      distance: 220,
      deliveryTime: '30-40',
      description: 'Pepperoni pizza with extra cheese and crispy crust',
      category: _pizzaCategory,
    ),

    // Drink Category
    FoodItem(
      id: '9',
      name: 'Coca Cola',
      price: 5000,
      imageUrl: 'https://images.unsplash.com/photo-1581636625402-29d2d092e8b0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.5,
      distance: 100,
      deliveryTime: '5-10',
      description: 'Refreshing Coca Cola to complement your meal',
      category: _drinkCategory,
    ),
    FoodItem(
      id: '10',
      name: 'Orange Juice',
      price: 8000,
      imageUrl: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      rating: 4.4,
      distance: 120,
      deliveryTime: '5-10',
      description: 'Fresh orange juice made from premium oranges',
      category: _drinkCategory,
    ),
  ];

  @override
  List<FoodItem> getAllFoods() {
    return List.from(_allFoods);
  }

  @override
  List<FoodItem> getFoodsByCategory(FoodCategory category) {
    return _allFoods.where((food) => food.category == category).toList();
  }

  @override
  FoodItem? getFoodById(String id) {
    try {
      return _allFoods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }
}