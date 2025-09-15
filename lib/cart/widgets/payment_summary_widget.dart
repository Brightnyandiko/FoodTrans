// lib/cart/widgets/payment_summary_widget.dart
import 'package:flutter/material.dart';
// import '../cubit/cart_state.dart';
import '../../shared/utils/formatters.dart';
import '../cubit/cart_cubit.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final CartLoaded cartState;

  const PaymentSummaryWidget({
    Key? key,
    required this.cartState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            'Total Items (${cartState.totalQuantity})',
            PriceFormatter.formatPrice(cartState.subtotal),
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Delivery Fee',
            cartState.deliveryFee == 0 ? 'Free' : PriceFormatter.formatPrice(cartState.deliveryFee),
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Discount',
            '-${PriceFormatter.formatPrice(cartState.discount)}',
            isDiscount: true,
          ),
          const Divider(height: 24),
          _buildSummaryRow(
            'Total',
            PriceFormatter.formatPrice(cartState.finalTotal),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isDiscount ? Colors.red : (isTotal ? Colors.black : Colors.black),
          ),
        ),
      ],
    );
  }
}