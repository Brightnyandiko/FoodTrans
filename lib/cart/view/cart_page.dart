// lib/cart/view/cart_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../../product/cubit/product_cubit.dart';
import 'cart_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CartPage());
  }

  @override
  Widget build(BuildContext context) {
    return const CartView();
  }
}