import 'package:flutter/material.dart';

/// Mechanix color specifications, tonal palettes, and color schemes.
abstract final class MechanixColors {
  // // ---------------------------------------------------------------------------
  // // Accent Tonal Palette (Brand Orange)
  // // ---------------------------------------------------------------------------
  // static const Color accent0 = Color(0xFF481A00);
  // static const Color accent50 = Color(0xFF773108);
  // static const Color accent100 = Color(0xFFAA470E);
  // static const Color accent200 = Color(0xFFE15B0E);
  // static const Color accent300 = Color(0xFFF9640D);
  // static const Color accent400 = Color(0xFFFF7230);
  // static const Color accent500 = Color(0xFFFF7331);
  // static const Color accent600 = Color(0xFFFC8845);
  // static const Color accent700 = Color(0xFFFCA67B);
  // static const Color accent800 = Color(0xFFFDC4A1);
  // static const Color accent900 = Color(0xFFFDDBC3);
  // static const Color accent950 = Color(0xFFFEEEE2);
  // static const Color accent1000 = Color(0xFFFFF8F3);

  // // ---------------------------------------------------------------------------
  // // Neutral Tonal Palette (Grayscale / Surfaces)
  // // ---------------------------------------------------------------------------
  // static const Color neutral0 = Color(0xFF141415);
  // static const Color neutral50 = Color(0xFF19191A);
  // static const Color neutral100 = Color(0xFF232325);
  // static const Color neutral200 = Color(0xFF373739);
  // static const Color neutral300 = Color(0xFF505053);
  // static const Color neutral400 = Color(0xFF646468);
  // static const Color neutral500 = Color(0xFF66666A);
  // static const Color neutral600 = Color(0xFF8D8D91);
  // static const Color neutral700 = Color(0xFFA1A1A5);
  // static const Color neutral800 = Color(0xFFC6C6C8);
  // static const Color neutral900 = Color(0xFFE0E0E1);
  // static const Color neutral950 = Color(0xFFF5F5F5);
  // static const Color neutral1000 = Color(0xFFFFFFFF);

  // // ---------------------------------------------------------------------------
  // // Error Tonal Palette (Red)
  // // ---------------------------------------------------------------------------
  // static const Color error0 = Color(0xFF530402);
  // static const Color error50 = Color(0xFF6E0303);
  // static const Color error100 = Color(0xFFA80404);
  // static const Color error200 = Color(0xFFC70705);
  // static const Color error300 = Color(0xFFF90608);
  // static const Color error400 = Color(0xFFFF4242);
  // static const Color error500 = Color(0xFFFF4545);
  // static const Color error600 = Color(0xFFFC7E7C);
  // static const Color error700 = Color(0xFFFDA7A7);
  // static const Color error800 = Color(0xFFFDBBBB);
  // static const Color error900 = Color(0xFFFECDCD);
  // static const Color error950 = Color(0xFFFED7D7);
  // static const Color error1000 = Color(0xFFFEE9E9);

  // // ---------------------------------------------------------------------------
  // // Success Tonal Palette (Green)
  // // ---------------------------------------------------------------------------
  // static const Color success0 = Color(0xFF041703);
  // static const Color success50 = Color(0xFF082E05);
  // static const Color success100 = Color(0xFF13650B);
  // static const Color success200 = Color(0xFF15730D);
  // static const Color success300 = Color(0xFF40E830);
  // static const Color success400 = Color(0xFF62FF3E);
  // static const Color success500 = Color(0xFF62FE40);
  // static const Color success600 = Color(0xFF66ED59);
  // static const Color success700 = Color(0xFF8CF183);
  // static const Color success800 = Color(0xFFB3F6AD);
  // static const Color success900 = Color(0xFFD9FAD6);
  // static const Color success950 = Color(0xFFEDFDEE);
  // static const Color success1000 = Color(0xFFFBFFFC);

  // // Success roles
  // static const Color darkSuccess = Color(0xFF40E830);
  // static const Color darkOnSuccess = Color(0xFFF5F5F5);
  // static const Color darkSuccessContainer = Color(0xFF15730D);
  // static const Color darkOnSuccessContainer = Color(0xFFFBFFFC);

  // static const Color lightSuccess = Color(0xFF3CDE18);
  // static const Color lightOnSuccess = Color(0xFFFFFFFF);
  // static const Color lightSuccessContainer = Color(0xFF8CF075);
  // static const Color lightOnSuccessContainer = Color(0xFFF0FDED);

  // ---------------------------------------------------------------------------
  // Material 3 Color Schemes
  // ---------------------------------------------------------------------------

  /// The official Mechanix light [ColorScheme].
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF7230),
    onPrimary: Color(0xFF050505),
    primaryContainer: Color(0xFFE15B0E),
    onPrimaryContainer: Color(0xFFF4F4F5),
    primaryFixed: Color(0xFFE15B0E),
    primaryFixedDim: Color(0xFFE06924),
    onPrimaryFixed: Color(0xFF414144),
    onPrimaryFixedVariant: Color(0xFFDBDBDC),
    secondary: Color(0xFFF4F4F5),
    onSecondary: Color(0xFFFF7230),
    secondaryContainer: Color(0xFFDBDBDC),
    onSecondaryContainer: Color(0xFF75757A),
    secondaryFixed: Color(0xFFDBDBDC),
    secondaryFixedDim: Color(0xFFC0C0C3),
    onSecondaryFixed: Color(0xFF49494B),
    onSecondaryFixedVariant: Color(0xFF49494B),
    error: Color(0xFFFF4242),
    onError: Color(0xFFF4F4F5),
    errorContainer: Color(0xFFA80404),
    onErrorContainer: Color(0xFFFFEBEB),
    surface: Color(0xFFDBDBDC),
    onSurface: Color(0xFF414144),
    surfaceDim: Color(0xFFFFFFFF),
    surfaceBright: Color(0xFFFFFFFF),
    surfaceContainerLowest: Color(0xFFF4F4F5),
    surfaceContainerLow: Color(0xFFEDEDEE),
    surfaceContainer: Color(0xFFEDEDEE),
    surfaceContainerHigh: Color(0xFFF4F4F5),
    surfaceContainerHighest: Color(0xFFFFFFFF),
    onSurfaceVariant: Color(0xFFA5A5A7),
    outline: Color(0xFFC8C8CB),
    outlineVariant: Color(0xFFF4F4F5),
    inverseSurface: Color(0xFF050505),
    onInverseSurface: Color(0xFFEDEDEE),
    inversePrimary: Color(0xFF242424),
    scrim: Color(0xFFA5A5A7),
    shadow: Color(0xFFA5A5A7),
  );

  /// The official Mechanix dark [ColorScheme].
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF9640D),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFCA67B),
    onPrimaryContainer: Color(0xFF141415),
    primaryFixed: Color(0xFFFC8845),
    primaryFixedDim: Color(0xFFFC8845),
    onPrimaryFixed: Color(0xFFE0E0E1),
    onPrimaryFixedVariant: Color(0xFF232325),
    secondary: Color(0xFF141415),
    onSecondary: Color(0xFFFF7230),
    secondaryContainer: Color(0xFF232325),
    onSecondaryContainer: Color(0xFFA1A1A5),
    secondaryFixed: Color(0xFF19191A),
    secondaryFixedDim: Color(0xFF373739),
    onSecondaryFixed: Color(0xFF8D8D91),
    onSecondaryFixedVariant: Color(0xFFA1A1A5),
    error: Color(0xFFFF4242),
    onError: Color(0xFFF5F5F5),
    errorContainer: Color(0xFFA80404),
    onErrorContainer: Color(0xFFFEE9E9),
    surface: Color(0xFF232325),
    onSurface: Color(0xFFF5F5F5),
    surfaceDim: Color(0xFF000000),
    surfaceBright: Color(0xFF232325),
    surfaceContainerLowest: Color(0xFF000000),
    surfaceContainerLow: Color(0xFF141415),
    surfaceContainer: Color(0xFF19191A),
    surfaceContainerHigh: Color(0xFF232325),
    surfaceContainerHighest: Color(0xFF373739),
    onSurfaceVariant: Color(0xFF646468),
    outline: Color(0xFF373739),
    outlineVariant: Color(0xFF141415),
    inverseSurface: Color(0xFFFFFFFF),
    onInverseSurface: Color(0xFF19191A),
    inversePrimary: Color(0xFFF5F5F5),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );

  /// The default brand orange accent color.
  static const Color defaultAccentColor = Color(0xFFF9640D);

  /// Generates a light [ColorScheme] for Mechanix apps with the specified [accentColor].
  static ColorScheme createLightColorScheme({Color? accentColor}) {
    if (accentColor == null || accentColor == defaultAccentColor) {
      return lightColorScheme;
    }

    return lightColorScheme;
  }

  /// Generates a dark [ColorScheme] for Mechanix apps with the specified [accentColor].
  static ColorScheme createDarkColorScheme({Color? accentColor}) {
    if (accentColor == null || accentColor == defaultAccentColor) {
      return darkColorScheme;
    }

    return darkColorScheme;
  }
}
