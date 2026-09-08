import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme configuration for [MechanixCheckbox].
///
/// Can be provided globally via [ThemeData.extensions] or scoped using
/// [MechanixCheckboxTheme].
@immutable
class CheckboxThemeDataConfig extends ThemeExtension<CheckboxThemeDataConfig>
    with Diagnosticable {
  const CheckboxThemeDataConfig({
    this.focusRingColor,
    this.focusRingWidth,
    this.focusRingRadius,
    this.showFocusIndicator,
    this.labelStyle,
    this.labelSpacing,
  });

  /// The color of the outer focus indicator ring.
  final Color? focusRingColor;

  /// The line width of the outer focus indicator ring.
  final double? focusRingWidth;

  /// The radius of the outer focus indicator ring.
  final double? focusRingRadius;

  /// Whether the outer focus indicator ring should be displayed when focused.
  final bool? showFocusIndicator;

  /// The text style applied to the checkbox label.
  final TextStyle? labelStyle;

  /// The horizontal spacing between the checkbox and its label.
  final double? labelSpacing;

  @override
  CheckboxThemeDataConfig copyWith({
    Color? focusRingColor,
    double? focusRingWidth,
    double? focusRingRadius,
    bool? showFocusIndicator,
    TextStyle? labelStyle,
    double? labelSpacing,
  }) {
    return CheckboxThemeDataConfig(
      focusRingColor: focusRingColor ?? this.focusRingColor,
      focusRingWidth: focusRingWidth ?? this.focusRingWidth,
      focusRingRadius: focusRingRadius ?? this.focusRingRadius,
      showFocusIndicator: showFocusIndicator ?? this.showFocusIndicator,
      labelStyle: labelStyle ?? this.labelStyle,
      labelSpacing: labelSpacing ?? this.labelSpacing,
    );
  }

  /// Merges another [CheckboxThemeDataConfig] into this configuration.
  CheckboxThemeDataConfig merge(CheckboxThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      focusRingColor: other.focusRingColor,
      focusRingWidth: other.focusRingWidth,
      focusRingRadius: other.focusRingRadius,
      showFocusIndicator: other.showFocusIndicator,
      labelStyle: other.labelStyle,
      labelSpacing: other.labelSpacing,
    );
  }

  @override
  CheckboxThemeDataConfig lerp(
    ThemeExtension<CheckboxThemeDataConfig>? other,
    double t,
  ) {
    if (other is! CheckboxThemeDataConfig) return this;
    return CheckboxThemeDataConfig(
      focusRingColor: Color.lerp(focusRingColor, other.focusRingColor, t),
      focusRingWidth: lerpDouble(focusRingWidth, other.focusRingWidth, t),
      focusRingRadius: lerpDouble(focusRingRadius, other.focusRingRadius, t),
      showFocusIndicator: t < 0.5 ? showFocusIndicator : other.showFocusIndicator,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t),
      labelSpacing: lerpDouble(labelSpacing, other.labelSpacing, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('focusRingColor', focusRingColor));
    properties.add(DoubleProperty('focusRingWidth', focusRingWidth));
    properties.add(DoubleProperty('focusRingRadius', focusRingRadius));
    properties.add(DiagnosticsProperty('showFocusIndicator', showFocusIndicator));
    properties.add(DiagnosticsProperty('labelStyle', labelStyle));
    properties.add(DoubleProperty('labelSpacing', labelSpacing));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckboxThemeDataConfig &&
        other.focusRingColor == focusRingColor &&
        other.focusRingWidth == focusRingWidth &&
        other.focusRingRadius == focusRingRadius &&
        other.showFocusIndicator == showFocusIndicator &&
        other.labelStyle == labelStyle &&
        other.labelSpacing == labelSpacing;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      focusRingColor,
      focusRingWidth,
      focusRingRadius,
      showFocusIndicator,
      labelStyle,
      labelSpacing,
    ]);
  }
}

/// An inherited theme that defines visual properties for [MechanixCheckbox]
/// within a subtree.
class MechanixCheckboxTheme extends InheritedTheme {
  const MechanixCheckboxTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration applied to descendent [MechanixCheckbox] widgets.
  final CheckboxThemeDataConfig data;

  /// Returns the nearest [CheckboxThemeDataConfig] up the widget tree, or a
  /// default instance if none is found.
  static CheckboxThemeDataConfig of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixCheckboxTheme>();
    return theme?.data ??
        Theme.of(context).extension<CheckboxThemeDataConfig>() ??
        const CheckboxThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixCheckboxTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixCheckboxTheme oldWidget) {
    return data != oldWidget.data;
  }
}
