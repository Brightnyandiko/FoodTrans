// widgets/food_grid.dart
import 'package:flutter/material.dart';
// import '../models/food_item.dart';
// import '../../models/food_item.dart';
import '../home/models/food_item.dart';
import 'food_card.dart';

class FoodGrid extends StatelessWidget {
  final List<FoodItem> foodItems;

  const FoodGrid({super.key, required this.foodItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8, // Adjusted for better proportions
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return FoodCard(foodItem: foodItems[index]);
        },
      ),
    );
  }
}