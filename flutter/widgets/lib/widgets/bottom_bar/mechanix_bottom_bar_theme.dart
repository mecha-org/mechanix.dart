import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixBottomBarThemeData
    extends ThemeExtension<MechanixBottomBarThemeData> with Diagnosticable {
  const MechanixBottomBarThemeData(
      {this.height = 60,
      this.width = double.infinity,
      this.decoration = const BoxDecoration(
          color: Color(0xFF2E2E2E),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      this.iconColor,
      this.iconTheme});

  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final Color? iconColor;
  final MechanixBottomBarIconThemeData? iconTheme;

  @override
  MechanixBottomBarThemeData copyWith({
    double? height,
    double? width,
    BoxDecoration? decoration,
    Color? iconColor,
    MechanixBottomBarIconThemeData? iconTheme,
  }) {
    return MechanixBottomBarThemeData(
      height: height ?? this.height,
      width: width ?? this.width,
      decoration: decoration ?? this.decoration,
      iconColor: iconColor ?? this.iconColor,
      iconTheme: iconTheme ?? this.iconTheme,
    );
  }

  @override
  MechanixBottomBarThemeData lerp(
      ThemeExtension<MechanixBottomBarThemeData>? other, double t) {
    if (other is! MechanixBottomBarThemeData) return this;
    return MechanixBottomBarThemeData(
      height: lerpDouble(height, other.height, t),
      width: lerpDouble(width, other.width, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      decoration:
          BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties.add(DoubleProperty('width', width));
    properties.add(ColorProperty('iconColor', iconColor));
    properties.add(DiagnosticsProperty('iconTheme', iconTheme));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixBottomBarThemeData &&
        height == other.height &&
        decoration == other.decoration &&
        iconColor == other.iconColor &&
        iconTheme == other.iconTheme &&
        width == other.width;
  }

  @override
  int get hashCode {
    return Object.hash(height, decoration, width, iconColor, iconTheme);
  }
}

class MechanixBottomBarTheme extends InheritedTheme {
  const MechanixBottomBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixBottomBarThemeData data;

  static MechanixBottomBarThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixBottomBarTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixBottomBarThemeData>() ??
        const MechanixBottomBarThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixBottomBarTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixBottomBarTheme oldWidget) {
    return data != oldWidget.data;
  }
}

@immutable
class MechanixBottomBarIconThemeData
    extends ThemeExtension<MechanixBottomBarIconThemeData> with Diagnosticable {
  const MechanixBottomBarIconThemeData({
    this.iconColor,
    this.buttonStyle,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.constraints,
  });

  final Color? iconColor;
  final ButtonStyle? buttonStyle;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? iconSize;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final double? splashRadius;
  final BoxConstraints? constraints;

  @override
  MechanixBottomBarIconThemeData copyWith({
    Color? iconColor,
    ButtonStyle? buttonStyle,
    Color? focusColor,
    Color? hoverColor,
    Color? splashColor,
    Color? highlightColor,
    double? iconSize,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    double? splashRadius,
    BoxConstraints? constraints,
  }) {
    return MechanixBottomBarIconThemeData(
      iconColor: iconColor ?? this.iconColor,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      iconSize: iconSize ?? this.iconSize,
      visualDensity: visualDensity ?? this.visualDensity,
      padding: padding ?? this.padding,
      alignment: alignment ?? this.alignment,
      splashRadius: splashRadius ?? this.splashRadius,
      constraints: constraints ?? this.constraints,
    );
  }

  @override
  MechanixBottomBarIconThemeData lerp(
      ThemeExtension<MechanixBottomBarIconThemeData>? other, double t) {
    if (other is! MechanixBottomBarIconThemeData) return this;
    return MechanixBottomBarIconThemeData(
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      buttonStyle: ButtonStyle.lerp(buttonStyle, other.buttonStyle, t),
      focusColor: Color.lerp(focusColor, other.focusColor, t),
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t),
      splashColor: Color.lerp(splashColor, other.splashColor, t),
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      // visualDensity: VisualDensity.lerp(visualDensity!, other.visualDensity, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t),
      splashRadius: lerpDouble(splashRadius, other.splashRadius, t),
      constraints: BoxConstraints.lerp(constraints, other.constraints, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('iconColor', iconColor));
    properties.add(DiagnosticsProperty('buttonStyle', buttonStyle));
    properties.add(ColorProperty('focusColor', focusColor));
    properties.add(ColorProperty('hoverColor', hoverColor));
    properties.add(ColorProperty('splashColor', splashColor));
    properties.add(ColorProperty('highlightColor', highlightColor));
    properties.add(DoubleProperty('iconSize', iconSize));
    properties.add(DiagnosticsProperty('visualDensity', visualDensity));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DiagnosticsProperty('alignment', alignment));
    properties.add(DoubleProperty('splashRadius', splashRadius));
    properties.add(DiagnosticsProperty('constraints', constraints));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixBottomBarIconThemeData &&
        iconColor == other.iconColor &&
        buttonStyle == other.buttonStyle &&
        focusColor == other.focusColor &&
        hoverColor == other.hoverColor &&
        splashColor == other.splashColor &&
        highlightColor == other.highlightColor &&
        iconSize == other.iconSize &&
        visualDensity == other.visualDensity &&
        padding == other.padding &&
        alignment == other.alignment &&
        splashRadius == other.splashRadius &&
        constraints == other.constraints;
  }

  @override
  int get hashCode {
    return Object.hash(
      iconColor,
      buttonStyle,
      focusColor,
      hoverColor,
      splashColor,
      highlightColor,
      iconSize,
      visualDensity,
      padding,
      alignment,
      splashRadius,
      constraints,
    );
  }
}

class MechanixBottomBarIconTheme extends InheritedTheme {
  const MechanixBottomBarIconTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixBottomBarIconThemeData data;

  static MechanixBottomBarIconThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixBottomBarIconTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixBottomBarIconThemeData>() ??
        const MechanixBottomBarIconThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixBottomBarIconTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixBottomBarIconTheme oldWidget) {
    return data != oldWidget.data;
  }
}
