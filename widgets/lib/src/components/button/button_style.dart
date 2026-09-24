import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Helper for constructing Material [ButtonStyle] configurations for [MechanixButton].
abstract class ButtonStyleResolver {
  const ButtonStyleResolver();

  /// Creates a Material [ButtonStyle] for [MechanixButton] using variant,
  /// type, sizing spec, theme data, and custom color overrides.
  static ButtonStyle createButtonStyle({
    required BuildContext context,
    required ButtonVariant variant,
    required ButtonType type,
    required ButtonSizeConfig sizeSpec,
    ButtonThemeDataConfig? theme,
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
    final isOutline = variant == ButtonVariant.outline;
    final isText = variant == ButtonVariant.text;
    final shapeTheme = context.shape;

    // 1. Shape resolution:
    // Custom theme.borderRadius -> ShapeTheme.full (rounded) -> ShapeTheme.none (square)
    final borderRadius =
        theme?.borderRadius ??
        switch (type) {
          ButtonType.square => shapeTheme.none,
          ButtonType.rounded => shapeTheme.full,
        };
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);

    // 2. Color resolution pipeline:
    // Instance Override -> Scoped Theme -> Theme ColorScheme default
    final defaultBg =
        (isOutline || isText) ? Colors.transparent : scheme.secondaryFixedDim;
    final defaultFg =
        (isOutline || isText) ? scheme.onSurface : scheme.onPrimary;

    final baseBg = customBackgroundColor ?? theme?.backgroundColor ?? defaultBg;
    final baseFg = customForegroundColor ?? theme?.foregroundColor ?? defaultFg;
    final baseBorderColor = customBorderColor ?? theme?.borderColor;
    final baseBorderWidth = customBorderWidth ?? theme?.borderWidth;

    // 3. State-aware background
    final backgroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (isText) {
        if (states.contains(WidgetState.disabled)) {
          return customDisabledColor ??
              theme?.disabledColor ??
              Colors.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return customPressedColor ??
              theme?.pressedColor ??
              Colors.transparent;
        }
        if (states.contains(WidgetState.hovered)) {
          return customHoverColor ??
              theme?.hoverColor ??
              Colors.transparent;
        }
        return customBackgroundColor ??
            theme?.backgroundColor ??
            Colors.transparent;
      }

      if (states.contains(WidgetState.disabled)) {
        return customDisabledColor ??
            theme?.disabledColor ??
            (isOutline
                ? Colors.transparent
                : scheme.onSurface.withValues(alpha: 0.10));
      }
      if (states.contains(WidgetState.pressed)) {
        if (customPressedColor != null || theme?.pressedColor != null) {
          return customPressedColor ?? theme?.pressedColor;
        }
        final layerColor = isOutline
            ? scheme.onSurfaceVariant
            : scheme.onPrimary;
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: layerColor,
          opacity: 0.12,
        );
      }
      if (states.contains(WidgetState.hovered)) {
        if (customHoverColor != null || theme?.hoverColor != null) {
          return customHoverColor ?? theme?.hoverColor;
        }
        final layerColor = isOutline
            ? scheme.onSurfaceVariant
            : scheme.onPrimary;
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: layerColor,
          opacity: 0.08,
        );
      }
      if (states.contains(WidgetState.focused)) {
        final layerColor =
            isOutline ? Colors.transparent : scheme.onPrimary;
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: layerColor,
          opacity: 0.12,
        );
      }
      return baseBg;
    });

    // 4. State-aware foreground
    final foregroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        return customDisabledForegroundColor ??
            theme?.disabledForegroundColor ??
            scheme.onSurface.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.pressed)) {
        return customPressedForegroundColor ??
            theme?.pressedForegroundColor ??
            baseFg;
      }
      if (states.contains(WidgetState.hovered)) {
        return customHoverForegroundColor ??
            theme?.hoverForegroundColor ??
            (isText ? scheme.onSecondaryContainer : baseFg);
      }
      return baseFg;
    });

    // 5. State-aware border side
    final sideProperty = WidgetStateProperty.resolveWith<BorderSide?>((states) {
      if (states.contains(WidgetState.focused) && showFocusIndicator) {
        final focColor =
            customFocusBorderColor ??
            theme?.focusBorderColor ??
            (isOutline
                ? (baseBorderColor ?? scheme.outline)
                : scheme.secondaryFixedDim);
        final focWidth = customBorderWidth ?? theme?.borderWidth ?? 3.0;
        return BorderSide(color: focColor, width: focWidth);
      }

      if (isOutline) {
        final w = baseBorderWidth ?? 1.0;
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: baseBorderColor ?? scheme.onSurface.withValues(alpha: 0.10),
            width: w,
          );
        }
        return BorderSide(color: baseBorderColor ?? scheme.outline, width: w);
      } else if (isText) {
        if (states.contains(WidgetState.focused) && showFocusIndicator) {
          final focColor =
              customFocusBorderColor ??
              theme?.focusBorderColor ??
              baseBorderColor ??
              scheme.outline;
          final focWidth = customBorderWidth ?? theme?.borderWidth ?? 3.0;
          return BorderSide(color: focColor, width: focWidth);
        }
        if (baseBorderColor != null) {
          final w = baseBorderWidth ?? 0.0;
          return BorderSide(color: baseBorderColor, width: w);
        }
        return null;
      } else {
        if (baseBorderColor != null) {
          final w = baseBorderWidth ?? 0.0;
          return BorderSide(color: baseBorderColor, width: w);
        }
        return null;
      }
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
        if (customPressedColor != null || theme?.pressedColor != null) {
          return customPressedColor ?? theme?.pressedColor;
        }
        final layerColor = isOutline
            ? scheme.onSurfaceVariant
            : (isText ? scheme.onSurface : scheme.onPrimary);
        return layerColor.withValues(alpha: 0.12);
      }
      if (states.contains(WidgetState.hovered)) {
        if (customHoverColor != null || theme?.hoverColor != null) {
          return customHoverColor ?? theme?.hoverColor;
        }
        final layerColor = isOutline
            ? scheme.onSurfaceVariant
            : (isText ? scheme.onSurface : scheme.onPrimary);
        return layerColor.withValues(alpha: 0.08);
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
      padding: WidgetStateProperty.all(theme?.padding ?? sizeSpec.padding),
      minimumSize: WidgetStateProperty.all(Size(0, sizeSpec.height)),
      fixedSize: WidgetStateProperty.all(Size.fromHeight(sizeSpec.height)),
      alignment: Alignment.center,
      elevation: WidgetStateProperty.all(theme?.elevation ?? 0.0),
      textStyle: WidgetStateProperty.all(
        (theme?.textStyle ?? sizeSpec.labelTextStyle).copyWith(color: null),
      ),
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
  return Color.alphaBlend(
    stateLayerColor.withValues(alpha: opacity),
    baseColor,
  );
}
