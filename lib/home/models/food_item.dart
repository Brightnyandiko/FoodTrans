// models/food_item.dart
import 'package:equatable/equatable.dart';
import 'package:food_trans/home/models/food_category.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final FoodCategory category;
  final double price;
  final double rating;
  final int distance;
  final String imageUrl;
  final bool isFavorite;
  final String deliveryTime;
  final String description;
  final bool isFreeDelivery;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.isFavorite = false,
    required this.deliveryTime,
    required this.description,
    this.isFreeDelivery = true,

  });

  FoodItem copyWith({
    String? id,
    String? name,
    FoodCategory? category,
    double? price,
    double? rating,
    int? distance,
    String? imageUrl,
    bool? isFavorite,
    String? deliveryTime,
    String? description,
    bool? isFreeDelivery,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      description: description ?? this.description,
      isFreeDelivery: isFreeDelivery ?? this.isFreeDelivery
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    price,
    rating,
    distance,
    imageUrl,
    isFavorite,
    deliveryTime,
    description,
    isFreeDelivery
  ];
}