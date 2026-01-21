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
              return colorScheme.surfaceContainerHigh;
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
              return colorScheme.surfaceContainerHigh;
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
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return colorScheme.outline;
              }
              if (states.contains(WidgetState.hovered)) {
                return colorScheme.surfaceContainer;
              }
              return colorScheme.surfaceContainer;
            },
          ),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          padding: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return EdgeInsets.symmetric(vertical: 8, horizontal: 16);
              }
              return EdgeInsets.symmetric(vertical: 8, horizontal: 16);
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return colorScheme.primary;
              }
              return colorScheme.onSurface;
            },
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
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.secondary;
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

ThemeData createLightTheme({
  bool useMaterial3 = true,
  required Color primaryColor,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  );

  final colorSetting = ColorSetting(
    accentColor: primaryColor,
    background: backgroundColor ?? defaultBackgroundColor,
    foreground: foregroundColor ?? defaultForegroundColor,
  );

  final themeColors = colorSetting.getThemeColor(themeMode: ThemeMode.light);

  return createTheme(colorScheme: colorScheme);
}

ThemeData createDarkTheme({
  bool useMaterial3 = true,
  required Color primaryColor,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  final colorSetting = ColorSetting(
    accentColor: primaryColor,
    background: backgroundColor ?? defaultBackgroundColor,
    foreground: foregroundColor ?? defaultForegroundColor,
  );

  final themeColors = colorSetting.getThemeColor(themeMode: ThemeMode.dark);

  final colorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    // ACCENT
    primary: themeColors.accent_300,
    primaryContainer: themeColors.accent_200,
    primaryFixed: themeColors.accent_500,
    // BACKGROUND
    secondary: themeColors.background_800,
    secondaryContainer: themeColors.background_700,
    surfaceContainerHighest: themeColors.background_500,
    surfaceContainerHigh: themeColors.background_600,
    surface: themeColors.background_1000,
    surfaceContainer: themeColors.background_400,
    outline: themeColors.background_300,
    outlineVariant: themeColors.background_0,
    // FOREGROUND
    onSurface: themeColors.foreground_200,
    onSurfaceVariant: themeColors.foreground_1000,
    onSecondary: themeColors.foreground_500,
    onSecondaryFixedVariant: themeColors.foreground_0,
    onSecondaryFixed: themeColors.foreground_800,
    onTertiaryFixedVariant: themeColors.foreground_100,
    onSecondaryContainer: themeColors.foreground_300,
    onInverseSurface: themeColors.foreground_600,
  );

  // primary: themeColors.accent_300, // rgb(181,103,0)
  // primaryContainer: themeColors.accent_200, // rgb(198, 118, 0)
  // secondary: themeColors.background_800, // rgb(22,22,22)
  // secondaryContainer: themeColors.background_700, // rgb(34,34,34)
  // surfaceContainerHighest: themeColors.background_500, // rgb(58,58,58)
  // surfaceContainerHigh: themeColors.background_600, // rgb(45,45,45)
  // surface: themeColors.background_1000, // rgb(0,0,0)
  // surfaceContainer: themeColors.background_400, //rgb(71,71,71)
  // outlineVariant: themeColors.background_0, // rgb(128,128,128)
  // onSurface: themeColors.foreground_200, // rgb(222,222,222)
  // onSurfaceVariant: themeColors.foreground_1000, // rgb(99,99,99)
  // onInverseSurface: themeColors.foreground_600, // rgb(158,158,158)
  // onSecondary: themeColors.foreground_500, // rgb(174,174,174)
  //
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
