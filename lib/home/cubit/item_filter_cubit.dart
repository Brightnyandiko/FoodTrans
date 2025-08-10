// lib/cubit/filter_cubit.dart
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import '../models/item.dart';
// import 'filter_state.dart';

part 'item_filter_state.dart';

class ItemFilterCubit extends Cubit<ItemFilterState> {
  ItemFilterCubit() : super(ItemFilterState(
    allItems: _mockItems,
    filteredItems: _mockItems,
    selectedCategory: 'All',
  ));

  static final List<Item> _mockItems = [
    Item(name: 'Apple', category: 'Fruits', id: '1', description: '', imageUrl: ''),
    Item(name: 'Banana', category: 'Fruits', id: '2', description: '', imageUrl: ''),
    Item(name: 'Carrot', category: 'Vegetables', id: '3', description: '', imageUrl: ''),
    Item(name: 'Tomato', category: 'Vegetables', id: '4', description: '', imageUrl: ''),
    Item(name: 'Milk', category: 'Dairy', id: '5', description: '', imageUrl: ''),
    Item(name: 'Cheese', category: 'Dairy', id: '6', description: '', imageUrl: ''),
  ];

  void selectCategory(String category) {
    if (category == 'All') {
      emit(state.copyWith(
        selectedCategory: category,
        filteredItems: state.allItems,
      ));
    } else {
      final filtered = state.allItems
          .where((item) => item.category == category)
          .toList();

      emit(state.copyWith(
        selectedCategory: category,
        filteredItems: filtered,
      ));
    }
  }
}
