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
    bool isToggleable = false,
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
    Color? customSelectedBackgroundColor,
    Color? customSelectedHoverColor,
    Color? customSelectedPressedColor,
    Color? customSelectedForegroundColor,
    Color? customSelectedHoverForegroundColor,
    Color? customSelectedPressedForegroundColor,
    Color? customSelectedBorderColor,
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

    // 2. State-aware background resolution
    final backgroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled) &&
          customDisabledColor != null) {
        return customDisabledColor;
      }

      final isSelected = states.contains(WidgetState.selected);

      // Selected state background resolution
      if (isSelected) {
        if (states.contains(WidgetState.pressed)) {
          if (customSelectedPressedColor != null) {
            return customSelectedPressedColor;
          }
          if (customPressedColor != null) {
            return customPressedColor;
          }
          if (theme?.selectedPressedColor != null) {
            return theme!.selectedPressedColor;
          }
        }
        if (states.contains(WidgetState.hovered)) {
          if (customSelectedHoverColor != null) {
            return customSelectedHoverColor;
          }
          if (customHoverColor != null) {
            return customHoverColor;
          }
          if (theme?.selectedHoverColor != null) {
            return theme!.selectedHoverColor;
          }
        }
        if (customSelectedBackgroundColor != null) {
          return customSelectedBackgroundColor;
        }
        if (theme?.selectedBackgroundColor != null) {
          return theme!.selectedBackgroundColor;
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
            IconButtonVariant.outline => scheme.onSurface.withValues(
              alpha: 0.10,
            ),
            IconButtonVariant.standard => Colors.transparent,
          };
        }

        final selectedBaseBg = switch (variant) {
          IconButtonVariant.filled => scheme.primary,
          IconButtonVariant.tonal => scheme.secondaryContainer,
          IconButtonVariant.outline => scheme.inverseSurface,
          IconButtonVariant.standard => Colors.transparent,
        };

        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          final stateLayerColor = switch (variant) {
            IconButtonVariant.filled => scheme.onPrimary,
            IconButtonVariant.tonal => scheme.onSecondaryContainer,
            IconButtonVariant.outline => scheme.onInverseSurface,
            IconButtonVariant.standard => scheme.primary,
          };
          final opacity = states.contains(WidgetState.pressed) ? 0.12 : 0.08;
          return _applyStateLayer(
            baseColor: selectedBaseBg,
            stateLayerColor: stateLayerColor,
            opacity: opacity,
          );
        }

        return selectedBaseBg;
      }

      // Unselected / push button state background resolution
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

      final unselectedBaseBg = switch (variant) {
        IconButtonVariant.filled =>
          isToggleable ? scheme.secondary : scheme.primary,
        IconButtonVariant.tonal => scheme.secondary,
        IconButtonVariant.outline => scheme.secondary,
        IconButtonVariant.standard => Colors.transparent,
      };

      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled =>
            isToggleable ? scheme.primary : scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        final opacity = states.contains(WidgetState.pressed) ? 0.12 : 0.08;
        return _applyStateLayer(
          baseColor: unselectedBaseBg,
          stateLayerColor: stateLayerColor,
          opacity: opacity,
        );
      }

      return unselectedBaseBg;
    });

    // 3. State-aware foreground resolution
    final foregroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled) &&
          customDisabledForegroundColor != null) {
        return customDisabledForegroundColor;
      }

      final isSelected = states.contains(WidgetState.selected);

      // Selected state foreground resolution
      if (isSelected) {
        if (states.contains(WidgetState.pressed)) {
          if (customSelectedPressedForegroundColor != null) {
            return customSelectedPressedForegroundColor;
          }
          if (customPressedForegroundColor != null) {
            return customPressedForegroundColor;
          }
          if (theme?.selectedPressedForegroundColor != null) {
            return theme!.selectedPressedForegroundColor;
          }
        }
        if (states.contains(WidgetState.hovered)) {
          if (customSelectedHoverForegroundColor != null) {
            return customSelectedHoverForegroundColor;
          }
          if (customHoverForegroundColor != null) {
            return customHoverForegroundColor;
          }
          if (theme?.selectedHoverForegroundColor != null) {
            return theme!.selectedHoverForegroundColor;
          }
        }
        if (customSelectedForegroundColor != null) {
          return customSelectedForegroundColor;
        }
        if (theme?.selectedForegroundColor != null) {
          return theme!.selectedForegroundColor;
        }

        // Resolve from theme WidgetStateProperty if provided
        if (theme?.foregroundColor != null) {
          final themeFg = theme!.foregroundColor!.resolve(states);
          if (themeFg != null) return themeFg;
        }

        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.38);
        }

        return switch (variant) {
          IconButtonVariant.filled => scheme.onSurface,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline => scheme.onInverseSurface,
          IconButtonVariant.standard => scheme.primary,
        };
      }

      // Unselected / push button state foreground resolution
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

      return switch (variant) {
        IconButtonVariant.filled =>
          isToggleable ? scheme.primary : scheme.onSurface,
        IconButtonVariant.tonal => scheme.onSecondaryFixed,
        IconButtonVariant.outline => scheme.onSecondaryFixed,
        IconButtonVariant.standard => scheme.onSecondaryFixed,
      };
    });

    // 4. State-aware border side resolution
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

      final isSelected = states.contains(WidgetState.selected);

      if (states.contains(WidgetState.disabled)) {
        if (isSelected) {
          return switch (variant) {
            IconButtonVariant.filled => BorderSide(
              color: scheme.secondary.withValues(alpha: 0.10),
              width: customBorderWidth ?? 1.0,
            ),
            IconButtonVariant.tonal ||
            IconButtonVariant.outline ||
            IconButtonVariant.standard => null,
          };
        }
        return switch (variant) {
          IconButtonVariant.filled => BorderSide(
            color: scheme.secondary.withValues(alpha: 0.10),
            width: customBorderWidth ?? 1.0,
          ),
          IconButtonVariant.outline => BorderSide(
            color: (customBorderColor ?? scheme.outline).withValues(
              alpha: 0.38,
            ),
            width: customBorderWidth ?? 2.0,
          ),
          IconButtonVariant.tonal || IconButtonVariant.standard =>
            customBorderColor != null
                ? BorderSide(
                    color: customBorderColor.withValues(alpha: 0.38),
                    width: customBorderWidth ?? 1.0,
                  )
                : null,
        };
      }

      // Selected state border
      if (isSelected) {
        if (customSelectedBorderColor != null) {
          return BorderSide(
            color: customSelectedBorderColor,
            width:
                customBorderWidth ??
                (variant == IconButtonVariant.outline ? 2.0 : 1.0),
          );
        }
        if (theme?.selectedBorderColor != null) {
          return BorderSide(
            color: theme!.selectedBorderColor!,
            width:
                customBorderWidth ??
                (variant == IconButtonVariant.outline ? 2.0 : 1.0),
          );
        }
        return switch (variant) {
          IconButtonVariant.filled => BorderSide(
            color: scheme.secondaryFixedDim,
            width: customBorderWidth ?? 1.0,
          ),
          IconButtonVariant.outline ||
          IconButtonVariant.tonal ||
          IconButtonVariant.standard => null,
        };
      }

      // Unselected / push button border
      final baseBorderColor =
          customBorderColor ??
          switch (variant) {
            IconButtonVariant.filled => scheme.secondaryFixedDim,
            IconButtonVariant.outline => scheme.outline,
            IconButtonVariant.tonal || IconButtonVariant.standard => null,
          };
      final baseBorderWidth =
          customBorderWidth ??
          (baseBorderColor != null
              ? (variant == IconButtonVariant.outline ? 2.0 : 1.0)
              : 0.0);

      if (baseBorderColor != null && baseBorderWidth > 0) {
        return BorderSide(color: baseBorderColor, width: baseBorderWidth);
      }

      return null;
    });

    // 5. Native tap target sizing
    final tapTargetSize = sizeSpec.minTapTargetSize > 0
        ? MaterialTapTargetSize.padded
        : MaterialTapTargetSize.shrinkWrap;

    final overlayColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
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
