import 'package:equatable/equatable.dart';

class Item extends Equatable {
  const Item({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;

  @override
  List<Object?> get props => [id, name, category, description, imageUrl];
}
