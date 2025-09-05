// lib/cart/widgets/active_cart_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product/widget/recommended_products.dart';
import '../cubit/cart_cubit.dart';
// import '../cubit/cart_state.dart';
import '../../product/cubit/product_cubit.dart';
import '../../shared/widgets/widgets.dart';
import 'cart_item_widget.dart';
import 'payment_summary_widget.dart';
// import '../../product/widgets/recommended_products.dart';

class ActiveCartView extends StatelessWidget {
  final CartLoaded cartState;

  const ActiveCartView({
    Key? key,
    required this.cartState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'My Cart'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Cart items
                ...cartState.items.values.map(
                      (cartItem) => CartItemWidget(cartItem: cartItem),
                ),

                const SizedBox(height: 24),

                // Recommended section
                BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      return RecommendedProducts(
                        products: state.recommendedProducts,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),

                // Payment summary
                PaymentSummaryWidget(cartState: cartState),
              ],
            ),
          ),

          // Order button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _showOrderConfirmation(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Order Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Confirmation'),
          content: const Text('Your order has been placed successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CartCubit>().clearCart();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}