import 'models/item.dart';

class ItemsRepository {
  ItemsRepository();

  // In-memory mock data
  final List<Item> _items = const [
    Item(id: '1', name: 'Apple', category: 'Fruits', description: '', imageUrl: ''),
    Item(id: '2', name: 'Banana', category: 'Fruits', description: '', imageUrl: ''),
    Item(id: '3', name: 'Carrot', category: 'Vegetables', description: '', imageUrl: ''),
    Item(id: '4', name: 'Tomato', category: 'Vegetables', description: '', imageUrl: ''),
    Item(id: '5', name: 'Chicken', category: 'Meat', description: '', imageUrl: ''),
    Item(id: '6', name: 'Beef', category: 'Meat', description: '', imageUrl: ''),
  ];

  List<Item> getAllItems() => List.unmodifiable(_items);

  List<Item> getItemsByCategory(String category) {
    if (category == 'All') return getAllItems();
    return _items.where((item) => item.category == category).toList();
  }
}
