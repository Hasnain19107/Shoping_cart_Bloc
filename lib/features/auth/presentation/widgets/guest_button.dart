import 'package:flutter/material.dart';
import 'package:product_cart_app/core/theme/app_theme.dart';

class GuestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GuestButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.textSecondaryColor,
          side: const BorderSide(color: AppTheme.borderColor),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 20,
              color: AppTheme.iconLightColor,
            ),
            SizedBox(width: 8),
            Text(
              'Continue as Guest',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
