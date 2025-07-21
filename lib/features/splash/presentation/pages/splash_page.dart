import 'dart:async';

import 'package:product_cart_app/core/imports/app_imports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _hasTriggeredAuthCheck = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Add a delay before checking auth status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2), () {
        if (!_hasTriggeredAuthCheck && mounted) {
          _hasTriggeredAuthCheck = true;
          context.read<AuthBloc>().add(CheckAuthStatusEvent());
        }
      });
    });
  }

  void _navigateBasedOnState(AuthState state) {
    if (_hasNavigated) return;

    // Add additional delay before navigation if desired
    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      if (state is AuthAuthenticated) {
        _hasNavigated = true;
        Navigator.pushReplacementNamed(context, AppRoutes.productList);
      } else if (state is AuthGuest) {
        _hasNavigated = true;
        Navigator.pushReplacementNamed(context, AppRoutes.productList);
      } else if (state is AuthUnauthenticated) {
        _hasNavigated = true;
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else if (state is AuthError) {
        _hasNavigated = true;
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          _navigateBasedOnState(state);
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Product Cart App',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your Shopping Companion',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
