// lib/product/view/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/home/models/food_item.dart';
import '../models/models.dart';
import '../cubit/product_cubit.dart';
import '../../cart/cubit/cart_cubit.dart';
import 'product_detail_view.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  static Route<void> route(Product product) {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailPage(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<CartCubit>()),
        BlocProvider.value(value: context.read<ProductCubit>()),
      ],
      child: ProductDetailView(product: product),
    );
  }
}