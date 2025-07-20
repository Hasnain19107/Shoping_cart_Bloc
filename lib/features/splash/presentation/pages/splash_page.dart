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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasTriggeredAuthCheck && mounted) {
        _hasTriggeredAuthCheck = true;
        context.read<AuthBloc>().add(CheckAuthStatusEvent());
      }
    });
  }

  void _navigateBasedOnState(AuthState state) {
    if (_hasNavigated) return;

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
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  const SizedBox(height: 50),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getLoadingMessage(state),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white60,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getLoadingMessage(AuthState state) {
    if (state is AuthLoading) {
      return 'Checking authentication...';
    } else if (state is AuthAuthenticated) {
      return 'Welcome back!';
    } else if (state is AuthGuest) {
      return 'Loading products...';
    } else if (state is AuthUnauthenticated) {
      return 'Redirecting to login...';
    } else if (state is AuthError) {
      return 'Error occurred, redirecting...';
    }
    return 'Loading...';
  }
}
