import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme configuration for [MechanixRadio].
///
/// Can be provided globally via [ThemeData.extensions] or scoped using
/// [MechanixRadioTheme].
@immutable
class RadioThemeDataConfig extends ThemeExtension<RadioThemeDataConfig>
    with Diagnosticable {
  const RadioThemeDataConfig({this.labelStyle, this.labelSpacing});

  /// The text style applied to the radio label.
  final TextStyle? labelStyle;

  /// The horizontal spacing between the radio and its label.
  final double? labelSpacing;

  @override
  RadioThemeDataConfig copyWith({TextStyle? labelStyle, double? labelSpacing}) {
    return RadioThemeDataConfig(
      labelStyle: labelStyle ?? this.labelStyle,
      labelSpacing: labelSpacing ?? this.labelSpacing,
    );
  }

  /// Merges another [RadioThemeDataConfig] into this configuration.
  RadioThemeDataConfig merge(RadioThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      labelStyle: labelStyle != null
          ? labelStyle!.merge(other.labelStyle)
          : other.labelStyle,
      labelSpacing: other.labelSpacing ?? labelSpacing,
    );
  }

  @override
  RadioThemeDataConfig lerp(
    ThemeExtension<RadioThemeDataConfig>? other,
    double t,
  ) {
    if (other is! RadioThemeDataConfig) return this;
    return RadioThemeDataConfig(
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t),
      labelSpacing: lerpDouble(labelSpacing, other.labelSpacing, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('labelStyle', labelStyle));
    properties.add(DoubleProperty('labelSpacing', labelSpacing));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioThemeDataConfig &&
        other.labelStyle == labelStyle &&
        other.labelSpacing == labelSpacing;
  }

  @override
  int get hashCode {
    return Object.hash(labelStyle, labelSpacing);
  }
}

/// An inherited theme that defines visual properties for [MechanixRadio]
/// within a subtree.
class MechanixRadioTheme extends InheritedTheme {
  const MechanixRadioTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration applied to descendent [MechanixRadio] widgets.
  final RadioThemeDataConfig data;

  /// Returns the nearest [RadioThemeDataConfig] up the widget tree, or a
  /// default instance if none is found.
  static RadioThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixRadioTheme>();
    return theme?.data ??
        Theme.of(context).extension<RadioThemeDataConfig>() ??
        const RadioThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixRadioTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixRadioTheme oldWidget) {
    return data != oldWidget.data;
  }
}
