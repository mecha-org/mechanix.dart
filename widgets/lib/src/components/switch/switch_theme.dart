import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Configuration for styling [MechanixSwitch] instances via Flutter's [ThemeExtension].
///
/// Uses [WidgetStateProperty] to dynamically resolve visual styling across
/// states such as [WidgetState.selected] (ON state), [WidgetState.disabled],
/// [WidgetState.hovered], [WidgetState.pressed], and [WidgetState.focused].
@immutable
class SwitchThemeDataConfig extends ThemeExtension<SwitchThemeDataConfig>
    with Diagnosticable {
  const SwitchThemeDataConfig({
    this.trackColor,
    this.handleColor,
    this.thumbColor,
    this.handleBorder,
    this.textColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.textStyle,
  });

  /// Track background color across widget states.
  final WidgetStateProperty<Color?>? trackColor;

  /// Sliding handle/thumb color across widget states.
  final WidgetStateProperty<Color?>? handleColor;

  /// Alias for [handleColor] following standard Flutter Material switch conventions.
  final WidgetStateProperty<Color?>? thumbColor;

  /// Sliding handle border side across widget states.
  final WidgetStateProperty<BorderSide?>? handleBorder;

  /// Internal ON/OFF text label color across widget states.
  final WidgetStateProperty<Color?>? textColor;

  /// Focus border outline color across widget states.
  final WidgetStateProperty<Color?>? focusBorderColor;

  /// Focus border outline width.
  final double? focusBorderWidth;

  /// Text style for ON/OFF labels inside the track across widget states.
  final WidgetStateProperty<TextStyle?>? textStyle;

  @override
  SwitchThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? trackColor,
    WidgetStateProperty<Color?>? handleColor,
    WidgetStateProperty<Color?>? thumbColor,
    WidgetStateProperty<BorderSide?>? handleBorder,
    WidgetStateProperty<Color?>? textColor,
    WidgetStateProperty<Color?>? focusBorderColor,
    double? focusBorderWidth,
    WidgetStateProperty<TextStyle?>? textStyle,
  }) {
    return SwitchThemeDataConfig(
      trackColor: trackColor ?? this.trackColor,
      handleColor: handleColor ?? this.handleColor,
      thumbColor: thumbColor ?? this.thumbColor,
      handleBorder: handleBorder ?? this.handleBorder,
      textColor: textColor ?? this.textColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  SwitchThemeDataConfig merge(SwitchThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      trackColor: other.trackColor,
      handleColor: other.handleColor,
      thumbColor: other.thumbColor,
      handleBorder: other.handleBorder,
      textColor: other.textColor,
      focusBorderColor: other.focusBorderColor,
      focusBorderWidth: other.focusBorderWidth,
      textStyle: other.textStyle,
    );
  }

  @override
  SwitchThemeDataConfig lerp(
    ThemeExtension<SwitchThemeDataConfig>? other,
    double t,
  ) {
    if (other is! SwitchThemeDataConfig) return this;
    return SwitchThemeDataConfig(
      trackColor: WidgetStateProperty.lerp<Color?>(
        trackColor,
        other.trackColor,
        t,
        Color.lerp,
      ),
      handleColor: WidgetStateProperty.lerp<Color?>(
        handleColor,
        other.handleColor,
        t,
        Color.lerp,
      ),
      thumbColor: WidgetStateProperty.lerp<Color?>(
        thumbColor,
        other.thumbColor,
        t,
        Color.lerp,
      ),
      handleBorder: WidgetStateProperty.lerp<BorderSide?>(
        handleBorder,
        other.handleBorder,
        t,
        (a, b, t) =>
            BorderSide.lerp(a ?? BorderSide.none, b ?? BorderSide.none, t),
      ),
      textColor: WidgetStateProperty.lerp<Color?>(
        textColor,
        other.textColor,
        t,
        Color.lerp,
      ),
      focusBorderColor: WidgetStateProperty.lerp<Color?>(
        focusBorderColor,
        other.focusBorderColor,
        t,
        Color.lerp,
      ),
      focusBorderWidth: _lerpDouble(
        focusBorderWidth,
        other.focusBorderWidth,
        t,
      ),
      textStyle: WidgetStateProperty.lerp<TextStyle?>(
        textStyle,
        other.textStyle,
        t,
        TextStyle.lerp,
      ),
    );
  }

  static double? _lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('trackColor', trackColor));
    properties.add(DiagnosticsProperty('handleColor', handleColor));
    properties.add(DiagnosticsProperty('thumbColor', thumbColor));
    properties.add(DiagnosticsProperty('handleBorder', handleBorder));
    properties.add(DiagnosticsProperty('textColor', textColor));
    properties.add(DiagnosticsProperty('focusBorderColor', focusBorderColor));
    properties.add(DiagnosticsProperty('focusBorderWidth', focusBorderWidth));
    properties.add(DiagnosticsProperty('textStyle', textStyle));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwitchThemeDataConfig &&
        trackColor == other.trackColor &&
        handleColor == other.handleColor &&
        thumbColor == other.thumbColor &&
        handleBorder == other.handleBorder &&
        textColor == other.textColor &&
        focusBorderColor == other.focusBorderColor &&
        focusBorderWidth == other.focusBorderWidth &&
        textStyle == other.textStyle;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      trackColor,
      handleColor,
      thumbColor,
      handleBorder,
      textColor,
      focusBorderColor,
      focusBorderWidth,
      textStyle,
    ]);
  }
}

/// An inherited widget that defines the visual properties of [MechanixSwitch] inside a widget tree.
class MechanixSwitchTheme extends InheritedTheme {
  const MechanixSwitchTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final SwitchThemeDataConfig data;

  static SwitchThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixSwitchTheme>();
    return theme?.data ??
        Theme.of(context).extension<SwitchThemeDataConfig>() ??
        const SwitchThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSwitchTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixSwitchTheme oldWidget) {
    return data != oldWidget.data;
  }
}
