import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixFloatingActionBarThemeData
    extends ThemeExtension<MechanixFloatingActionBarThemeData>
    with Diagnosticable {
  const MechanixFloatingActionBarThemeData({
    this.height = 50,
    this.decoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });

  final double? height;
  final Decoration? decoration;
  final EdgeInsets? padding;

  @override
  MechanixFloatingActionBarThemeData copyWith({
    double? height,
    Decoration? decoration,
    EdgeInsets? padding,
  }) {
    return MechanixFloatingActionBarThemeData(
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties.add(DiagnosticsProperty('padding', padding));
  }

  @override
  ThemeExtension<MechanixFloatingActionBarThemeData> lerp(
    ThemeExtension<MechanixFloatingActionBarThemeData>? other,
    double t,
  ) {
    final o = other as MechanixFloatingActionBarThemeData?;
    return MechanixFloatingActionBarThemeData(
      height: lerpDouble(height, o?.height, t) ?? height,
      decoration: Decoration.lerp(decoration, o?.decoration, t) ?? decoration,
      padding: EdgeInsets.lerp(padding, o?.padding, t) ?? padding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixFloatingActionBarThemeData &&
        height == other.height &&
        decoration == other.decoration &&
        padding == other.padding;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      height,
      decoration,
      padding,
    ]);
  }
}

class MechanixFloatingActionBarTheme extends InheritedTheme {
  const MechanixFloatingActionBarTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final MechanixFloatingActionBarThemeData style;

  static MechanixFloatingActionBarThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixFloatingActionBarTheme>();
    return theme?.style ??
        Theme.of(context).extension<MechanixFloatingActionBarThemeData>() ??
        const MechanixFloatingActionBarThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixFloatingActionBarTheme(
      style: style,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(MechanixFloatingActionBarTheme oldWidget) {
    return style != oldWidget.style;
  }
}
