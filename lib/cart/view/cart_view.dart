import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/models/food_item.dart';
import '../cubit/cart_cubit.dart';
import '../models/cart_item.dart';
// import '../models/food_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF6B35),
              ),
            );
          }

          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<CartCubit>().loadCart(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CartEmpty) {
            return _buildEmptyCart();
          }

          if (state is CartLoaded) {
            return _buildPopulatedCart(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty state illustration
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circles
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Center search icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B35),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Ouch! Hungry',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Seems like you have not ordered\nany food yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to food listing page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Find Foods',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopulatedCart(BuildContext context, CartLoaded state) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Items
                ...state.items.map((cartItem) => _buildCartItem(context, cartItem)),

                const SizedBox(height: 32),

                // Recommended Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended For You',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFFFF6B35),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Recommended Items
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.recommendedItems.length,
                    itemBuilder: (context, index) {
                      return _buildRecommendedItem(state.recommendedItems[index]);
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Payment Summary
                _buildPaymentSummary(state),
              ],
            ),
          ),
        ),

        // Order Now Button
        Container(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to checkout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Order Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () => context.read<CartCubit>().toggleItemSelection(cartItem.foodItem.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: cartItem.isSelected ? const Color(0xFFFF6B35) : Colors.transparent,
                border: Border.all(
                  color: cartItem.isSelected ? const Color(0xFFFF6B35) : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: cartItem.isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          // Food Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[300],
                child: const Icon(Icons.fastfood, size: 30, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.foodItem.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$ ${cartItem.foodItem.price.toStringAsFixed(3)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              GestureDetector(
                onTap: () => context.read<CartCubit>().updateQuantity(
                  cartItem.foodItem.id,
                  cartItem.quantity - 1,
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.remove, size: 16, color: Colors.grey),
                ),
              ),

              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => context.read<CartCubit>().updateQuantity(
                  cartItem.foodItem.id,
                  cartItem.quantity + 1,
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.grey),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Delete Button
          GestureDetector(
            onTap: () => context.read<CartCubit>().removeFromCart(cartItem.foodItem.id),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItem(FoodItem foodItem) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[300],
                child: const Icon(Icons.fastfood, size: 40, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            foodItem.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Icon(Icons.star, size: 12, color: Colors.orange[600]),
              const SizedBox(width: 4),
              Text(
                '${foodItem.rating}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.location_on, size: 12, color: Colors.orange[600]),
              const SizedBox(width: 4),
              Text(
                foodItem.distance,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            '\$ ${foodItem.price.toStringAsFixed(3)}',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFFF6B35),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(CartLoaded state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 16),

          _buildSummaryRow('Total Items (${state.totalItemCount})', '\$${state.subtotal.toStringAsFixed(3)}'),
          _buildSummaryRow('Delivery Fee', state.deliveryFee == 0 ? 'Free' : '\$${state.deliveryFee.toStringAsFixed(3)}'),
          _buildSummaryRow('Discount', '-\$${state.discount.toStringAsFixed(3)}', isDiscount: true),

          const Divider(height: 32),

          _buildSummaryRow('Total', '\$${state.total.toStringAsFixed(3)}', isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: Colors.grey[700],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: isDiscount ? Colors.red : (isBold ? Colors.black : Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}