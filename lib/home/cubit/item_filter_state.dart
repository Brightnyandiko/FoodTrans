import 'package:equatable/equatable.dart';
import 'package:items_repository/items_repository.dart';

enum ItemFilterStatus { initial, loading, success, failure }

class ItemFilterState extends Equatable {
  const ItemFilterState({
    this.selectedCategory = 'All',
    this.items = const [],
    this.status = ItemFilterStatus.initial,
  });

  final String selectedCategory;
  final List<Item> items;
  final ItemFilterStatus status;

  ItemFilterState copyWith({
    String? selectedCategory,
    List<Item>? items,
    ItemFilterStatus? status,
  }) {
    return ItemFilterState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [selectedCategory, items, status];
}




