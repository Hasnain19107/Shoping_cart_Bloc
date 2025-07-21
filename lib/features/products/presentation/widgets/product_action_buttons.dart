import 'package:product_cart_app/core/imports/app_imports.dart';

class ProductActionButtons extends StatelessWidget {
  final bool isInStock;
  final VoidCallback? onAddToCart;

  const ProductActionButtons({
    super.key,
    required this.isInStock,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isInStock ? onAddToCart : null,
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: isInStock
                  ? colorScheme.onPrimary
                  : colorScheme.onSurface.withOpacity(0.38),
            ),
            label: Text(
              isInStock ? 'Add to Cart' : 'Out of Stock',
              style: TextStyle(
                color: isInStock
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface.withOpacity(0.38),
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isInStock
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(0.12),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: isInStock ? 2 : 0,
            ),
          ),
        ),
      ),
    );
  }
}
