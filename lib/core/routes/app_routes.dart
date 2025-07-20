import 'package:flutter/material.dart';
import 'package:product_cart_app/features/auth/presentation/pages/login_page.dart';
import 'package:product_cart_app/features/auth/presentation/pages/register_page.dart';
import 'package:product_cart_app/features/products/presentation/pages/product_list_page.dart';
import 'package:product_cart_app/features/products/presentation/pages/product_detail_page.dart';
import 'package:product_cart_app/features/cart/presentation/pages/cart_page.dart';
import 'package:product_cart_app/features/splash/presentation/pages/splash_page.dart';
import 'package:product_cart_app/features/products/domain/entities/product.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String productList = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case productList:
        return MaterialPageRoute(builder: (_) => ProductListPage());
      case productDetail:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product),
        );
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
