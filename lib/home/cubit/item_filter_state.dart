part of'item_filter_cubit.dart';

// lib/cubit/filter_state.dart
// import 'package:equatable/equatable.dart';
// import '../models/item.dart';

// lib/cubit/filter_state.dart

class ItemFilterState extends Equatable {
  final List<Item>? allItems;
  final List<Item>? filteredItems;
  final String selectedCategory;

  const ItemFilterState({
    required this.allItems,
    required this.filteredItems,
    required this.selectedCategory,
  });

  ItemFilterState copyWith({
    List<Item>? allItems,
    List<Item>? filteredItems,
    String? selectedCategory,
  }) {
    return ItemFilterState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [allItems, filteredItems, selectedCategory];
}


