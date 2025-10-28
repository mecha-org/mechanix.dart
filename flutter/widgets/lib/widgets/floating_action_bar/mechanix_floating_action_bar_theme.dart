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
    this.width,
    this.constraints,
    this.clipBehavior = Clip.none,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.foregroundDecoration,
  });

  final double? height;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final double? width;
  final BoxConstraints? constraints;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final AlignmentGeometry? alignment;
  final Decoration? foregroundDecoration;

  @override
  MechanixFloatingActionBarThemeData copyWith({
    double? height,
    Decoration? decoration,
    EdgeInsets? padding,
    double? width,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    AlignmentGeometry? alignment,
    Decoration? foregroundDecoration,
  }) {
    return MechanixFloatingActionBarThemeData(
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      width: width ?? this.width,
      constraints: constraints ?? this.constraints,
      margin: margin ?? this.margin,
      transform: transform ?? this.transform,
      transformAlignment: transformAlignment ?? this.transformAlignment,
      alignment: alignment ?? this.alignment,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('constraints', width));
    properties.add(DiagnosticsProperty('margin', margin));
    properties.add(DiagnosticsProperty('transform', transform));
    properties
        .add(DiagnosticsProperty('transformAlignment', transformAlignment));
    properties.add(DiagnosticsProperty('alignment', alignment));
    properties
        .add(DiagnosticsProperty('foregroundDecoration', foregroundDecoration));
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
      width: lerpDouble(width, o?.width, t) ?? width,
      constraints: BoxConstraints.lerp(constraints, o?.constraints, t),
      margin: EdgeInsetsGeometry.lerp(margin, o?.margin, t),
      transformAlignment:
          AlignmentGeometry.lerp(transformAlignment, o?.transformAlignment, t),
      alignment: AlignmentGeometry.lerp(alignment, o?.alignment, t),
      foregroundDecoration:
          Decoration.lerp(foregroundDecoration, o?.foregroundDecoration, t) ??
              foregroundDecoration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixFloatingActionBarThemeData &&
        height == other.height &&
        decoration == other.decoration &&
        width == other.width &&
        constraints == other.constraints &&
        margin == other.margin &&
        transform == other.transform &&
        transformAlignment == other.transformAlignment &&
        alignment == other.alignment &&
        foregroundDecoration == other.foregroundDecoration &&
        padding == other.padding;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      height,
      decoration,
      width,
      constraints,
      margin,
      transform,
      transformAlignment,
      alignment,
      foregroundDecoration,
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
