import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixBottomSheetThemeData
    extends ThemeExtension<MechanixBottomSheetThemeData> with Diagnosticable {
  const MechanixBottomSheetThemeData({
    this.backgroundColor =
        const WidgetStatePropertyAll<Color?>(Color.fromARGB(255, 70, 69, 69)),
    this.borderRadius = 12.0,
    this.shadowColor = const WidgetStatePropertyAll<Color?>(Colors.black45),
  });

  final WidgetStateProperty<Color?>? backgroundColor;
  final double? borderRadius;
  final WidgetStateProperty<Color?>? shadowColor;

  @override
  MechanixBottomSheetThemeData copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    double? borderRadius,
    WidgetStateProperty<Color?>? shadowColor,
  }) {
    return MechanixBottomSheetThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  MechanixBottomSheetThemeData lerp(
      ThemeExtension<MechanixBottomSheetThemeData>? other, double t) {
    if (other is! MechanixBottomSheetThemeData) return this;
    return MechanixBottomSheetThemeData(
      backgroundColor: WidgetStateProperty.lerp<Color?>(
          backgroundColor, other.backgroundColor, t, Color.lerp),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      shadowColor: WidgetStateProperty.lerp<Color?>(
          shadowColor, other.shadowColor, t, Color.lerp),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DoubleProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('shadowColor', shadowColor));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixBottomSheetThemeData &&
        backgroundColor == other.backgroundColor &&
        borderRadius == other.borderRadius &&
        shadowColor == other.shadowColor;
  }

  @override
  int get hashCode {
    return Object.hash(backgroundColor, borderRadius, shadowColor);
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
