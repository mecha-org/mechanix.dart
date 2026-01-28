import 'package:flutter/material.dart';

TextTheme createTextTheme(
    {required onSurface, required Color onSurfaceVariant}) {
  return TextTheme(
    displayLarge: TextStyle(
      color: onSurface,
      fontSize: 59,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    displayMedium: TextStyle(
      color: onSurface,
      fontSize: 47,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    displaySmall: TextStyle(
      color: onSurface,
      fontSize: 38,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    headlineLarge: TextStyle(
      color: onSurface,
      fontSize: 34,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    headlineMedium: TextStyle(
      color: onSurface,
      fontSize: 30,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    headlineSmall: TextStyle(
      color: onSurface,
      fontSize: 26,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    titleLarge: TextStyle(
      color: onSurface,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    titleMedium: TextStyle(
      color: onSurface,
      fontSize: 20,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    titleSmall: TextStyle(
      color: onSurface,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    bodyLarge: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    bodyMedium: TextStyle(
      color: onSurface,
      fontSize: 20,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    bodySmall: TextStyle(
      color: onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
    labelLarge: TextStyle(
      color: onSurfaceVariant,
      fontSize: 18,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ), // settings section list menu label
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: onSurface,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ), // settings section list menu label
    labelSmall: TextStyle(
      fontSize: 18,
      color: onSurface,
      fontWeight: FontWeight.w400,
      fontFamily: 'Overused Grotesk',
      package: 'widgets',
    ),
  );
}
