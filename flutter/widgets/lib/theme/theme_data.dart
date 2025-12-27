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
      focusColor: Colors.transparent,
      textTheme: createTextTheme(
        onSurface: colorScheme.onSurface,
        onSurfaceVariant: colorScheme.onSurfaceVariant,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.tertiary;
            }
            if (states.contains(WidgetState.hovered)) {
              return Colors.transparent;
            }
            return Colors.transparent;
          }),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary;
            }

            return colorScheme.onSurface;
          }),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.tertiary;
            }
            if (states.contains(WidgetState.hovered)) {
              return Colors.transparent;
            }
            return Colors.transparent;
          }),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary;
            }

            return colorScheme.onSurface;
          }),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.tertiary;
            }
            if (states.contains(WidgetState.hovered)) {
              return Colors.transparent;
            }
            return Colors.transparent;
          }),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              return colorScheme.onSurface;
            },
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.tertiary;
            }
            if (states.contains(WidgetState.hovered)) {
              return Colors.transparent;
            }
            return Colors.transparent;
          }),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          iconColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return colorScheme.primary;
              }

              return colorScheme.onSurface;
            },
          ),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(4),
        thickness: const WidgetStatePropertyAll(6),
        thumbColor: WidgetStatePropertyAll(colorScheme.onSurface),
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
    onSurfaceVariant: themeColors.foreground_800,
    // surfaceDim: themeColors.foreground_800,
    surfaceContainerHigh: themeColors.foreground_900,
    surfaceContainerLow: themeColors.background_300,
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
