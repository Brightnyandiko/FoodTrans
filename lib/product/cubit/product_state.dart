// lib/product/cubit/product_state.dart
part of 'product_cubit.dart';

// import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> recommendedProducts;

  const ProductLoaded({
    required this.products,
    required this.recommendedProducts,
  });

  @override
  List<Object> get props => [products, recommendedProducts];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}