import 'package:flutter/material.dart';
import 'package:oklch/oklch.dart';
import 'package:widgets/types/theme_colors.dart';

class ColorSetting {
  const ColorSetting({
    this.accentColor = const Color.fromRGBO(198, 118, 0, 0.98),
    this.background = const Color.fromRGBO(14, 14, 14, 1),
    this.foreground = const Color.fromRGBO(210, 210, 210, 1),
  });

  final Color accentColor;
  final Color background;
  final Color foreground;

  ThemeColors getThemeColor() {
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

    return ThemeColors(
      accent_0: getLightenColorFromOKLCH(60, accentColor),
      accent_100: getLightenColorFromOKLCH(50, accentColor),
      accent_200: getLightenColorFromOKLCH(40, accentColor),
      accent_300: getLightenColorFromOKLCH(30, accentColor),
      accent_400: getLightenColorFromOKLCH(20, accentColor),
      accent_500: getLightenColorFromOKLCH(10, accentColor),
      accent_600: accentColor,
      accent_700: getDarkenColorFromOKLCH(10, accentColor),
      accent_800: getDarkenColorFromOKLCH(20, accentColor),
      accent_900: getDarkenColorFromOKLCH(30, accentColor),
      accent_1000: getDarkenColorFromOKLCH(40, accentColor),
      accent_1100: getDarkenColorFromOKLCH(50, accentColor),
      accent_1200: getDarkenColorFromOKLCH(60, accentColor),
      background_0: getLightenColorFromOKLCH(60, background),
      background_100: getLightenColorFromOKLCH(50, background),
      background_200: getLightenColorFromOKLCH(40, background),
      background_300: getLightenColorFromOKLCH(30, background),
      background_400: getLightenColorFromOKLCH(20, background),
      background_500: getLightenColorFromOKLCH(10, background),
      background_600: background,
      background_700: getDarkenColorFromOKLCH(10, background),
      background_800: getDarkenColorFromOKLCH(20, background),
      background_900: getDarkenColorFromOKLCH(30, background),
      background_1000: getDarkenColorFromOKLCH(40, background),
      background_1100: getDarkenColorFromOKLCH(50, background),
      background_1200: getDarkenColorFromOKLCH(60, background),
      foreground_0: getLightenColorFromOKLCH(60, foreground),
      foreground_100: getLightenColorFromOKLCH(50, foreground),
      foreground_200: getLightenColorFromOKLCH(40, foreground),
      foreground_300: getLightenColorFromOKLCH(30, foreground),
      foreground_400: getLightenColorFromOKLCH(20, foreground),
      foreground_500: getLightenColorFromOKLCH(10, foreground),
      foreground_600: foreground,
      foreground_700: getDarkenColorFromOKLCH(10, foreground),
      foreground_800: getDarkenColorFromOKLCH(20, foreground),
      foreground_900: getDarkenColorFromOKLCH(30, foreground),
      foreground_1000: getDarkenColorFromOKLCH(40, foreground),
      foreground_1100: getDarkenColorFromOKLCH(50, foreground),
      foreground_1200: getDarkenColorFromOKLCH(60, foreground),
    );
  }
}
