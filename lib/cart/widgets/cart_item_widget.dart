// lib/cart/widgets/cart_item_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../models/models.dart';
import '../../shared/utils/formatters.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Checkbox
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),

          const SizedBox(width: 12),

          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 60,
              height: 60,
              color: Colors.grey[200],
              child: const Icon(Icons.fastfood, color: Colors.grey),
            ),
          ),

          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  PriceFormatter.formatPrice(cartItem.product.price),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls
          Row(
            children: [
              _buildQuantityButton(
                context,
                Icons.remove,
                    () => context.read<CartCubit>().updateQuantity(
                  cartItem.product.id,
                  cartItem.quantity - 1,
                ),
              ),
              Container(
                width: 32,
                alignment: Alignment.center,
                child: Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildQuantityButton(
                context,
                Icons.add,
                    () => context.read<CartCubit>().updateQuantity(
                  cartItem.product.id,
                  cartItem.quantity + 1,
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),

          // Delete button
          IconButton(
            onPressed: () {
              context.read<CartCubit>().removeItem(cartItem.product.id);
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(BuildContext context, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        child: Icon(icon, size: 18),
      ),
    );
  }
}