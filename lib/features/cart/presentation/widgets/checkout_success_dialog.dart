import 'package:product_cart_app/core/imports/app_imports.dart';

class CheckoutSuccessDialog extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const CheckoutSuccessDialog({
    super.key,
    required this.onContinueShopping,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF4CAF50),
            size: 32,
          ),
          SizedBox(width: 12),
          Text(
            'Order Placed!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
      content: const Text(
        'Your order has been placed successfully. Thank you for shopping with us!',
        style: TextStyle(
          fontSize: 16,
          height: 1.4,
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onContinueShopping,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Continue Shopping',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context, VoidCallback onContinueShopping) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CheckoutSuccessDialog(
        onContinueShopping: onContinueShopping,
      ),
    );
  }
}
