import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme extension configuration for [MechanixFloatingActionButton].
@immutable
class FloatingActionButtonThemeDataConfig
    extends ThemeExtension<FloatingActionButtonThemeDataConfig>
    with Diagnosticable {
  const FloatingActionButtonThemeDataConfig({
    this.backgroundColor,
    this.foregroundColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.elevation,
    this.borderRadius,
    this.iconSize,
  });

  /// State-aware background color property.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// State-aware foreground / icon color property.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// Custom focus ring indicator color.
  final Color? focusBorderColor;

  /// Custom focus ring indicator width.
  final double? focusBorderWidth;

  /// Elevation of the button.
  final double? elevation;

  /// Border radius of the button.
  final BorderRadius? borderRadius;

  /// Icon size override.
  final double? iconSize;

  @override
  FloatingActionButtonThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    Color? focusBorderColor,
    double? focusBorderWidth,
    double? elevation,
    BorderRadius? borderRadius,
    double? iconSize,
  }) {
    return FloatingActionButtonThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  /// Merges this configuration with another [FloatingActionButtonThemeDataConfig].
  FloatingActionButtonThemeDataConfig merge(
    FloatingActionButtonThemeDataConfig? other,
  ) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      focusBorderColor: other.focusBorderColor,
      focusBorderWidth: other.focusBorderWidth,
      elevation: other.elevation,
      borderRadius: other.borderRadius,
      iconSize: other.iconSize,
    );
  }

  @override
  FloatingActionButtonThemeDataConfig lerp(
    ThemeExtension<FloatingActionButtonThemeDataConfig>? other,
    double t,
  ) {
    if (other is! FloatingActionButtonThemeDataConfig) return this;

    return FloatingActionButtonThemeDataConfig(
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
      focusBorderColor: Color.lerp(focusBorderColor, other.focusBorderColor, t),
      focusBorderWidth: lerpDouble(focusBorderWidth, other.focusBorderWidth, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('foregroundColor', foregroundColor));
    properties.add(ColorProperty('focusBorderColor', focusBorderColor));
    properties.add(DoubleProperty('focusBorderWidth', focusBorderWidth));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DoubleProperty('iconSize', iconSize));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FloatingActionButtonThemeDataConfig &&
        backgroundColor == other.backgroundColor &&
        foregroundColor == other.foregroundColor &&
        focusBorderColor == other.focusBorderColor &&
        focusBorderWidth == other.focusBorderWidth &&
        elevation == other.elevation &&
        borderRadius == other.borderRadius &&
        iconSize == other.iconSize;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      foregroundColor,
      focusBorderColor,
      focusBorderWidth,
      elevation,
      borderRadius,
      iconSize,
    );
  }
}

/// An [InheritedTheme] that provides [FloatingActionButtonThemeDataConfig] to its descendants.
class MechanixFloatingActionButtonTheme extends InheritedTheme {
  const MechanixFloatingActionButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final FloatingActionButtonThemeDataConfig data;

  /// Retrieves the enclosing [FloatingActionButtonThemeDataConfig], falling back to
  /// the theme extension or a default instance.
  static FloatingActionButtonThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<
          MechanixFloatingActionButtonTheme
        >();

    return theme?.data ??
        Theme.of(context).extension<FloatingActionButtonThemeDataConfig>() ??
        const FloatingActionButtonThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixFloatingActionButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixFloatingActionButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}
