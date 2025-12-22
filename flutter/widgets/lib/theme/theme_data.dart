import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';
import 'package:widgets/theme/Common_themes/text_theme.dart';
import 'package:widgets/theme/color_setting.dart';

ThemeData createTheme(
    {bool useMaterial3 = true, required ColorScheme colorScheme}) {
  final ThemeData theme =
      ThemeData.from(useMaterial3: useMaterial3, colorScheme: colorScheme);

  return theme.copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      textTheme: createTextTheme(
        onSurface: colorScheme.onSurface,
        surfaceDim: colorScheme.surfaceDim,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primaryFixed,
      ));
}

ThemeData createLightTheme(
    {bool useMaterial3 = true, required Color primaryColor}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  );

  return createTheme(colorScheme: colorScheme);
}

ThemeData createDarkTheme(
    {bool useMaterial3 = true, required Color primaryColor}) {
  final colorSetting = ColorSetting(accentColor: primaryColor);

  final themeColors = colorSetting.getThemeColor();

  final colorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: themeColors.accent_600,
    onPrimary: themeColors.foreground_1200,
    primaryFixed: themeColors.accent_700,
    secondary: themeColors.background_400,
    tertiary: themeColors.background_500,
    tertiaryFixedDim: themeColors.background_600,
    surface: themeColors.background_1200,
    onSurface: themeColors.foreground_600,
    surfaceDim: themeColors.foreground_800,
    surfaceContainerLowest: themeColors.foreground_0,
  );

  return createTheme(colorScheme: colorScheme);
}

ThemeData getCurrentTheme(Color color, ThemeMode mode) {
  if (ThemeMode.light == mode) {
    return createLightTheme(primaryColor: color);
  }
  return createDarkTheme(primaryColor: color);
}

final mechanixLightTheme = createLightTheme(primaryColor: mechanixPrimaryColor);

final mechanixDarkTheme = createDarkTheme(primaryColor: mechanixPrimaryColor);
