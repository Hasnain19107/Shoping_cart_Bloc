import 'package:flutter/material.dart';
import 'package:product_cart_app/core/theme/app_theme.dart';

class AuthTextButton extends StatelessWidget {
  final String normalText;
  final String highlightText;
  final VoidCallback onPressed;

  const AuthTextButton({
    super.key,
    required this.normalText,
    required this.highlightText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
      ),
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: const TextStyle(color: AppTheme.textSecondaryColor),
          children: [
            TextSpan(
              text: highlightText,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
