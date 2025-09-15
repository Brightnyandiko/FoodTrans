// lib/cart/widgets/empty_cart_view.dart
import 'package:flutter/material.dart';
import '../../shared/widgets/widgets.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'My Cart'),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildEmptyStateIllustration(),
                  const SizedBox(height: 40),
                  const Text(
                    'Ouch! Hungry',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Seems like you have not ordered\nany food yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/product-details');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Find Foods',
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

  Widget _buildEmptyStateIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background decorative circles
        Positioned(
          top: 0,
          left: 50,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 40,
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 30,
          child: Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 80,
          right: 80,
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Main circles with search icon
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}