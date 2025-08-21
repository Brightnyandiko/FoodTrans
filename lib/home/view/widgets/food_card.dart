// widgets/food_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/home/models/food_category.dart';
import 'package:food_trans/home/models/food_item.dart';

import '../../../food_details/view/food_details_page.dart';
import '../../cubit/home_cubit.dart';
// import '../../models/food_item.dart';
// import '../models/food_item.dart';
// import '../cubit/home_cubit.dart';

// Alternative FoodCard with overflow protection
class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // In your homepage grid item onTap
      onTap: () {
        final selectedFood = FoodItem(
          id: '1',
          name: 'Burger With Meat',
          price: 12230,
          imageUrl: 'assets/images/burger_meat.jpg',
          rating: 4.5,
          distance: 190,
          deliveryTime: '20-30',
          description: 'Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.',
          category: FoodCategory.burger,
        );

        Navigator.of(context).push(FoodDetailsPage.route(selectedFood));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                SizedBox(
                  height: constraints.maxHeight * 0.6, // 60% of available height
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            foodItem.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.fastfood,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            context.read<HomeCubit>().toggleFavorite(foodItem.id);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(
                              foodItem.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: foodItem.isFavorite
                                  ? Colors.red
                                  : Colors.grey.shade600,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          foodItem.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange.shade600,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              foodItem.rating.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.location_on,
                              color: Colors.orange.shade600,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${foodItem.distance}m',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '\$ ${foodItem.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}