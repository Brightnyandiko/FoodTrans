// cubit/home_state.dart
import 'package:equatable/equatable.dart';
import '../models/food_item.dart';
import '../models/food_category.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<FoodItem> foodItems;
  final List<FoodCategory> categories;
  final String location;

  const HomeLoaded({
    required this.foodItems,
    required this.categories,
    required this.location,
  });

  HomeLoaded copyWith({
    List<FoodItem>? foodItems,
    List<FoodCategory>? categories,
    String? location,
  }) {
    return HomeLoaded(
      foodItems: foodItems ?? this.foodItems,
      categories: categories ?? this.categories,
      location: location ?? this.location,
    );
  }

  @override
  List<Object> get props => [foodItems, categories, location];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}