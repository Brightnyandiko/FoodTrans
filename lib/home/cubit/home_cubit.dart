// cubit/home_cubit.dart (Updated with network images)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import '../models/food_item.dart';
import '../models/food_category.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadData() async {
    emit(HomeLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final location = await _getCurrentLocation();
      final categories = _getCategories();
      final foodItems = _getFoodItems();

      emit(HomeLoaded(
        foodItems: foodItems,
        categories: categories,
        location: location,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void toggleFavorite(String itemId) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedItems = currentState.foodItems.map((item) {
        if (item.id == itemId) {
          return item.copyWith(isFavorite: !item.isFavorite);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(foodItems: updatedItems));
    }
  }

  void selectCategory(String categoryName) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedCategories = currentState.categories.map((category) {
        return category.copyWith(
          isSelected: category.name == categoryName,
        );
      }).toList();

      emit(currentState.copyWith(categories: updatedCategories));
    }
  }

  Future<String> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'New York City';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'New York City';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return 'New York City';
      }

      return 'New York City';
    } catch (e) {
      return 'New York City';
    }
  }

  List<FoodCategory> _getCategories() {
    return [
      const FoodCategory(name: 'Burger', icon: '🍔', isSelected: true),
      const FoodCategory(name: 'Taco', icon: '🌮'),
      const FoodCategory(name: 'Drink', icon: '🥤'),
      const FoodCategory(name: 'Pizza', icon: '🍕'),
    ];
  }

  List<FoodItem> _getFoodItems() {
    return [
      const FoodItem(
        id: '1',
        name: 'Ordinary Burgers',
        category: 'Burger',
        price: 17230,
        rating: 4.9,
        distance: 190,
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=fill',
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
}