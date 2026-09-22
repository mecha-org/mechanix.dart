import 'package:flutter/material.dart';

/// Default font family for Mechanix apps.
const String mechanixFontFamily = 'SpaceGrotesk';

/// Package name providing Mechanix typography assets.
const String mechanixFontPackage = 'widgets';

TextTheme createTextTheme({
  required Color textColor,
  String? fontFamily = mechanixFontFamily,
  List<String>? fontFamilyFallback,
}) {
  return TextTheme(
    // Display
    displayLarge: _MechanixTextStyle(
      fontSize: 52,
      height: 66, // 66 / 52 ≈ 1.27
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    displayMedium: _MechanixTextStyle(
      fontSize: 45,
      height: 52, // 52 / 45 ≈ 1.16
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    displaySmall: _MechanixTextStyle(
      fontSize: 36,
      height: 44, // 44 / 36 ≈ 1.22
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),

    // Headline
    headlineLarge: _MechanixTextStyle(
      fontSize: 32,
      height: 40, // 40 / 32 = 1.25
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    headlineMedium: _MechanixTextStyle(
      fontSize: 24,
      height: 36, // 36 / 24 = 1.50
      fontWeight: FontWeight.w300,
      letterSpacing: 2.0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    headlineSmall: _MechanixTextStyle(
      fontSize: 22,
      height: 26, // 26 / 22 ≈ 1.18
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),

    // Title
    titleLarge: _MechanixTextStyle(
      fontSize: 20,
      height: 26, // 26 / 20 = 1.30
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    titleMedium: _MechanixTextStyle(
      fontSize: 18,
      height: 23, // 23 / 18 ≈ 1.28
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    titleSmall: _MechanixTextStyle(
      fontSize: 16,
      height: 20, // 20 / 16 = 1.25
      fontWeight: FontWeight.w300,
      letterSpacing: 0.1,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),

    // Body
    bodyLarge: _MechanixTextStyle(
      fontSize: 16,
      height: 22, // 22 / 16 = 1.375
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    bodyMedium: _MechanixTextStyle(
      fontSize: 14,
      height: 18, // 18 / 14 ≈ 1.29
      fontWeight: FontWeight.w300,
      letterSpacing: -0.25,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    bodySmall: _MechanixTextStyle(
      fontSize: 12,
      height: 16, // 16 / 12 ≈ 1.33
      fontWeight: FontWeight.w300,
      letterSpacing: 0.4,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),

    // Label
    labelLarge: _MechanixTextStyle(
      fontSize: 14,
      height: 20, // 20 / 14 ≈ 1.43
      fontWeight: FontWeight.w400,
      letterSpacing: -0.5,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    labelMedium: _MechanixTextStyle(
      fontSize: 12,
      height: 16, // 16 / 12 ≈ 1.33
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    labelSmall: _MechanixTextStyle(
      fontSize: 11,
      height: 16, // 16 / 11 ≈ 1.45
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5,
      color: textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
  );
}

class _MechanixTextStyle extends TextStyle {
  const _MechanixTextStyle({
    required double fontSize,
    required double height,
    super.fontWeight,
    super.letterSpacing,
    required Color super.color,
    String? fontFamily = mechanixFontFamily,
    super.fontFamilyFallback,
    String? package = mechanixFontPackage,
  }) : super(
         fontSize: fontSize,
         height: height / fontSize,
         fontFamily: fontFamily ?? mechanixFontFamily,
         package: package,
         leadingDistribution: TextLeadingDistribution.even,
       );
}
