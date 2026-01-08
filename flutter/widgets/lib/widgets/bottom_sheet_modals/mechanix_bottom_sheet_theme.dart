import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixBottomSheetThemeData
    extends ThemeExtension<MechanixBottomSheetThemeData> with Diagnosticable {
  const MechanixBottomSheetThemeData({
    this.decoration = const BoxDecoration(),
    this.padding = EdgeInsets.zero,
  });

  final BoxDecoration decoration;
  final EdgeInsetsGeometry padding;

  @override
  MechanixBottomSheetThemeData copyWith({
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
  }) {
    return MechanixBottomSheetThemeData(
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
    );
  }

  @override
  MechanixBottomSheetThemeData lerp(
      ThemeExtension<MechanixBottomSheetThemeData>? other, double t) {
    if (other is! MechanixBottomSheetThemeData) return this;
    return MechanixBottomSheetThemeData(
      decoration:
          BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties.add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixBottomSheetThemeData &&
        decoration == other.decoration &&
        padding == other.padding;
  }

  @override
  int get hashCode {
    return Object.hash(decoration, padding);
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
