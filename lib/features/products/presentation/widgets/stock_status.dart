import 'package:flutter/material.dart';
import 'package:product_cart_app/core/theme/app_theme.dart';

class StockStatus extends StatelessWidget {
  final int stock;

  const StockStatus({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    final isInStock = stock > 0;

    return Row(
      children: [
        Icon(
          isInStock ? Icons.check_circle : Icons.cancel,
          color: isInStock ? const Color(0xFF4CAF50) : AppTheme.errorColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          isInStock ? 'In Stock ($stock available)' : 'Out of Stock',
          style: TextStyle(
            color: isInStock ? const Color(0xFF4CAF50) : AppTheme.errorColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
