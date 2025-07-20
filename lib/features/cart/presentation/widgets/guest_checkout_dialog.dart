import 'package:flutter/material.dart';
import 'package:product_cart_app/core/routes/app_routes.dart';

class GuestCheckoutDialog extends StatelessWidget {
  const GuestCheckoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.login,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          const Text('Login Required'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'To complete your purchase, please login to your account or create a new one.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50, // Light blue background
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue.shade200, // Lighter blue border
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your cart items will be saved',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.register);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
          child: const Text('Register'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.login);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
