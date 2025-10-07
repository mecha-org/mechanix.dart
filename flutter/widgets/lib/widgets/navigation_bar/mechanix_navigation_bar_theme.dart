import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixNavigationBarThemeData
    extends ThemeExtension<MechanixNavigationBarThemeData> with Diagnosticable {
  const MechanixNavigationBarThemeData({
    this.leadingWidth,
    this.titleStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.actionsIconTheme,
    this.titleSpacing,
    this.scrolledUnderElevation,
    this.actionsPadding =
        const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
  });

  final double? leadingWidth;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final IconThemeData? actionsIconTheme;
  final double? titleSpacing;
  final double? scrolledUnderElevation;
  final EdgeInsetsGeometry? actionsPadding;

  @override
  MechanixNavigationBarThemeData copyWith({
    double? leadingWidth,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    IconThemeData? actionsIconTheme,
    double? titleSpacing,
    double? scrolledUnderElevation,
    EdgeInsetsGeometry? actionsPadding,
  }) {
    return MechanixNavigationBarThemeData(
      scrolledUnderElevation:
          scrolledUnderElevation ?? this.scrolledUnderElevation,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      titleStyle: titleStyle ?? this.titleStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      elevation: elevation ?? this.elevation,
      actionsIconTheme: actionsIconTheme ?? this.actionsIconTheme,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      actionsPadding: actionsPadding ?? this.actionsPadding,
    );
  }

  @override
  ThemeExtension<MechanixNavigationBarThemeData> lerp(
    ThemeExtension<MechanixNavigationBarThemeData>? other,
    double t,
  ) {
    final o = other as MechanixNavigationBarThemeData?;
    if (o == null) return this;

    return MechanixNavigationBarThemeData(
      scrolledUnderElevation:
          lerpDouble(scrolledUnderElevation, o.scrolledUnderElevation, t),
      leadingWidth: lerpDouble(leadingWidth, o.leadingWidth, t),
      titleStyle: TextStyle.lerp(titleStyle, o.titleStyle, t),
      backgroundColor: Color.lerp(backgroundColor, o.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, o.foregroundColor, t),
      elevation: lerpDouble(elevation, o.elevation, t),
      actionsIconTheme:
          IconThemeData.lerp(actionsIconTheme, o.actionsIconTheme, t),
      titleSpacing: lerpDouble(titleSpacing, o.titleSpacing, t),
      actionsPadding:
          EdgeInsetsGeometry.lerp(actionsPadding, o.actionsPadding, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DoubleProperty('leadingWidth', leadingWidth));
    properties.add(DoubleProperty('titleSpacing', titleSpacing));
    properties.add(DiagnosticsProperty<TextStyle?>('titleStyle', titleStyle));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('foregroundColor', foregroundColor));
    properties.add(DoubleProperty('elevation', elevation));
    properties
        .add(DoubleProperty('scrolledUnderElevation', scrolledUnderElevation));
    properties.add(DiagnosticsProperty<IconThemeData?>(
        'actionsIconTheme', actionsIconTheme));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixNavigationBarThemeData &&
        other.titleSpacing == titleSpacing &&
        other.titleStyle == titleStyle &&
        other.leadingWidth == leadingWidth &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.elevation == elevation &&
        other.scrolledUnderElevation == scrolledUnderElevation &&
        other.actionsIconTheme == actionsIconTheme &&
        other.actionsPadding == actionsPadding;
  }

  @override
  int get hashCode {
    return Object.hash(
      titleSpacing,
      titleStyle,
      leadingWidth,
      backgroundColor,
      foregroundColor,
      elevation,
      actionsIconTheme,
      scrolledUnderElevation,
      actionsPadding,
    );
  }
}

class MechanixNavigationBarTheme extends InheritedTheme {
  const MechanixNavigationBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixNavigationBarThemeData data;

  static MechanixNavigationBarThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixNavigationBarTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixNavigationBarThemeData>() ??
        const MechanixNavigationBarThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixNavigationBarTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixNavigationBarTheme oldWidget) {
    return data != oldWidget.data;
  }
}
