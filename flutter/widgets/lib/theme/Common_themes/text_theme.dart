import 'package:flutter/material.dart';

TextTheme createTextTheme({required onSurface, required Color surfaceDim}) {
  return TextTheme(
    displayLarge: TextStyle(
      color: onSurface,
      fontSize: 57,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    displayMedium: TextStyle(
      color: onSurface,
      fontSize: 45,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    displaySmall: TextStyle(
      color: onSurface,
      fontSize: 36,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    headlineLarge: TextStyle(
      color: onSurface,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    headlineMedium: TextStyle(
      color: onSurface,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    headlineSmall: TextStyle(
      color: onSurface,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    titleLarge: TextStyle(
      color: onSurface,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    titleMedium: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    titleSmall: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    bodyLarge: TextStyle(
      color: onSurface,
      fontSize: 16,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    bodyMedium: TextStyle(
      color: onSurface,
      fontSize: 14,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    bodySmall: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    labelLarge: TextStyle(
      color: surfaceDim,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ), // settings section list menu label
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ), // settings section list menu label
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
  );
}
