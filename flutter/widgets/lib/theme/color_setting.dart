import 'package:flutter/material.dart';
import 'package:oklch/oklch.dart';
import 'package:widgets/types/theme_colors.dart';

class ColorSetting {
  const ColorSetting({
    this.accentColor = const Color.fromRGBO(198, 118, 0, 0.98),
    this.background = const Color.fromRGBO(0, 0, 0, 1),
    this.foreground = const Color.fromRGBO(255, 255, 255, 1),
  });

  final Color accentColor;
  final Color background;
  final Color foreground;

  ThemeColors getThemeColor({required ThemeMode themeMode}) {
    Color getLightenColorFromOKLCH(double amount, Color color) {
      OKLCHColor oKLCHColor = OKLCHColor.fromColor(color);
      final chroma = oKLCHColor.chroma;
      final hue = oKLCHColor.hue;
      final lightness = oKLCHColor.lightness;

      return OKLCHColor.fromOKLCH(
              (lightness + amount) > 100 ? 100 : (lightness + amount),
              chroma,
              hue)
          .color;
    }

    Color getDarkenColorFromOKLCH(double amount, Color color) {
      OKLCHColor oKLCHColor = OKLCHColor.fromColor(color);
      final chroma = oKLCHColor.chroma;
      final hue = oKLCHColor.hue;
      final lightness = oKLCHColor.lightness;

      return OKLCHColor.fromOKLCH(
              (lightness - amount) > 100 ? 100 : (lightness - amount),
              chroma,
              hue)
          .color;
    }

    if (themeMode == ThemeMode.light) {
      return ThemeColors(
        accent_0: getDarkenColorFromOKLCH(10, accentColor),
        accent_100: getDarkenColorFromOKLCH(5, accentColor),
        accent_200: accentColor,
        accent_300: getLightenColorFromOKLCH(5, accentColor),
        accent_400: getLightenColorFromOKLCH(10, accentColor),
        accent_500: getLightenColorFromOKLCH(15, accentColor),
        accent_600: getLightenColorFromOKLCH(20, accentColor),
        accent_700: getLightenColorFromOKLCH(25, accentColor),
        accent_800: getLightenColorFromOKLCH(30, accentColor),
        accent_900: getLightenColorFromOKLCH(35, accentColor),
        accent_1000: getLightenColorFromOKLCH(40, accentColor),
        background_0: getLightenColorFromOKLCH(60, background),
        background_100: getLightenColorFromOKLCH(55, background),
        background_200: getLightenColorFromOKLCH(50, background),
        background_300: getLightenColorFromOKLCH(45, background),
        background_400: getLightenColorFromOKLCH(40, background),
        background_500: getLightenColorFromOKLCH(35, background),
        background_600: getLightenColorFromOKLCH(30, background),
        background_700: getLightenColorFromOKLCH(25, background),
        background_800: getLightenColorFromOKLCH(20, background),
        background_900: getLightenColorFromOKLCH(15, background),
        background_1000: background,
        foreground_0: foreground,
        foreground_100: getDarkenColorFromOKLCH(5, foreground),
        foreground_200: getDarkenColorFromOKLCH(10, foreground),
        foreground_300: getDarkenColorFromOKLCH(15, foreground),
        foreground_400: getDarkenColorFromOKLCH(20, foreground),
        foreground_500: getDarkenColorFromOKLCH(25, foreground),
        foreground_600: getDarkenColorFromOKLCH(30, foreground),
        foreground_700: getDarkenColorFromOKLCH(35, foreground),
        foreground_800: getDarkenColorFromOKLCH(40, foreground),
        foreground_900: getDarkenColorFromOKLCH(45, foreground),
        foreground_1000: getDarkenColorFromOKLCH(50, foreground),
      );
    }

    return ThemeColors(
      accent_0: getLightenColorFromOKLCH(10, accentColor),
      accent_100: getLightenColorFromOKLCH(5, accentColor),
      accent_200: accentColor,
      accent_300: getDarkenColorFromOKLCH(5, accentColor),
      accent_400: getDarkenColorFromOKLCH(10, accentColor),
      accent_500: getDarkenColorFromOKLCH(15, accentColor),
      accent_600: getDarkenColorFromOKLCH(20, accentColor),
      accent_700: getDarkenColorFromOKLCH(25, accentColor),
      accent_800: getDarkenColorFromOKLCH(30, accentColor),
      accent_900: getDarkenColorFromOKLCH(35, accentColor),
      accent_1000: getDarkenColorFromOKLCH(40, accentColor),
      background_0: getLightenColorFromOKLCH(60, background),
      background_100: getLightenColorFromOKLCH(55, background),
      background_200: getLightenColorFromOKLCH(50, background),
      background_300: getLightenColorFromOKLCH(45, background),
      background_400: getLightenColorFromOKLCH(40, background),
      background_500: getLightenColorFromOKLCH(35, background),
      background_600: getLightenColorFromOKLCH(30, background),
      background_700: getLightenColorFromOKLCH(25, background),
      background_800: getLightenColorFromOKLCH(20, background),
      background_900: getLightenColorFromOKLCH(15, background),
      background_1000: background,
      foreground_0: foreground,
      foreground_100: getDarkenColorFromOKLCH(5, foreground),
      foreground_200: getDarkenColorFromOKLCH(10, foreground),
      foreground_300: getDarkenColorFromOKLCH(15, foreground),
      foreground_400: getDarkenColorFromOKLCH(20, foreground),
      foreground_500: getDarkenColorFromOKLCH(25, foreground),
      foreground_600: getDarkenColorFromOKLCH(30, foreground),
      foreground_700: getDarkenColorFromOKLCH(35, foreground),
      foreground_800: getDarkenColorFromOKLCH(40, foreground),
      foreground_900: getDarkenColorFromOKLCH(45, foreground),
      foreground_1000: getDarkenColorFromOKLCH(50, foreground),
    );
  }
}
