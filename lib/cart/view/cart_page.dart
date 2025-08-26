import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';
import 'cart_view.dart';
// import 'package:payment_summary_app/cart/cubit/cart_cubit.dart';
// import 'package:payment_summary_app/cart/view/cart_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CartPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit()..loadCart(),
      child: const CartView(),
    );
  }
}

