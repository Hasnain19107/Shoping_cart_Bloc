import 'package:product_cart_app/core/imports/app_imports.dart';

class ClearCartDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ClearCartDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Row(
        children: [
          Icon(
            Icons.delete_outline,
            color: AppTheme.errorColor,
            size: 28,
          ),
          SizedBox(width: 8),
          Text('Clear Cart'),
        ],
      ),
      content: const Text(
        'Are you sure you want to clear your cart? This action cannot be undone.',
        style: TextStyle(height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.errorColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Clear'),
        ),
      ],
    );
  }

  static void show(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => ClearCartDialog(onConfirm: onConfirm),
    );
  }
}
