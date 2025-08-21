part of 'food_details_cubit.dart';

enum FoodDetailsStatus { initial, loading, success, failure }

final class FoodDetailsState extends Equatable {
  const FoodDetailsState({
    this.status = FoodDetailsStatus.initial,
    this.food,
    this.quantity = 1,
    this.recommendedFoods = const <FoodItem>[],
  });

  final FoodDetailsStatus status;
  final FoodItem? food;
  final int quantity;
  final List<FoodItem> recommendedFoods;

  FoodDetailsState copyWith({
    FoodDetailsStatus? status,
    FoodItem? food,
    int? quantity,
    List<FoodItem>? recommendedFoods,
  }) {
    return FoodDetailsState(
      status: status ?? this.status,
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
      recommendedFoods: recommendedFoods ?? this.recommendedFoods,
    );
  }

  @override
  List<Object?> get props => [status, food, quantity, recommendedFoods];
}