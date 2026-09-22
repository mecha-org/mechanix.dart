import 'package:flutter/material.dart';

import '../../extensions/build_context.dart';
import 'floating_action_button_theme.dart';

/// Style and color resolver for [MechanixFloatingActionButton].
abstract class FloatingActionButtonStyleResolver {
  const FloatingActionButtonStyleResolver();

  /// Resolves the background color for [MechanixFloatingActionButton] according to the
  /// active [states], theme data, and custom color overrides.
  static Color resolveBackgroundColor({
    required BuildContext context,
    required Set<WidgetState> states,
    FloatingActionButtonThemeDataConfig? theme,
    Color? customBackgroundColor,
    Color? customHoverColor,
    Color? customPressedColor,
    Color? customDisabledColor,
  }) {
    final scheme = context.colorScheme;
    final defaultBg = scheme.secondaryContainer;
    final baseBg = customBackgroundColor ?? defaultBg;

    if (states.contains(WidgetState.disabled)) {
      if (customDisabledColor != null) return customDisabledColor;
      if (theme?.backgroundColor != null) {
        final themeColor = theme!.backgroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }
      return scheme.onSurface.withValues(alpha: 0.12);
    }

    if (states.contains(WidgetState.pressed)) {
      if (customPressedColor != null) return customPressedColor;
      if (theme?.backgroundColor != null) {
        final themeColor = theme!.backgroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }
      return applyStateLayer(
        baseColor: baseBg,
        stateLayerColor: scheme.onSecondaryContainer,
        opacity: 0.12,
      );
    }

    if (states.contains(WidgetState.hovered)) {
      if (customHoverColor != null) return customHoverColor;
      if (theme?.backgroundColor != null) {
        final themeColor = theme!.backgroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }
      return applyStateLayer(
        baseColor: baseBg,
        stateLayerColor: scheme.onSecondaryContainer,
        opacity: 0.08,
      );
    }

    if (customBackgroundColor != null) return customBackgroundColor;
    if (theme?.backgroundColor != null) {
      final themeColor = theme!.backgroundColor!.resolve(states);
      if (themeColor != null) return themeColor;
    }

    return baseBg;
  }

  /// Resolves the foreground / icon color for [MechanixFloatingActionButton] according
  /// to the active [states], theme data, and custom color overrides.
  static Color resolveForegroundColor({
    required BuildContext context,
    required Set<WidgetState> states,
    FloatingActionButtonThemeDataConfig? theme,
    Color? customForegroundColor,
    Color? customHoverForegroundColor,
    Color? customPressedForegroundColor,
    Color? customDisabledForegroundColor,
  }) {
    final scheme = context.colorScheme;
    final defaultFg = scheme.primary;
    final baseFg = customForegroundColor ?? defaultFg;

    if (states.contains(WidgetState.disabled)) {
      if (customDisabledForegroundColor != null) {
        return customDisabledForegroundColor;
      }
      if (theme?.foregroundColor != null) {
        final themeColor = theme!.foregroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }
      return scheme.onSurface.withValues(alpha: 0.38);
    }

    if (states.contains(WidgetState.pressed)) {
      if (customPressedForegroundColor != null) {
        return customPressedForegroundColor;
      }
      if (theme?.foregroundColor != null) {
        final themeColor = theme!.foregroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }
      return baseFg;
    }

    if (states.contains(WidgetState.hovered)) {
      if (customHoverForegroundColor != null) {
        return customHoverForegroundColor;
      }
      if (theme?.foregroundColor != null) {
        final themeColor = theme!.foregroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }
      return baseFg;
    }

    if (customForegroundColor != null) return customForegroundColor;
    if (theme?.foregroundColor != null) {
      final themeColor = theme!.foregroundColor!.resolve(states);
      if (themeColor != null) return themeColor;
    }

    return baseFg;
  }

  /// Resolves the focus ring indicator color.
  static Color resolveFocusBorderColor({
    required BuildContext context,
    FloatingActionButtonThemeDataConfig? theme,
    Color? customFocusBorderColor,
  }) {
    return customFocusBorderColor ??
        theme?.focusBorderColor ??
        context.colorScheme.outline;
  }

  /// Resolves the focus ring indicator stroke width.
  static double resolveFocusBorderWidth({
    FloatingActionButtonThemeDataConfig? theme,
    double? customFocusBorderWidth,
  }) {
    return customFocusBorderWidth ?? theme?.focusBorderWidth ?? 3.0;
  }

  /// Blends a state layer color over a base color with specified opacity.
  static Color applyStateLayer({
    required Color baseColor,
    required Color stateLayerColor,
    required double opacity,
  }) {
    if (baseColor == Colors.transparent) {
      return stateLayerColor.withValues(alpha: opacity);
    }
    return Color.alphaBlend(
      stateLayerColor.withValues(alpha: opacity),
      baseColor,
    );
  }
}
