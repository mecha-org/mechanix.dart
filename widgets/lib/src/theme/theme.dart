import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

export 'inherited_theme.dart';
export 'theme_data.dart';

/// The Mechanix theme definitions and reactive theme widget factory.
///
/// Use [MechanixTheme] either as a static [ThemeData] provider:
/// ```dart
/// MaterialApp(
///   theme: MechanixTheme.light,
///   darkTheme: MechanixTheme.dark,
///   themeMode: ThemeMode.system,
/// );
/// ```
///
/// Or as a reactive theme scope wrapping your app:
/// ```dart
/// MechanixTheme(
///   accentColor: Colors.blue,
///   themeMode: ThemeMode.system,
///   builder: (context, theme, child) {
///     return MaterialApp(
///       theme: theme.light,
///       darkTheme: theme.dark,
///       themeMode: theme.mode,
///       home: child,
///     );
///   },
///   child: const MyHomePage(),
/// );
/// ```
abstract class MechanixTheme extends StatefulWidget {
  /// Creates a reactive [MechanixTheme] widget.
  const factory MechanixTheme({
    Key? key,
    Color? accentColor,
    ThemeMode themeMode,
    ValueWidgetBuilder<MechanixThemeData>? builder,
    Widget? child,
  }) = MechanixThemeScope;

  // ---------------------------------------------------------------------------
  // Static theme & color getters for direct usage (backwards compatibility)
  // ---------------------------------------------------------------------------

  /// The default light [ThemeData] for Mechanix applications.
  static ThemeData get light =>
      createTheme(colorScheme: MechanixColors.lightColorScheme);

  /// The default dark [ThemeData] for Mechanix applications.
  static ThemeData get dark =>
      createTheme(colorScheme: MechanixColors.darkColorScheme);

  /// The official light [ColorScheme] for Mechanix applications.
  static ColorScheme get lightColorScheme => MechanixColors.lightColorScheme;

  /// The official dark [ColorScheme] for Mechanix applications.
  static ColorScheme get darkColorScheme => MechanixColors.darkColorScheme;

  /// Creates a [ThemeData] configured with Mechanix specifications for the given [colorScheme].
  static ThemeData createTheme({required ColorScheme colorScheme}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: createTextTheme(textColor: colorScheme.onSurface),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
            if (states.contains(WidgetState.disabled)) {
              return SystemMouseCursors.basic;
            }

            return SystemMouseCursors.click;
          }),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.10);
            }
            if (states.contains(WidgetState.pressed)) {
              return Color.alphaBlend(
                colorScheme.onPrimary.withValues(alpha: 0.12),
                colorScheme.secondaryFixedDim,
              );
            }
            if (states.contains(WidgetState.hovered)) {
              return Color.alphaBlend(
                colorScheme.onPrimary.withValues(alpha: 0.08),
                colorScheme.secondaryFixedDim,
              );
            }
            return colorScheme.secondaryFixedDim;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.10);
            }
            return colorScheme.onPrimary;
          }),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.10);
            }
            return colorScheme.onPrimary;
          }),
          // splashFactory: const TouchOptimizedSplashFactory(),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
            if (states.contains(WidgetState.disabled)) {
              return SystemMouseCursors.basic;
            }

            return SystemMouseCursors.click;
          }),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.transparent;
            }
            if (states.contains(WidgetState.pressed)) {
              return Color.alphaBlend(
                colorScheme.onSurfaceVariant.withValues(alpha: 0.12),
                Colors.transparent,
              );
            }
            if (states.contains(WidgetState.hovered)) {
              return Color.alphaBlend(
                colorScheme.onSurfaceVariant.withValues(alpha: 0.08),
                Colors.transparent,
              );
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.38);
            }
            return colorScheme.onSurface;
          }),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.38);
            }
            return colorScheme.onSurface;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(
                color: colorScheme.onSurface.withValues(alpha: 0.10),
                width: 1.0,
              );
            }
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: colorScheme.outline, width: 3.0);
            }
            return BorderSide(color: colorScheme.outline, width: 1.0);
          }),
          // splashFactory: const TouchOptimizedSplashFactory(),
          animationDuration: const Duration(milliseconds: 200),
        ),
      ),
      checkboxTheme: _createCheckboxTheme(colorScheme),
      extensions: [
        ShapeTheme.standard(),
        CheckboxThemeDataConfig(
          focusRingColor: colorScheme.outline,
          focusRingWidth: 2.0,
          focusRingRadius: 24.0,
          showFocusIndicator: true,
        ),
      ],
    );
  }

  /// Creates a [CheckboxThemeData] configured with Mechanix specifications.
  static CheckboxThemeData _createCheckboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      }),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onSurface;
          }
          return Colors.transparent;
        }
        if (states.contains(WidgetState.selected)) {
          if (states.contains(WidgetState.error)) {
            return colorScheme.error;
          }
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.surface;
          }
          return Colors.transparent;
        }
        if (states.contains(WidgetState.selected)) {
          if (states.contains(WidgetState.error)) {
            return colorScheme.onError;
          }
          return colorScheme.onPrimary;
        }
        return Colors.transparent;
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(width: 0.0, color: Colors.transparent);
          }
          return BorderSide(width: 2.0, color: colorScheme.onSurface);
        }
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(width: 0.0, color: Colors.transparent);
        }
        if (states.contains(WidgetState.error)) {
          return BorderSide(width: 2.0, color: colorScheme.error);
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return BorderSide(width: 2.0, color: colorScheme.onSurface);
        }
        return BorderSide(width: 2.0, color: colorScheme.onSurfaceVariant);
      }),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashRadius: 20.0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );
  }

  /// Obtains the nearest [MechanixThemeData] from the given [context].
  static MechanixThemeData of(BuildContext context) {
    return MechanixThemeScope.of(context);
  }

  /// Obtains the nearest [MechanixThemeData] from the given [context], or null if none exists.
  static MechanixThemeData? maybeOf(BuildContext context) {
    return MechanixThemeScope.maybeOf(context);
  }

  /// Updates the theme mode for the nearest enclosing theme scope.
  static void setThemeMode(BuildContext context, ThemeMode mode) {
    MechanixThemeScope.setThemeMode(context, mode);
  }

  /// Updates the accent color for the nearest enclosing theme scope.
  static void setAccentColor(BuildContext context, Color? color) {
    MechanixThemeScope.setAccentColor(context, color);
  }
}
