import 'package:product_cart_app/core/imports/app_imports.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<CartBloc, CartState>(
        listener: _handleStateListener,
        builder: _buildBody,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.isNotEmpty) {
            return Text('Cart (${state.totalItems} items)');
          }
          return const Text('Shopping Cart');
        },
      ),
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded && state.isNotEmpty) {
              return TextButton(
                onPressed: () => _showClearCartDialog(context),
                style:
                    TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
                child: const Text('Clear'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _handleStateListener(BuildContext context, CartState state) {
    if (state is CartError) {
      _showSnackBar(context, state.message, Colors.red, Icons.error_outline);
    } else if (state is CartOperationSuccess) {
      _showSnackBar(context, state.message, Colors.green, Icons.check_circle);
    }
  }

  void _showSnackBar(
      BuildContext context, String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CartState state) {
    return switch (state) {
      CartLoading() => const Center(child: CircularProgressIndicator()),
      CartLoaded() when state.isEmpty => const EmptyCartWidget(),
      CartLoaded() => _buildCartContent(context, state),
      CartOperationSuccess() => _buildCartContent(context, state.updatedCart),
      CartError() => _buildErrorState(context, state),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildErrorState(BuildContext context, CartError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text('Cart Error',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            const SizedBox(height: 8),
            Text(state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => context.read<CartBloc>().add(LoadCartEvent()),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CartBloc>().add(LoadCartEvent());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: Column(
        children: [
          const GuestNotificationBanner(),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              itemCount: state.items.length,
              itemBuilder: (context, index) => CartItemWidget(
                cartItem: state.items[index],
                onQuantityChanged: (quantity) => context.read<CartBloc>().add(
                      UpdateQuantityEvent(
                          state.items[index].product.id, quantity),
                    ),
                onRemove: () => context.read<CartBloc>().add(
                      RemoveFromCartEvent(
                        state.items[index].product.id,
                        productTitle: state.items[index].product.title,
                      ),
                    ),
              ),
            ),
          ),
          CartSummary(
            totalItems: state.totalItems,
            totalAmount: state.totalAmount,
            onCheckout: () => _handleCheckout(context),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    ClearCartDialog.show(
      context,
      () => context.read<CartBloc>().add(const ClearCartEvent()),
    );
  }

  void _handleCheckout(BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      CheckoutSuccessDialog.show(
        context,
        () {
          Navigator.pop(context);
          context
              .read<CartBloc>()
              .add(const ClearCartEvent(showSuccessMessage: false));
          Navigator.pushReplacementNamed(context, AppRoutes.productList);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const GuestCheckoutDialog(),
      );
    }
  }
}
