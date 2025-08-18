// models/food_category.dart
import 'package:equatable/equatable.dart';

class FoodCategory extends Equatable {
  final String name;
  final String icon;
  final bool isSelected;

  const FoodCategory({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  FoodCategory copyWith({
    String? name,
    String? icon,
    bool? isSelected,
  }) {
    return FoodCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [name, icon, isSelected];
}