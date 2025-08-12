import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';

import '../cubit/item_filter_cubit.dart';
import '../cubit/item_filter_state.dart';
import 'filter_bar.dart';
import 'item_grid.dart';

class ItemFilterView extends StatelessWidget {
  const ItemFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Defensive: LayoutBuilder gives finite maxHeight/maxWidth in typical uses.
          return BlocBuilder<ItemFilterCubit, ItemFilterState>(
            builder: (context, state) {
              if (state.status == ItemFilterStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == ItemFilterStatus.failure) {
                return const Center(child: Text('Failed to load items'));
              }

              // Build categories from loaded items; keep 'All' first.
              final categorySet = <String>{};
              for (final i in state.items) {
                categorySet.add(i.category);
              }
              final categories = ['All', ...categorySet];

              return Column(
                children: [
                  // Filter bar has finite height — avoids ListView vertical unbounded error.
                  FilterBar(
                    categories: categories,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (cat) =>
                        context.read<ItemFilterCubit>().selectCategory(cat),
                  ),

                  // Expanded ensures ItemGrid has bounded height for its GridView.
                  Expanded(
                    child:
                    ItemGrid(items: context.read<ItemFilterCubit>().filteredItems),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}











