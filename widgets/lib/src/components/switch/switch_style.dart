import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Resolved styling properties for [MechanixSwitch] computed based on state.
class ResolvedSwitchStyle {
  const ResolvedSwitchStyle({
    required this.trackColor,
    required this.handleColor,
    required this.handleBorder,
    required this.textColor,
    required this.focusBorder,
    this.textStyle,
  });

  final Color trackColor;
  final Color handleColor;
  final BorderSide handleBorder;
  final Color textColor;
  final BorderSide? focusBorder;
  final TextStyle? textStyle;
}

/// Style resolver helper for [MechanixSwitch].
abstract class SwitchStyleResolver {
  const SwitchStyleResolver();

  /// Computes state-aware [ResolvedSwitchStyle] for a [MechanixSwitch].
  static ResolvedSwitchStyle resolveStyle({
    required BuildContext context,
    required bool value,
    required bool isEnabled,
    required bool isHovered,
    required bool isPressed,
    required bool isFocused,
    SwitchThemeDataConfig? theme,
  }) {
    final scheme = context.colorScheme;
    final Set<WidgetState> states = {
      if (!isEnabled) WidgetState.disabled,
      if (isPressed && isEnabled) WidgetState.pressed,
      if (isHovered && isEnabled) WidgetState.hovered,
      if (isFocused && isEnabled) WidgetState.focused,
      if (value) WidgetState.selected,
    };

    // 1. Track Color
    final trackColor =
        theme?.trackColor?.resolve(states) ?? scheme.secondaryFixedDim;

    // 2. Handle Color & Border
    final effectiveHandleProp = theme?.handleColor ?? theme?.thumbColor;
    final Color handleColor =
        effectiveHandleProp?.resolve(states) ??
        (!isEnabled
            ? (value
                  ? scheme.primary.withValues(alpha: 0.52)
                  : scheme.onSecondaryFixedVariant.withValues(alpha: 0.16))
            : isPressed
            ? (value ? scheme.primaryFixed : scheme.onSurfaceVariant)
            : (value ? scheme.primary : scheme.onSecondaryFixedVariant));

    BorderSide handleBorder = BorderSide.none;
    if (isEnabled) {
      if (theme?.handleBorder != null) {
        handleBorder = theme!.handleBorder!.resolve(states) ?? BorderSide.none;
      } else if (isHovered) {
        handleBorder = BorderSide(
          color: value
              ? scheme.onPrimary.withValues(alpha: 0.16)
              : scheme.primary.withValues(alpha: 0.16),
          width: 2.0,
        );
      }
    }

    // 3. Text Color
    final Color textColor =
        theme?.textColor?.resolve(states) ??
        (!isEnabled
            ? (value
                  ? scheme.onPrimary.withValues(alpha: 0.16)
                  : scheme.onSecondaryContainer.withValues(alpha: 0.16))
            : (value ? scheme.onPrimary : scheme.onSecondaryContainer));

    // 4. Focus Border
    BorderSide? focusBorder;
    if (isFocused && isEnabled) {
      final borderColor =
          theme?.focusBorderColor?.resolve(states) ?? scheme.outline;
      final borderWidth = theme?.focusBorderWidth ?? 1.0;
      focusBorder = BorderSide(color: borderColor, width: borderWidth);
    }

    // 5. Text Style
    final textStyle = theme?.textStyle?.resolve(states);

    return ResolvedSwitchStyle(
      trackColor: trackColor,
      handleColor: handleColor,
      handleBorder: handleBorder,
      textColor: textColor,
      focusBorder: focusBorder,
      textStyle: textStyle,
    );
  }
}
