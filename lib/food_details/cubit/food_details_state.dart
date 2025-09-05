// // part of 'food_details_cubit.dart';
// //
// // enum FoodDetailsStatus { initial, loading, success, failure }
// //
// // final class FoodDetailsState extends Equatable {
// //   const FoodDetailsState({
// //     this.status = FoodDetailsStatus.initial,
// //     this.food,
// //     this.quantity = 1,
// //     this.recommendedFoods = const <FoodItem>[],
// //   });
// //
// //   final FoodDetailsStatus status;
// //   final FoodItem? food;
// //   final int quantity;
// //   final List<FoodItem> recommendedFoods;
// //
// //   FoodDetailsState copyWith({
// //     FoodDetailsStatus? status,
// //     FoodItem? food,
// //     int? quantity,
// //     List<FoodItem>? recommendedFoods,
// //   }) {
// //     return FoodDetailsState(
// //       status: status ?? this.status,
// //       food: food ?? this.food,
// //       quantity: quantity ?? this.quantity,
// //       recommendedFoods: recommendedFoods ?? this.recommendedFoods,
// //     );
// //   }
// //
// //   @override
// //   List<Object?> get props => [status, food, quantity, recommendedFoods];
// // }
//
// part of 'food_details_cubit.dart';
//
// abstract class FoodDetailsState extends Equatable {
//   const FoodDetailsState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class FoodDetailsInitial extends FoodDetailsState {}
//
// class FoodDetailsLoading extends FoodDetailsState {}
//
// class FoodDetailsLoaded extends FoodDetailsState {
//   const FoodDetailsLoaded({
//     required this.foodItem,
//     required this.recommendedItems,
//     required this.quantity,
//     required this.isFavorite,
//   });
//
//   final FoodItem foodItem;
//   final List<FoodItem> recommendedItems;
//   final int quantity;
//   final bool isFavorite;
//
//   FoodDetailsLoaded copyWith({
//     FoodItem? foodItem,
//     List<FoodItem>? recommendedItems,
//     int? quantity,
//     bool? isFavorite,
//   }) {
//     return FoodDetailsLoaded(
//       foodItem: foodItem ?? this.foodItem,
//       recommendedItems: recommendedItems ?? this.recommendedItems,
//       quantity: quantity ?? this.quantity,
//       isFavorite: isFavorite ?? this.isFavorite,
//     );
//   }
//
//   @override
//   List<Object> get props => [foodItem, recommendedItems, quantity, isFavorite];
// }
//
// class FoodDetailsError extends FoodDetailsState {
//   const FoodDetailsError(this.message);
//
//   final String message;
//
//   @override
//   List<Object> get props => [message];
// }
//
// class FoodDetailsAddedToCart extends FoodDetailsState {
//   const FoodDetailsAddedToCart();
// }