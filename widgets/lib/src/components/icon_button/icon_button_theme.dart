import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Scoped Theme extension config for [MechanixIconButton].
@immutable
class IconButtonThemeDataConfig
    extends ThemeExtension<IconButtonThemeDataConfig>
    with Diagnosticable {
  const IconButtonThemeDataConfig({
    this.backgroundColor,
    this.foregroundColor,
    this.side,
    this.selectedBackgroundColor,
    this.selectedHoverColor,
    this.selectedPressedColor,
    this.selectedForegroundColor,
    this.selectedHoverForegroundColor,
    this.selectedPressedForegroundColor,
    this.selectedBorderColor,
    this.iconSize,
    this.borderRadius,
    this.elevation,
    this.focusIndicatorWidth,
  });

  /// State-aware background color property.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// State-aware foreground/icon color property.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// State-aware border side property.
  final WidgetStateProperty<BorderSide?>? side;

  /// Selected state color overrides.
  final Color? selectedBackgroundColor;
  final Color? selectedHoverColor;
  final Color? selectedPressedColor;
  final Color? selectedForegroundColor;
  final Color? selectedHoverForegroundColor;
  final Color? selectedPressedForegroundColor;
  final Color? selectedBorderColor;

  final double? iconSize;
  final BorderRadius? borderRadius;
  final double? elevation;
  final double? focusIndicatorWidth;

  @override
  IconButtonThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<BorderSide?>? side,
    Color? selectedBackgroundColor,
    Color? selectedHoverColor,
    Color? selectedPressedColor,
    Color? selectedForegroundColor,
    Color? selectedHoverForegroundColor,
    Color? selectedPressedForegroundColor,
    Color? selectedBorderColor,
    double? iconSize,
    BorderRadius? borderRadius,
    double? elevation,
    double? focusIndicatorWidth,
  }) {
    return IconButtonThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      side: side ?? this.side,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedHoverColor: selectedHoverColor ?? this.selectedHoverColor,
      selectedPressedColor: selectedPressedColor ?? this.selectedPressedColor,
      selectedForegroundColor:
          selectedForegroundColor ?? this.selectedForegroundColor,
      selectedHoverForegroundColor:
          selectedHoverForegroundColor ?? this.selectedHoverForegroundColor,
      selectedPressedForegroundColor:
          selectedPressedForegroundColor ?? this.selectedPressedForegroundColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      iconSize: iconSize ?? this.iconSize,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      focusIndicatorWidth: focusIndicatorWidth ?? this.focusIndicatorWidth,
    );
  }

  IconButtonThemeDataConfig merge(IconButtonThemeDataConfig? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      side: other.side,
      selectedBackgroundColor: other.selectedBackgroundColor,
      selectedHoverColor: other.selectedHoverColor,
      selectedPressedColor: other.selectedPressedColor,
      selectedForegroundColor: other.selectedForegroundColor,
      selectedHoverForegroundColor: other.selectedHoverForegroundColor,
      selectedPressedForegroundColor: other.selectedPressedForegroundColor,
      selectedBorderColor: other.selectedBorderColor,
      iconSize: other.iconSize,
      borderRadius: other.borderRadius,
      elevation: other.elevation,
      focusIndicatorWidth: other.focusIndicatorWidth,
    );
  }

  @override
  IconButtonThemeDataConfig lerp(
    ThemeExtension<IconButtonThemeDataConfig>? other,
    double t,
  ) {
    if (other is! IconButtonThemeDataConfig) return this;

    return IconButtonThemeDataConfig(
      backgroundColor: WidgetStateProperty.lerp<Color?>(
        backgroundColor,
        other.backgroundColor,
        t,
        Color.lerp,
      ),
      foregroundColor: WidgetStateProperty.lerp<Color?>(
        foregroundColor,
        other.foregroundColor,
        t,
        Color.lerp,
      ),
      side: WidgetStateProperty.lerp<BorderSide?>(side, other.side, t, (
        a,
        b,
        t,
      ) {
        if (a == null && b == null) {
          return null;
        }

        return BorderSide.lerp(a ?? BorderSide.none, b ?? BorderSide.none, t);
      }),
      selectedBackgroundColor: Color.lerp(
        selectedBackgroundColor,
        other.selectedBackgroundColor,
        t,
      ),
      selectedHoverColor: Color.lerp(
        selectedHoverColor,
        other.selectedHoverColor,
        t,
      ),
      selectedPressedColor: Color.lerp(
        selectedPressedColor,
        other.selectedPressedColor,
        t,
      ),
      selectedForegroundColor: Color.lerp(
        selectedForegroundColor,
        other.selectedForegroundColor,
        t,
      ),
      selectedHoverForegroundColor: Color.lerp(
        selectedHoverForegroundColor,
        other.selectedHoverForegroundColor,
        t,
      ),
      selectedPressedForegroundColor: Color.lerp(
        selectedPressedForegroundColor,
        other.selectedPressedForegroundColor,
        t,
      ),
      selectedBorderColor: Color.lerp(
        selectedBorderColor,
        other.selectedBorderColor,
        t,
      ),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      focusIndicatorWidth: lerpDouble(
        focusIndicatorWidth,
        other.focusIndicatorWidth,
        t,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('foregroundColor', foregroundColor));
    properties.add(DiagnosticsProperty('side', side));
    properties.add(
      DiagnosticsProperty('selectedBackgroundColor', selectedBackgroundColor),
    );
    properties.add(DiagnosticsProperty('selectedHoverColor', selectedHoverColor));
    properties.add(
      DiagnosticsProperty('selectedPressedColor', selectedPressedColor),
    );
    properties.add(
      DiagnosticsProperty('selectedForegroundColor', selectedForegroundColor),
    );
    properties.add(
      DiagnosticsProperty(
        'selectedHoverForegroundColor',
        selectedHoverForegroundColor,
      ),
    );
    properties.add(
      DiagnosticsProperty(
        'selectedPressedForegroundColor',
        selectedPressedForegroundColor,
      ),
    );
    properties.add(
      DiagnosticsProperty('selectedBorderColor', selectedBorderColor),
    );
    properties.add(DiagnosticsProperty('iconSize', iconSize));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('elevation', elevation));
    properties.add(
      DiagnosticsProperty('focusIndicatorWidth', focusIndicatorWidth),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IconButtonThemeDataConfig &&
        backgroundColor == other.backgroundColor &&
        foregroundColor == other.foregroundColor &&
        side == other.side &&
        selectedBackgroundColor == other.selectedBackgroundColor &&
        selectedHoverColor == other.selectedHoverColor &&
        selectedPressedColor == other.selectedPressedColor &&
        selectedForegroundColor == other.selectedForegroundColor &&
        selectedHoverForegroundColor == other.selectedHoverForegroundColor &&
        selectedPressedForegroundColor ==
            other.selectedPressedForegroundColor &&
        selectedBorderColor == other.selectedBorderColor &&
        iconSize == other.iconSize &&
        borderRadius == other.borderRadius &&
        elevation == other.elevation &&
        focusIndicatorWidth == other.focusIndicatorWidth;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      foregroundColor,
      side,
      selectedBackgroundColor,
      selectedHoverColor,
      selectedPressedColor,
      selectedForegroundColor,
      selectedHoverForegroundColor,
      selectedPressedForegroundColor,
      selectedBorderColor,
      iconSize,
      borderRadius,
      elevation,
      focusIndicatorWidth,
    );
  }
}

class MechanixIconButtonTheme extends InheritedTheme {
  const MechanixIconButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final IconButtonThemeDataConfig data;

  static IconButtonThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixIconButtonTheme>();

    return theme?.data ??
        Theme.of(context).extension<IconButtonThemeDataConfig>() ??
        const IconButtonThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixIconButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixIconButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}
