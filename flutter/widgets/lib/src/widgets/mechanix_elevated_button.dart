import 'package:flutter/material.dart';

class MechanixElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;
  final double borderRadius;

  MechanixElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    Color? backgroundColor,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = 8.0,
  }) : backgroundColor = backgroundColor ?? Colors.grey[800]!;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ).copyWith(
        splashFactory: NoSplash.splashFactory, // Disable ripple animation
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
