// cubit/home_cubit.dart (Updated with network images)
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/product/models/models.dart';
import 'package:geolocator/geolocator.dart';
import '../models/food_item.dart';
import '../models/food_category.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadData() async {
    emit(HomeLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final location = await _getCurrentLocation();
      final categories = _getCategories();
      final product = _getProduct();

      emit(HomeLoaded(
        product: product,
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
      final updatedItems = currentState.product.map((item) {
        if (item.id == itemId) {
          return item.copyWith(isFavorite: !item.isFavorite);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(product: updatedItems));
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

  List<Product> _getProduct() {
    return [
      const Product(
        id: '1',
        name: 'Ordinary Burgers',
        foodCategory: FoodCategory.burger,
        price: 17230,
        rating: 4.9,
        distance: '190',
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=fill',
        deliveryTime: 20-30,
        description: '',
      ),
      const Product(
        id: '2',
        name: 'Burger With Meat',
        foodCategory: FoodCategory.burger,
        price: 17230,
        rating: 4.9,
        distance: '190m',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
        deliveryTime: 20-30,
        description: '',
      ),
      const Product(
        id: '3',
        name: 'Veggie Burger',
        foodCategory: FoodCategory.burger,
        price: 15500,
        rating: 4.7,
        distance: '250m',
        imageUrl: 'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=400&h=300&fit=crop',
        deliveryTime: 20-30,
        description: '',
      ),
      const Product(
        id: '4',
        name: 'Double Cheese Burger',
        foodCategory: FoodCategory.burger,
        price: 19800,
        rating: 4.8,
        distance: '180m',
        imageUrl: 'https://unsplash.com/photos/burger-with-lettuce-and-cheese-73_obA0IB_0?w=400&h=300&fit=crop',
        deliveryTime: 20-30,
        description: '',
      ),
    ];
  }
}