import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/checkout_cubit.dart';
import 'cart_view.dart';
// import 'package:payment_summary_app/cart/cubit/checkout_cubit.dart';
// import 'package:payment_summary_app/cart/view/cart_view.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CheckoutPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit()..loadCart(),
      child: const CheckoutView(),
    );
  }
}

