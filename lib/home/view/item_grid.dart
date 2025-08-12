import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';

class ItemGrid extends StatelessWidget {
  const ItemGrid({super.key, required this.items});
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // finite cross axis count
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          clipBehavior: Clip.hardEdge,
          child: Center(
            child: Text(item.name),
          ),
        );
      },
    );
  }
}
