import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/food_details/repository/food_repository_impl.dart';
import '../../home/models/food_item.dart';
import '../cubit/food_details_cubit.dart';
import 'food_details_view.dart';
// import '../models/food.dart';
// import 'food_details_view.dart';

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({super.key, required this.food});

  final FoodItem food;

  static Route<void> route(FoodItem food) {
    return MaterialPageRoute<void>(
      builder: (_) => FoodDetailsPage(food: food),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodDetailsCubit(foodRepository: FoodRepositoryImpl())..loadFoodDetails(food),
      child: const FoodDetailsView(),
    );
  }
}