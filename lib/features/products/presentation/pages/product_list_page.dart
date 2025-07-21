import 'package:product_cart_app/core/imports/app_imports.dart'; // Add this import

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitConfirmationWrapper(
      // Wrap the entire Scaffold
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
              alignment: Alignment.topLeft, child: Text('Products')),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list_alt),
              onPressed: () => _showFilterBottomSheet(context),
            ),
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded && state.items.isNotEmpty) {
                        return Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${state.items.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOutEvent());
                    },
                  );
                } else if (state is AuthGuest) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_outline,
                                size: 16, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(
                              'Guest',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.login),
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          (route) => false, // This removes all previous routes
                        ),
                      ),
                    ],
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false, // This removes all previous routes
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(LoadProductsEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is ProductLoaded) {
              if (state.filteredProducts.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(LoadProductsEvent());
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  itemCount: (state.filteredProducts.length / 2).ceil(),
                  cacheExtent: 1000,
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    final endIndex = (startIndex + 1)
                        .clamp(0, state.filteredProducts.length);

                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppConstants.defaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: ProductCard(
                              key: ValueKey(
                                  state.filteredProducts[startIndex].id),
                              product: state.filteredProducts[startIndex],
                              onAddToCart: () => _handleAddToCart(
                                  context, state.filteredProducts[startIndex]),
                              onTap: () => _handleProductTap(
                                  context, state.filteredProducts[startIndex]),
                            ),
                          ),
                          const SizedBox(width: AppConstants.defaultPadding),
                          if (endIndex < state.filteredProducts.length)
                            Expanded(
                              child: ProductCard(
                                key: ValueKey(
                                    state.filteredProducts[endIndex].id),
                                product: state.filteredProducts[endIndex],
                                onAddToCart: () => _handleAddToCart(
                                    context, state.filteredProducts[endIndex]),
                                onTap: () => _handleProductTap(
                                    context, state.filteredProducts[endIndex]),
                              ),
                            )
                          else
                            const Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // Extract methods to avoid rebuilding closures
  void _handleAddToCart(BuildContext context, product) {
    context.read<CartBloc>().add(AddToCartEvent(product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleProductTap(BuildContext context, product) {
    Navigator.pushNamed(
      context,
      AppRoutes.productDetail,
      arguments: product,
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
