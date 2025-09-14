import 'package:flutter/material.dart';

class MechanixTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final EdgeInsets padding;
  final double borderRadius;

  const MechanixTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ).copyWith(
        splashFactory: NoSplash.splashFactory, // Disable ripple animation
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
