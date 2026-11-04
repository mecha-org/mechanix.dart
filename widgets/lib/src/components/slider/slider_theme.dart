import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Configuration for styling [MechanixSlider] instances via Flutter's [ThemeExtension].
///
/// Colors are [WidgetStateProperty]s resolved against [WidgetState.disabled],
/// [WidgetState.hovered], [WidgetState.focused] and [WidgetState.dragged].
@immutable
class SliderThemeDataConfig extends ThemeExtension<SliderThemeDataConfig>
    with Diagnosticable {
  const SliderThemeDataConfig({
    this.activeTickColor,
    this.inactiveTickColor,
    this.pointerColor,
    this.valueLabelStyle,
  });

  /// Creates a standard [SliderThemeDataConfig] configured with Mechanix design tokens.
  factory SliderThemeDataConfig.standard(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return SliderThemeDataConfig(
      activeTickColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSecondaryFixed.withValues(alpha: 0.16);
        }
        return colorScheme.onSecondaryFixed;
      }),
      inactiveTickColor: WidgetStatePropertyAll(colorScheme.secondaryFixedDim),
      pointerColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSecondary.withValues(alpha: 0.32);
        }
        return colorScheme.onSecondary;
      }),
      valueLabelStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Color of the ticks between the minimum and the current value.
  final WidgetStateProperty<Color?>? activeTickColor;

  /// Color of the ticks between the current value and the maximum.
  final WidgetStateProperty<Color?>? inactiveTickColor;

  /// Color of the pointer marking the current value.
  final WidgetStateProperty<Color?>? pointerColor;

  /// Text style of the value label shown next to the pointer while dragging.
  final TextStyle? valueLabelStyle;

  @override
  SliderThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? activeTickColor,
    WidgetStateProperty<Color?>? inactiveTickColor,
    WidgetStateProperty<Color?>? pointerColor,
    TextStyle? valueLabelStyle,
  }) {
    return SliderThemeDataConfig(
      activeTickColor: activeTickColor ?? this.activeTickColor,
      inactiveTickColor: inactiveTickColor ?? this.inactiveTickColor,
      pointerColor: pointerColor ?? this.pointerColor,
      valueLabelStyle: valueLabelStyle ?? this.valueLabelStyle,
    );
  }

  /// Returns a copy of this config with the non-null fields of [other] applied.
  SliderThemeDataConfig merge(SliderThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      activeTickColor: other.activeTickColor,
      inactiveTickColor: other.inactiveTickColor,
      pointerColor: other.pointerColor,
      valueLabelStyle:
          valueLabelStyle?.merge(other.valueLabelStyle) ??
          other.valueLabelStyle,
    );
  }

  @override
  SliderThemeDataConfig lerp(
    ThemeExtension<SliderThemeDataConfig>? other,
    double t,
  ) {
    if (other is! SliderThemeDataConfig) return this;
    return SliderThemeDataConfig(
      activeTickColor: WidgetStateProperty.lerp<Color?>(
        activeTickColor,
        other.activeTickColor,
        t,
        Color.lerp,
      ),
      inactiveTickColor: WidgetStateProperty.lerp<Color?>(
        inactiveTickColor,
        other.inactiveTickColor,
        t,
        Color.lerp,
      ),
      pointerColor: WidgetStateProperty.lerp<Color?>(
        pointerColor,
        other.pointerColor,
        t,
        Color.lerp,
      ),
      valueLabelStyle: TextStyle.lerp(
        valueLabelStyle,
        other.valueLabelStyle,
        t,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('activeTickColor', activeTickColor));
    properties.add(DiagnosticsProperty('inactiveTickColor', inactiveTickColor));
    properties.add(DiagnosticsProperty('pointerColor', pointerColor));
    properties.add(DiagnosticsProperty('valueLabelStyle', valueLabelStyle));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderThemeDataConfig &&
        activeTickColor == other.activeTickColor &&
        inactiveTickColor == other.inactiveTickColor &&
        pointerColor == other.pointerColor &&
        valueLabelStyle == other.valueLabelStyle;
  }

  @override
  int get hashCode => Object.hash(
    activeTickColor,
    inactiveTickColor,
    pointerColor,
    valueLabelStyle,
  );
}

/// An inherited widget that defines the visual properties of [MechanixSlider] inside a widget tree.
class MechanixSliderTheme extends InheritedTheme {
  const MechanixSliderTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The [SliderThemeDataConfig] provided to descendants.
  final SliderThemeDataConfig data;

  /// Returns the nearest [SliderThemeDataConfig] from the given [context].
  ///
  /// Falls back to the [ThemeData] extension, then to
  /// [SliderThemeDataConfig.standard] built from the ambient [ThemeData].
  static SliderThemeDataConfig of(BuildContext context) {
    final themeData = Theme.of(context);
    final standard = _standardCache[themeData] ??=
        SliderThemeDataConfig.standard(
          themeData.colorScheme,
          themeData.textTheme,
        );

    final ext = themeData.extension<SliderThemeDataConfig>();
    final inherited = context
        .dependOnInheritedWidgetOfExactType<MechanixSliderTheme>();

    return standard.merge(ext).merge(inherited?.data);
  }

  /// Default configs keyed by the [ThemeData] they were built from, so a
  /// rebuild does not recreate the state-resolving closures.
  static final Expando<SliderThemeDataConfig> _standardCache =
      Expando<SliderThemeDataConfig>();

  @override
  bool updateShouldNotify(MechanixSliderTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSliderTheme(data: data, child: child);
  }
}
