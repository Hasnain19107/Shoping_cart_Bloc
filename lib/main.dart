import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:product_cart_app/core/theme/app_theme.dart';
import 'package:product_cart_app/core/routes/app_routes.dart';
import 'package:product_cart_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:product_cart_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:product_cart_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:product_cart_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:product_cart_app/core/di/injection_container.dart' as di;
import 'package:product_cart_app/features/products/presentation/bloc/product_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => di.sl<ProductBloc>()..add(LoadProductsEvent()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => di.sl<CartBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product Cart App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
