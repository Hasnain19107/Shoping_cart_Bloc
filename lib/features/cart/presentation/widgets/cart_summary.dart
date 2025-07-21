import 'package:product_cart_app/core/imports/app_imports.dart';

class CartSummary extends StatelessWidget {
  final int totalItems;
  final double totalAmount;
  final VoidCallback onCheckout;

  const CartSummary({
    super.key,
    required this.totalItems,
    required this.totalAmount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            colorScheme.surface, // Use theme surface color instead of hardcoded
        border: Border(
          top: BorderSide(
            color:
                colorScheme.outline.withOpacity(0.2), // Use theme outline color
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color:
                colorScheme.shadow.withOpacity(0.1), // Use theme shadow color
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Items: $totalItems',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface, // Use theme text color
                  ),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface, // Use theme text color
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      colorScheme.primary, // Use theme primary color
                  foregroundColor:
                      colorScheme.onPrimary, // Use theme on-primary color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Proceed to Checkout',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        colorScheme.onPrimary, // Ensure button text is visible
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
