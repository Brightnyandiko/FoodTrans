// lib/app/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../../cart/view/cart_page.dart';
import '../../product/models/models.dart';
import '../../product/view/product_detail_page.dart';

class AppRoutes extends Route {
  static const String cart = '/cart';
  static const String productDetail = '/product-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case cart:
        return CartPage.route();
      case productDetail:
        if (settings.arguments is Product) {
          return ProductDetailPage.route(settings.arguments as Product);
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}