// models/food_item.dart
import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int distance;
  final String imageUrl;
  final bool isFavorite;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.isFavorite = false,
  });

  FoodItem copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    double? rating,
    int? distance,
    String? imageUrl,
    bool? isFavorite,
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
  ];
}