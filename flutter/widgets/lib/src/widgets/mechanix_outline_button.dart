import 'package:flutter/material.dart';

class MechanixOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final EdgeInsets padding;
  final double borderRadius;
  final double borderWidth;

  const MechanixOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderColor = Colors.grey,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = 8.0,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(color: borderColor, width: borderWidth),
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
