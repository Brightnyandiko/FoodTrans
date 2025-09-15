// // // import 'package:bloc/bloc.dart';
// // // import 'package:equatable/equatable.dart';
// // //
// // // import '../../home/models/food_item.dart';
// // //
// // //
// // // part 'food_details_state.dart';
// // //
// // // class FoodDetailsCubit extends Cubit<FoodDetailsState> {
// // //   FoodDetailsCubit() : super(const FoodDetailsState());
// // //
// // //   void loadFoodDetails(FoodItem selectedFood) {
// // //     emit(state.copyWith(status: FoodDetailsStatus.loading));
// // //
// // //     try {
// // //       final recommendedFoods = _getRecommendedFoods();
// // //
// // //       emit(
// // //         state.copyWith(
// // //           status: FoodDetailsStatus.success,
// // //           food: selectedFood,
// // //           recommendedFoods: recommendedFoods,
// // //         ),
// // //       );
// // //     } catch (error) {
// // //       emit(state.copyWith(status: FoodDetailsStatus.failure));
// // //     }
// // //   }
// // //
// // //   void incrementQuantity() {
// // //     if (state.quantity < 99) {
// // //       emit(state.copyWith(quantity: state.quantity + 1));
// // //     }
// // //   }
// // //
// // //   void decrementQuantity() {
// // //     if (state.quantity > 1) {
// // //       emit(state.copyWith(quantity: state.quantity - 1));
// // //     }
// // //   }
// // //
// // //   void toggleFavorite() {
// // //     if (state.food != null) {
// // //       final updatedFood = state.food!.copyWith(
// // //         isFavorite: !state.food!.isFavorite,
// // //       );
// // //       emit(state.copyWith(food: updatedFood));
// // //     }
// // //   }
// // //
// // //   void addToCart() {
// // //     // Implementation for adding to cart
// // //     // This would typically call a repository or service
// // //     print('Added ${state.quantity} ${state.food?.name} to cart');
// // //   }
// // //
// // //   List<FoodItem> _getRecommendedFoods() {
// // //     return [
// // //       const FoodItem(
// // //         id: 'rec1',
// // //         name: 'Chicken Burger',
// // //         price: 15000,
// // //         imageUrl: 'assets/images/chicken_burger.jpg',
// // //         rating: 4.8,
// // //         distance: 150,
// // //         deliveryTime: '15-25',
// // //         description: 'Delicious chicken burger with fresh ingredients', category: '',
// // //       ),
// // //       const FoodItem(
// // //         id: 'rec2',
// // //         name: 'Beef Burger',
// // //         price: 18000,
// // //         imageUrl: 'assets/images/beef_burger.jpg',
// // //         rating: 4.7,
// // //         distance: 200,
// // //         deliveryTime: '20-30',
// // //         description: 'Premium beef burger with special sauce', category: '',
// // //       ),
// // //     ];
// // //   }
// // // }
// //
// // import 'package:bloc/bloc.dart';
// // import 'package:equatable/equatable.dart';
// // import 'package:food_trans/home/models/food_item.dart';
// //
// // import '../repository/food_repository_impl.dart';
// // // import '../models/food.dart';
// // // import '../repository/food_repository.dart';
// //
// // part 'food_details_state.dart';
// //
// // class FoodDetailsCubit extends Cubit<FoodDetailsState> {
// //   FoodDetailsCubit({
// //     required FoodRepository foodRepository,
// //   }) : _foodRepository = foodRepository,
// //         super(const FoodDetailsState());
// //
// //   final FoodRepository _foodRepository;
// //
// //   void loadFoodDetails(FoodItem selectedFood) {
// //     emit(state.copyWith(status: FoodDetailsStatus.loading));
// //
// //     try {
// //       final recommendedFoods = _getRecommendedFoods(selectedFood);
// //
// //       emit(
// //         state.copyWith(
// //           status: FoodDetailsStatus.success,
// //           food: selectedFood,
// //           recommendedFoods: recommendedFoods,
// //         ),
// //       );
// //     } catch (error) {
// //       emit(state.copyWith(status: FoodDetailsStatus.failure));
// //     }
// //   }
// //
// //   void incrementQuantity() {
// //     if (state.quantity < 99) {
// //       emit(state.copyWith(quantity: state.quantity + 1));
// //     }
// //   }
// //
// //   void decrementQuantity() {
// //     if (state.quantity > 1) {
// //       emit(state.copyWith(quantity: state.quantity - 1));
// //     }
// //   }
// //
// //   void toggleFavorite() {
// //     if (state.food != null) {
// //       final updatedFood = state.food!.copyWith(
// //         isFavorite: !state.food!.isFavorite,
// //       );
// //       emit(state.copyWith(food: updatedFood));
// //     }
// //   }
// //
// //   void addToCart() {
// //     // Implementation for adding to cart
// //     print('Added ${state.quantity} ${state.food?.name} to cart');
// //   }
// //
// //   List<FoodItem> _getRecommendedFoods(FoodItem selectedFood) {
// //     // Get all foods from the same category as the selected food
// //     final categoryFoods = _foodRepository.getFoodsByCategory(selectedFood.category);
// //
// //     // Filter out the currently selected food item
// //     final recommendedFoods = categoryFoods
// //         .where((food) => food.id != selectedFood.id)
// //         .take(4) // Limit to 4 recommendations for better UI
// //         .toList();
// //
// //     // If we don't have enough items in the same category,
// //     // we can add items from other categories (optional)
// //     if (recommendedFoods.length < 2) {
// //       final allFoods = _foodRepository.getAllFoods();
// //       final additionalFoods = allFoods
// //           .where((food) =>
// //       food.id != selectedFood.id &&
// //           !recommendedFoods.contains(food))
// //           .take(4 - recommendedFoods.length)
// //           .toList();
// //
// //       recommendedFoods.addAll(additionalFoods);
// //     }
// //
// //     return recommendedFoods;
// //   }
// // }
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../home/models/food_item.dart';
// import '../repository/food_details_repository.dart';
//
// // import '../../cart/models/food_item.dart';
// // import '../repository/food_details_repository.dart';
//
// part 'food_details_state.dart';
//
// class FoodDetailsCubit extends Cubit<FoodDetailsState> {
//   FoodDetailsCubit({required FoodDetailsRepository foodDetailsRepository})
//       : _foodDetailsRepository = foodDetailsRepository,
//         super(FoodDetailsInitial());
//
//   final FoodDetailsRepository _foodDetailsRepository;
//
//   Future<void> loadFoodDetails(String foodItemId) async {
//     try {
//       emit(FoodDetailsLoading());
//       final foodItem = await _foodDetailsRepository.getFoodItem(foodItemId);
//       final recommendedItems = await _foodDetailsRepository.getRecommendedItems();
//
//       emit(FoodDetailsLoaded(
//         foodItem: foodItem,
//         recommendedItems: recommendedItems,
//         quantity: 1,
//         isFavorite: foodItem.isFavorite,
//       ));
//     } catch (error) {
//       emit(FoodDetailsError(error.toString()));
//     }
//   }
//
//   void increaseQuantity() {
//     final currentState = state;
//     if (currentState is FoodDetailsLoaded) {
//       emit(currentState.copyWith(quantity: currentState.quantity + 1));
//     }
//   }
//
//   void decreaseQuantity() {
//     final currentState = state;
//     if (currentState is FoodDetailsLoaded && currentState.quantity > 1) {
//       emit(currentState.copyWith(quantity: currentState.quantity - 1));
//     }
//   }
//
//   void toggleFavorite() {
//     final currentState = state;
//     if (currentState is FoodDetailsLoaded) {
//       emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
//       _foodDetailsRepository.toggleFavorite(currentState.foodItem.id);
//     }
//   }
//
//   void addToCartCompleted() {
//     if (state is FoodDetailsLoaded) {
//       emit(state); // Re-emit the same state to trigger listener
//     }
//   }
// }