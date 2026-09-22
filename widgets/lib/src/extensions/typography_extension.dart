import 'package:flutter/material.dart';

/// Extensions on [TextTheme] to support Mechanix emphasized typography.
extension MechanixTextThemeEmphasis on TextTheme {
  TextTheme get emphasized => copyWith(
    displayLarge: displayLarge?.copyWith(fontWeight: FontWeight.w500),
    displayMedium: displayMedium?.copyWith(fontWeight: FontWeight.w500),
    displaySmall: displaySmall?.copyWith(fontWeight: FontWeight.w500),
    headlineLarge: headlineLarge?.copyWith(fontWeight: FontWeight.w400),
    headlineMedium: headlineMedium?.copyWith(fontWeight: FontWeight.w400),
    headlineSmall: headlineSmall?.copyWith(fontWeight: FontWeight.w400),
    titleLarge: titleLarge?.copyWith(fontWeight: FontWeight.w500),
    titleMedium: titleMedium?.copyWith(fontWeight: FontWeight.w400),
    titleSmall: titleSmall?.copyWith(fontWeight: FontWeight.w400),
    bodyLarge: bodyLarge?.copyWith(fontWeight: FontWeight.w500),
    bodyMedium: bodyMedium?.copyWith(fontWeight: FontWeight.w400),
    bodySmall: bodySmall?.copyWith(fontWeight: FontWeight.w400),
    labelLarge: labelLarge?.copyWith(fontWeight: FontWeight.w500),
    labelMedium: labelMedium?.copyWith(fontWeight: FontWeight.w400),
    labelSmall: labelSmall?.copyWith(fontWeight: FontWeight.w400),
  );
}
