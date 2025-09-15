// lib/cart/view/cart_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/widgets.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<CartCubit, CartState>(
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        print('CartView: State changed to: ${state.runtimeType}');
        if (state is CartLoaded) {
          print('CartView: Received CartLoaded with ${state.items.length} items');
        }
      },
      builder: (context, state) {
        print('CartView: Building with state: ${state.runtimeType}');
        if (state is CartLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CartError) {
          print('CartView: Showing error: ${state.message}');
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CartLoaded) {
          print('CartView: CartLoaded with ${state.items.length} items');
          return ActiveCartView(cartState: state);
        }
        print('CartView: Showing empty cart');

        return const EmptyCartView();
      },
    );
  }
}