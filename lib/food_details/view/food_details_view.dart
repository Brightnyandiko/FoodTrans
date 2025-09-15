// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:food_trans/cart/view/cart_page.dart';
// // // import 'package:food_repository/food_repository.dart';
// // import '../../checkout/view/cart_page.dart';
// // import '../../home/models/food_item.dart';
// // import '../cubit/food_details_cubit.dart';
// // // import '../models/food.dart';
// //
// // class FoodDetailsView extends StatelessWidget {
// //   const FoodDetailsView({super.key});
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
// //         builder: (context, state) {
// //           if (state.status == FoodDetailsStatus.loading) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (state.status == FoodDetailsStatus.failure) {
// //             return const Center(
// //               child: Text('Failed to load food details'),
// //             );
// //           }
// //
// //           if (state.food == null) {
// //             return const Center(
// //               child: Text('No food data available'),
// //             );
// //           }
// //
// //           return Column(
// //             children: [
// //               Expanded(
// //                 child: CustomScrollView(
// //                   slivers: [
// //                     _HeroImageSection(food: state.food!),
// //                     SliverToBoxAdapter(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(16),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             _FoodInfoSection(food: state.food!),
// //                             const SizedBox(height: 24),
// //                             _DescriptionSection(food: state.food!),
// //                             const SizedBox(height: 24),
// //                             _RecommendedSection(
// //                               recommendedFoods: state.recommendedFoods,
// //                             ),
// //                             const SizedBox(height: 100), // Bottom padding
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               _BottomSection(quantity: state.quantity),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // class _HeroImageSection extends StatelessWidget {
// //   const _HeroImageSection({required this.food});
// //
// //   final FoodItem food;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SliverAppBar(
// //       expandedHeight: 300,
// //       pinned: true,
// //       backgroundColor: Colors.transparent,
// //       leading: Container(
// //         margin: const EdgeInsets.all(8),
// //         decoration: BoxDecoration(
// //           color: Colors.black.withOpacity(0.3),
// //           shape: BoxShape.circle,
// //         ),
// //         child: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.of(context).pop(),
// //         ),
// //       ),
// //       actions: [
// //         Container(
// //           margin: const EdgeInsets.all(8),
// //           decoration: BoxDecoration(
// //             color: Colors.black.withOpacity(0.3),
// //             shape: BoxShape.circle,
// //           ),
// //           child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
// //             builder: (context, state) {
// //               return IconButton(
// //                 icon: Icon(
// //                   state.food?.isFavorite == true
// //                       ? Icons.favorite
// //                       : Icons.favorite_border,
// //                   color: state.food?.isFavorite == true
// //                       ? Colors.red
// //                       : Colors.white,
// //                 ),
// //                 onPressed: () {
// //                   context.read<FoodDetailsCubit>().toggleFavorite();
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //         Container(
// //             margin: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //               color: Colors.black.withOpacity(0.3),
// //               shape: BoxShape.circle
// //             ),
// //           child: IconButton(
// //               onPressed: () {
// //                 Navigator.push(context, MaterialPageRoute(
// //                     builder: (context) => CheckoutPage(),
// //                   ), // Your route
// //                 );
// //               }, icon: Icon(Icons.shopping_cart, color: Colors.white,)
// //           ),
// //         )
// //       ],
// //       flexibleSpace: FlexibleSpaceBar(
// //         background: Stack(
// //           fit: StackFit.expand,
// //           children: [
// //             // Updated to use network image with error handling
// //             Image.network(
// //               food.imageUrl,
// //               fit: BoxFit.cover,
// //               loadingBuilder: (context, child, loadingProgress) {
// //                 if (loadingProgress == null) return child;
// //                 return Center(
// //                   child: CircularProgressIndicator(
// //                     value: loadingProgress.expectedTotalBytes != null
// //                         ? loadingProgress.cumulativeBytesLoaded /
// //                         loadingProgress.expectedTotalBytes!
// //                         : null,
// //                   ),
// //                 );
// //               },
// //               errorBuilder: (context, error, stackTrace) {
// //                 return Container(
// //                   color: Colors.grey[300],
// //                   child: const Center(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(Icons.error, size: 50, color: Colors.grey),
// //                         SizedBox(height: 8),
// //                         Text('Failed to load image'),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //             Container(
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   colors: [
// //                     Colors.transparent,
// //                     Colors.black.withOpacity(0.3),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const Positioned(
// //               bottom: 20,
// //               left: 20,
// //               child: Text(
// //                 'About This Menu',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _FoodInfoSection extends StatelessWidget {
// //   const _FoodInfoSection({required this.food});
// //
// //   final FoodItem food;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           children: [
// //             Expanded(
// //               child: Text(
// //                 food.name,
// //                 style: const TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //             ),
// //             const Text(
// //               '🍔',
// //               style: TextStyle(fontSize: 24),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 8),
// //         Text(
// //           '\$${food.price.toStringAsFixed(0)}',
// //           style: const TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.orange,
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         Row(
// //           children: [
// //             _InfoChip(
// //               icon: Icons.attach_money,
// //               text: food.isFreeDelivery ? 'Free Delivery' : 'Paid Delivery',
// //               color: Colors.orange,
// //             ),
// //             const SizedBox(width: 16),
// //             _InfoChip(
// //               icon: Icons.access_time,
// //               text: food.deliveryTime,
// //               color: Colors.orange,
// //             ),
// //             const SizedBox(width: 16),
// //             _InfoChip(
// //               icon: Icons.star,
// //               text: food.rating.toString(),
// //               color: Colors.orange,
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _InfoChip extends StatelessWidget {
// //   const _InfoChip({
// //     required this.icon,
// //     required this.text,
// //     required this.color,
// //   });
// //
// //   final IconData icon;
// //   final String text;
// //   final Color color;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 16, color: color),
// //         const SizedBox(width: 4),
// //         Text(
// //           text,
// //           style: TextStyle(
// //             fontSize: 14,
// //             color: Colors.grey[600],
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _DescriptionSection extends StatelessWidget {
// //   const _DescriptionSection({required this.food});
// //
// //   final FoodItem food;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Description',
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.black,
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         Text(
// //           food.description,
// //           style: TextStyle(
// //             fontSize: 14,
// //             color: Colors.grey[600],
// //             height: 1.5,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _RecommendedSection extends StatelessWidget {
// //   const _RecommendedSection({required this.recommendedFoods});
// //
// //   final List<FoodItem> recommendedFoods;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Text(
// //               'Recommended For You',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //               ),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 // Navigate to see all recommended
// //               },
// //               child: const Text(
// //                 'See All',
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.orange,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         SizedBox(
// //           height: 120,
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: recommendedFoods.length,
// //             itemBuilder: (context, index) {
// //               return Container(
// //                 width: 200,
// //                 margin: const EdgeInsets.only(right: 12),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   color: Colors.grey[300],
// //                 ),
// //                 child: ClipRRect(
// //                   borderRadius: BorderRadius.circular(12),
// //                   child: Image.network(
// //                     recommendedFoods[index].imageUrl,
// //                     fit: BoxFit.cover,
// //                     loadingBuilder: (context, child, loadingProgress) {
// //                       if (loadingProgress == null) return child;
// //                       return const Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     },
// //                     errorBuilder: (context, error, stackTrace) {
// //                       return Container(
// //                         color: Colors.grey[300],
// //                         child: const Center(
// //                           child: Icon(Icons.error, color: Colors.grey),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _BottomSection extends StatelessWidget {
// //   const _BottomSection({required this.quantity});
// //
// //   final int quantity;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.1),
// //             spreadRadius: 1,
// //             blurRadius: 10,
// //             offset: const Offset(0, -2),
// //           ),
// //         ],
// //       ),
// //       child: SafeArea(
// //         child: Row(
// //           children: [
// //             Container(
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: Colors.grey[300]!),
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Row(
// //                 children: [
// //                   IconButton(
// //                     onPressed: () {
// //                       context.read<FoodDetailsCubit>().decrementQuantity();
// //                     },
// //                     icon: const Icon(Icons.remove),
// //                   ),
// //                   Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 16),
// //                     child: Text(
// //                       quantity.toString(),
// //                       style: const TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ),
// //                   IconButton(
// //                     onPressed: () {
// //                       context.read<FoodDetailsCubit>().incrementQuantity();
// //                     },
// //                     icon: const Icon(Icons.add),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(width: 16),
// //             Expanded(
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   context.read<FoodDetailsCubit>().addToCart();
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(
// //                       content: Text('Added to cart!'),
// //                       duration: Duration(seconds: 2),
// //                     ),
// //                   );
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.orange,
// //                   padding: const EdgeInsets.symmetric(vertical: 16),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Icon(Icons.shopping_cart, color: Colors.white),
// //                     SizedBox(width: 8),
// //                     Text(
// //                       'Add to Cart',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../cart/cubit/cart_cubit.dart';
// // import '../../cart/models/food_item.dart';
// import '../../home/models/food_item.dart';
// import '../cubit/food_details_cubit.dart';
//
// class FoodDetailsView extends StatelessWidget {
//   const FoodDetailsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocListener<FoodDetailsCubit, FoodDetailsState>(
//         listener: (context, state) {
//           if (state is FoodDetailsAddedToCart) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Added to cart successfully!'),
//                 backgroundColor: Color(0xFFFF6B35),
//                 duration: Duration(seconds: 2),
//               ),
//             );
//           }
//         },
//         child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
//           builder: (context, state) {
//             if (state is FoodDetailsLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: Color(0xFFFF6B35),
//                 ),
//               );
//             }
//
//             if (state is FoodDetailsError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Error: ${state.message}',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('Go Back'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (state is FoodDetailsLoaded) {
//               return _buildFoodDetails(context, state);
//             }
//
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFoodDetails(BuildContext context, FoodDetailsLoaded state) {
//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Hero Image Section
//                 _buildHeroImage(context, state),
//
//                 // Product Information
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildProductInfo(state.foodItem),
//                       const SizedBox(height: 20),
//                       _buildProductDetails(state.foodItem),
//                       const SizedBox(height: 20),
//                       _buildDescription(state.foodItem.description),
//                       const SizedBox(height: 24),
//                       _buildRecommendedSection(state.recommendedItems),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         // Bottom Action Bar
//         _buildBottomActionBar(context, state),
//       ],
//     );
//   }
//
//   Widget _buildHeroImage(BuildContext context, FoodDetailsLoaded state) {
//     return Stack(
//       children: [
//         // Food Image
//         Container(
//           width: double.infinity,
//           height: 300,
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             color: Colors.grey[200],
//           ),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             child: Container(
//               color: Colors.grey[300],
//               child: const Icon(
//                 Icons.fastfood,
//                 size: 80,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//
//         // Overlay Text
//         Positioned(
//           top: 120,
//           left: 0,
//           right: 0,
//           child: Container(
//             alignment: Alignment.center,
//             child: const Text(
//               'About This Menu',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 shadows: [
//                   Shadow(
//                     color: Colors.black26,
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         // Top Navigation
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Back Button
//                 GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//
//                 // Favorite Button
//                 GestureDetector(
//                   onTap: () => context.read<FoodDetailsCubit>().toggleFavorite(),
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       state.isFavorite ? Icons.favorite : Icons.favorite_border,
//                       color: state.isFavorite ? Colors.red : Colors.black,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProductInfo(FoodItem foodItem) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '${foodItem.name} 🍔',
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           '\$ ${foodItem.price.toStringAsFixed(3)}',
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFFFF6B35),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProductDetails(FoodItem foodItem) {
//     return Row(
//       children: [
//         // Free Delivery
//         Row(
//           children: [
//             Icon(
//               Icons.attach_money,
//               size: 16,
//               color: Colors.orange[600],
//             ),
//             const SizedBox(width: 4),
//             const Text(
//               'Free Delivery',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(width: 24),
//
//         // Delivery Time
//         Row(
//           children: [
//             Icon(
//               Icons.access_time,
//               size: 16,
//               color: Colors.orange[600],
//             ),
//             const SizedBox(width: 4),
//             Text(
//               foodItem.deliveryTime,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(width: 24),
//
//         // Rating
//         Row(
//           children: [
//             Icon(
//               Icons.star,
//               size: 16,
//               color: Colors.orange[600],
//             ),
//             const SizedBox(width: 4),
//             Text(
//               '${foodItem.rating}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDescription(String description) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Description',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           description,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[600],
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRecommendedSection(List<FoodItem> recommendedItems) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Recommended For You',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text(
//                 'See All',
//                 style: TextStyle(
//                   color: Color(0xFFFF6B35),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 16),
//
//         SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: recommendedItems.length,
//             itemBuilder: (context, index) {
//               return _buildRecommendedItem(recommendedItems[index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRecommendedItem(FoodItem foodItem) {
//     return Container(
//       width: 120,
//       margin: const EdgeInsets.only(right: 16),
//       child: Container(
//         height: 80,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.grey[200],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             color: Colors.grey[300],
//             child: const Icon(Icons.fastfood, size: 40, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomActionBar(BuildContext context, FoodDetailsLoaded state) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             // Quantity Controls
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => context.read<FoodDetailsCubit>().decreaseQuantity(),
//                   child: Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey[300]!),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.remove, size: 20, color: Colors.grey),
//                   ),
//                 ),
//
//                 Container(
//                   width: 60,
//                   alignment: Alignment.center,
//                   child: Text(
//                     '${state.quantity}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//
//                 GestureDetector(
//                   onTap: () => context.read<FoodDetailsCubit>().increaseQuantity(),
//                   child: Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey[300]!),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.add, size: 20, color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(width: 20),
//
//             // Add to Cart Button
//             // Expanded(
//             //   child: SizedBox(
//             //     height: 50,
//             //     child: ElevatedButton.icon(
//             //       onPressed: () => _addToCart(context, state),
//             //       style: ElevatedButton.styleFrom(
//             //         backgroundColor: const Color(0xFFFF6B35),
//             //         shape: RoundedRectangleBorder(
//             //           borderRadius: BorderRadius.circular(25),
//             //         ),
//             //         elevation: 0,
//             //       ),
//             //       icon: const Icon(
//             //         Icons.shopping_cart,
//             //         color: Colors.white,
//             //         size: 20,
//             //       ),
//             //       label: const Text(
//             //         'Add to Cart',
//             //         style: TextStyle(
//             //           color: Colors.white,
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.w600,
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // void _addToCart(BuildContext context, FoodDetailsLoaded state) {
//   //   // Add to cart using the existing CartCubit
//   //   context.read<CartCubit>().addToCart(state.foodItem, state.quantity);
//   //
//   //   // Notify the FoodDetailsCubit that item was added
//   //   // context.read<FoodDetailsCubit>().addToCartCompleted();
//   //
//   //   // Show snackbar directly instead of emitting state
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text('Added to cart successfully')),
//   //   );
//   // }
// }