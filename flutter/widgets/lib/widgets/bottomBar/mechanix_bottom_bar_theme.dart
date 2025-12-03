import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixBottomBarThemeData
    extends ThemeExtension<MechanixBottomBarThemeData> with Diagnosticable {
  const MechanixBottomBarThemeData({
    this.height = 60,
    this.width = double.infinity,
    this.decoration = const BoxDecoration(
        color: Color(0xFF2E2E2E),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8))),
  });

  final double? height;
  final double? width;
  final BoxDecoration? decoration;

  @override
  MechanixBottomBarThemeData copyWith({
    Color? backgroundColor,
    double? height,
    double? width,
    BoxDecoration? decoration,
  }) {
    return MechanixBottomBarThemeData(
      height: height ?? this.height,
      width: width ?? this.width,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  MechanixBottomBarThemeData lerp(
      ThemeExtension<MechanixBottomBarThemeData>? other, double t) {
    if (other is! MechanixBottomBarThemeData) return this;
    return MechanixBottomBarThemeData(
      height: lerpDouble(height, other.height, t),
      width: lerpDouble(width, other.width, t),
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
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixBottomBarThemeData &&
        height == other.height &&
        decoration == other.decoration &&
        width == other.width;
  }

  @override
  int get hashCode {
    return Object.hash(height, decoration, width);
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
