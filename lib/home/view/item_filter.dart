// lib/pages/item_filter_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/home/cubit/item_filter_cubit.dart';
import 'lib/';
import '../cubit/filter_state.dart';

class ItemFilterPage extends StatelessWidget {
  final List<String> categories = ['All', 'Fruits', 'Vegetables', 'Dairy'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemFilterCubit(_allItems),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item Filter'),
        ),
        body: Column(
          children: [
            _CategoryFilter(categories: categories),
            Expanded(child: _ItemList()),
          ],
        ),
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  final List<String> categories;

  const _CategoryFilter({required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: categories.map((category) {
              final isSelected = state.selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    context.read<FilterCubit>().selectCategory(category);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state.filteredItems.isEmpty) {
          return Center(child: Text('No items found.'));
        }

        return ListView.builder(
          itemCount: state.filteredItems.length,
          itemBuilder: (context, index) {
            final item = state.filteredItems[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.category),
            );
          },
        );
      },
    );
  }
}

