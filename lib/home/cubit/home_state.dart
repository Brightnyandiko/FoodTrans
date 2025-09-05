// cubit/home_state.dart
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> product;
  final List<FoodCategory> categories;
  final String location;

  const HomeLoaded({
    required this.product,
    required this.categories,
    required this.location,
  });

  HomeLoaded copyWith({
    List<Product>? product,
    List<FoodCategory>? categories,
    String? location,
  }) {
    return HomeLoaded(
      product: product ?? this.product,
      categories: categories ?? this.categories,
      location: location ?? this.location,
    );
  }

  @override
  List<Object> get props => [product, categories, location];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}