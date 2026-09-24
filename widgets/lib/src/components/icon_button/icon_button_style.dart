import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Helper for constructing Material [ButtonStyle] configurations for [MechanixIconButton].
abstract class IconButtonStyleResolver {
  const IconButtonStyleResolver();

  /// Creates a Material [ButtonStyle] for [MechanixIconButton] using variant,
  /// type, sizing spec, theme data, and custom color overrides.
  static ButtonStyle createButtonStyle({
    required BuildContext context,
    required IconButtonVariant variant,
    required IconButtonType type,
    required IconButtonSizeConfig sizeSpec,
    IconButtonThemeDataConfig? theme,
    Color? customBackgroundColor,
    Color? customHoverColor,
    Color? customPressedColor,
    Color? customDisabledColor,
    Color? customForegroundColor,
    Color? customHoverForegroundColor,
    Color? customPressedForegroundColor,
    Color? customDisabledForegroundColor,
    Color? customBorderColor,
    double? customBorderWidth,
    Color? customFocusBorderColor,
    Duration? duration,
    Curve? curve,
    bool showFocusIndicator = true,
  }) {
    final scheme = context.colorScheme;
    final shapeTheme = context.shape;

    // 1. Shape resolution:
    final borderRadius =
        theme?.borderRadius ??
        switch (type) {
          IconButtonType.square => shapeTheme.none,
          IconButtonType.rounded => shapeTheme.full,
        };
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);

    // 2. Default color resolution per variant:
    late final Color defaultBg;
    late final Color defaultFg;
    late final Color? defaultBorderColor;
    late final double defaultBorderWidth;

    switch (variant) {
      case IconButtonVariant.filled:
        defaultBg = scheme.primary;
        defaultFg = scheme.onSurface;
        defaultBorderColor = scheme.secondaryFixedDim;
        defaultBorderWidth = 1.0;
        break;
      case IconButtonVariant.tonal:
        defaultBg = scheme.secondary;
        defaultFg = scheme.onSecondaryFixed;
        defaultBorderColor = null;
        defaultBorderWidth = 0.0;
        break;
      case IconButtonVariant.outline:
        defaultBg = scheme.secondary;
        defaultFg = scheme.onSecondaryFixed;
        defaultBorderColor = scheme.outline;
        defaultBorderWidth = 2.0;
        break;
      case IconButtonVariant.standard:
        defaultBg = Colors.transparent;
        defaultFg = scheme.onSecondaryFixed;
        defaultBorderColor = null;
        defaultBorderWidth = 0.0;
        break;
    }

    final baseBg = customBackgroundColor ?? defaultBg;
    final baseFg = customForegroundColor ?? defaultFg;
    final baseBorderColor = customBorderColor ?? defaultBorderColor;
    final baseBorderWidth = customBorderWidth ?? defaultBorderWidth;

    // 3. State-aware background resolution
    final backgroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled) &&
          customDisabledColor != null) {
        return customDisabledColor;
      }
      if (states.contains(WidgetState.pressed) && customPressedColor != null) {
        return customPressedColor;
      }
      if (states.contains(WidgetState.hovered) && customHoverColor != null) {
        return customHoverColor;
      }
      if (customBackgroundColor != null) {
        return customBackgroundColor;
      }

      // Resolve from theme WidgetStateProperty if provided
      if (theme?.backgroundColor != null) {
        final themeColor = theme!.backgroundColor!.resolve(states);
        if (themeColor != null) return themeColor;
      }

      if (states.contains(WidgetState.disabled)) {
        return switch (variant) {
          IconButtonVariant.filled ||
          IconButtonVariant.tonal => scheme.onSurface.withValues(alpha: 0.10),
          IconButtonVariant.outline => Colors.transparent,
          IconButtonVariant.standard => Colors.transparent,
        };
      }

      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled => scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        final opacity = states.contains(WidgetState.pressed) ? 0.12 : 0.08;
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: stateLayerColor,
          opacity: opacity,
        );
      }

      return baseBg;
    });

    // 4. State-aware foreground resolution
    final foregroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled) &&
          customDisabledForegroundColor != null) {
        return customDisabledForegroundColor;
      }
      if (states.contains(WidgetState.pressed) &&
          customPressedForegroundColor != null) {
        return customPressedForegroundColor;
      }
      if (states.contains(WidgetState.hovered) &&
          customHoverForegroundColor != null) {
        return customHoverForegroundColor;
      }
      if (customForegroundColor != null) {
        return customForegroundColor;
      }

      // Resolve from theme WidgetStateProperty if provided
      if (theme?.foregroundColor != null) {
        final themeFg = theme!.foregroundColor!.resolve(states);
        if (themeFg != null) return themeFg;
      }

      if (states.contains(WidgetState.disabled)) {
        return scheme.onSurface.withValues(alpha: 0.38);
      }
      return baseFg;
    });

    // 5. State-aware border side resolution
    final sideProperty = WidgetStateProperty.resolveWith<BorderSide?>((states) {
      // Resolve from theme WidgetStateProperty if provided
      if (theme?.side != null) {
        final themeSide = theme!.side!.resolve(states);
        if (themeSide != null) return themeSide;
      }

      final defaultFocusColor = switch (variant) {
        IconButtonVariant.standard => scheme.secondary,
        _ => scheme.secondaryFixedDim,
      };

      final focusBorderColor = customFocusBorderColor ?? defaultFocusColor;
      final focusWidth = customBorderWidth ?? 3.0;

      if (states.contains(WidgetState.focused) && showFocusIndicator) {
        return BorderSide(color: focusBorderColor, width: focusWidth);
      }

      if (states.contains(WidgetState.disabled)) {
        return switch (variant) {
          IconButtonVariant.filled => BorderSide(
            color: scheme.secondary.withValues(alpha: 0.10),
            width: baseBorderWidth,
          ),
          IconButtonVariant.outline => BorderSide(
            color: (baseBorderColor ?? scheme.outline).withValues(alpha: 0.38),
            width: baseBorderWidth,
          ),
          IconButtonVariant.tonal || IconButtonVariant.standard =>
            baseBorderColor != null
                ? BorderSide(
                    color: baseBorderColor.withValues(alpha: 0.38),
                    width: baseBorderWidth,
                  )
                : null,
        };
      }

      if (baseBorderColor != null) {
        return BorderSide(color: baseBorderColor, width: baseBorderWidth);
      }

      return null;
    });

    // 6. Native tap target sizing
    final tapTargetSize = sizeSpec.minTapTargetSize > 0
        ? MaterialTapTargetSize.padded
        : MaterialTapTargetSize.shrinkWrap;

    final overlayColorProperty =
        WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.transparent;
      }
      if (states.contains(WidgetState.pressed)) {
        if (customPressedColor != null) {
          return customPressedColor;
        }
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled => scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        return stateLayerColor.withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        if (customHoverColor != null) {
          return customHoverColor;
        }
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled => scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        return stateLayerColor.withValues(alpha: 0.08);
      }
      return Colors.transparent;
    });

    return ButtonStyle(
      splashFactory: const TouchOptimizedSplashFactory(),
      overlayColor: overlayColorProperty,
      backgroundColor: backgroundColorProperty,
      foregroundColor: foregroundColorProperty,
      iconColor: foregroundColorProperty,
      side: sideProperty,
      shape: WidgetStateProperty.all(shape),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      minimumSize: WidgetStateProperty.all(
        Size(sizeSpec.dimension, sizeSpec.dimension),
      ),
      fixedSize: WidgetStateProperty.all(
        Size(sizeSpec.dimension, sizeSpec.dimension),
      ),
      alignment: Alignment.center,
      elevation: WidgetStateProperty.all(theme?.elevation ?? 0.0),
      iconSize: WidgetStateProperty.all(theme?.iconSize ?? sizeSpec.iconSize),
      animationDuration: duration ?? const Duration(milliseconds: 200),
      tapTargetSize: tapTargetSize,
      mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      }),
    );
  }
}

Color _applyStateLayer({
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
