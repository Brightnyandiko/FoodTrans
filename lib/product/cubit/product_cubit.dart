// lib/product/cubit/product_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_trans/home/models/food_category.dart';
import '../models/models.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductInitial()) {
    _loadProducts();
  }

  void _loadProducts() {
    emit(const ProductLoading());

    // Simulate loading products
    final products = [
      const Product(
        id: '1',
        name: 'Burger With Meat',
        price: 12230,
        imageUrl: 'https://example.com/burger1.jpg',
        rating: 4.5,
        deliveryTime: 25,
        description: 'Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.',
        foodCategory: FoodCategory.burger,
        distance: '',
      ),
    ];

    final recommendedProducts = [
      const Product(
        id: '2',
        name: 'Ordinary Burgers',
        price: 17230,
        imageUrl: 'https://example.com/burger2.jpg',
        rating: 4.9,
        deliveryTime: 20,
        description: 'Delicious ordinary burger with fresh ingredients.',
        foodCategory: FoodCategory.burger,
        distance: '',
      ),
      const Product(
        id: '3',
        name: 'Ordinary Burgers',
        price: 17230,
        imageUrl: 'https://example.com/burger3.jpg',
        rating: 4.9,
        deliveryTime: 20,
        description: 'Another delicious ordinary burger.',
        foodCategory: FoodCategory.burger,
        distance: '',
      ),
    ];

    emit(ProductLoaded(
      products: products,
      recommendedProducts: recommendedProducts,
    ));
  }
}