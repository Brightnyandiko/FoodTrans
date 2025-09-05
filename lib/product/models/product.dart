// lib/product/models/product.dart
import 'package:equatable/equatable.dart';
import 'package:food_trans/home/models/food_category.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final int deliveryTime;
  final String description;
  final bool isFavorite;
  final bool isFreeDelivery;
  final FoodCategory foodCategory;
  final String distance;



  const Product({
    required this.id,
    required this.name,
    required this.foodCategory,
    required this.price,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.isFavorite = false,
    required this.deliveryTime,
    required this.description,
    this.isFreeDelivery = true,
  });

  Product copyWith({
    String? id,
    String? name,
    FoodCategory? foodCategory,
    double? price,
    double? rating,
    String? distance,
    String? imageUrl,
    bool? isFavorite,
    int? deliveryTime,
    String? description,
    bool? isFreeDelivery,
  }) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        foodCategory: foodCategory ?? this.foodCategory,
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
  List<Object> get props => [id, name, price, imageUrl, rating, deliveryTime, description];
}