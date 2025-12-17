import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixBottomSheetThemeData
    extends ThemeExtension<MechanixBottomSheetThemeData> with Diagnosticable {
  const MechanixBottomSheetThemeData({
    this.width = double.infinity,
    this.decoration = const BoxDecoration(
      color: Color(0xFF2E2E2E),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          // blurRadius: 8,
          // offset: Offset(0, -2),
        ),
      ],
    ),
  });

  final double? width;
  final BoxDecoration decoration;

  @override
  MechanixBottomSheetThemeData copyWith({
    double? width,
    BoxDecoration? decoration,
  }) {
    return MechanixBottomSheetThemeData(
      decoration: decoration ?? this.decoration,
      width: width ?? this.width,
    );
  }

  @override
  MechanixBottomSheetThemeData lerp(
      ThemeExtension<MechanixBottomSheetThemeData>? other, double t) {
    if (other is! MechanixBottomSheetThemeData) return this;
    return MechanixBottomSheetThemeData(
      decoration:
          BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
      width: lerpDouble(width, other.width, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties.add(DoubleProperty('width', width));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixBottomSheetThemeData &&
        decoration == other.decoration &&
        width == other.width;
  }

  @override
  int get hashCode {
    return Object.hash(decoration, width);
  }
}

class MechanixBottomSheetTheme extends InheritedTheme {
  const MechanixBottomSheetTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixBottomSheetThemeData data;

  static MechanixBottomSheetThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixBottomSheetTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixBottomSheetThemeData>() ??
        const MechanixBottomSheetThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixBottomSheetTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixBottomSheetTheme oldWidget) {
    return data != oldWidget.data;
  }
}
