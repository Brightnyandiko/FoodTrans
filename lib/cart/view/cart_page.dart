import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';
import '../repository/cart_repository.dart';
import 'cart_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CartPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(
        cartRepository: CartRepository(),
      )..loadCart(),
      child: const CartView(),
    );
  }
}