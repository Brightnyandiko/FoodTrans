import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import 'item_filter_state.dart';

class ItemFilterCubit extends Cubit<ItemFilterState> {
  ItemFilterCubit(this._itemsRepository) : super(const ItemFilterState());

  final ItemsRepository _itemsRepository;

  /// Loads all items from repository into state.
  Future<void> loadItems() async {
    emit(state.copyWith(status: ItemFilterStatus.loading));
    try {
      final items = _itemsRepository.getAllItems();
      emit(state.copyWith(items: items, status: ItemFilterStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ItemFilterStatus.failure));
    }
  }

  /// Change selected category.
  void selectCategory(String category) {
    // If selecting the same category, no-op.
    if (category == state.selectedCategory) return;
    emit(state.copyWith(selectedCategory: category));
  }

  /// Convenience getter for the items filtered by selectedCategory.
  List<Item> get filteredItems {
    if (state.selectedCategory == 'All') return state.items;
    return state.items
        .where((item) => item.category == state.selectedCategory)
        .toList();
  }
}


