import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixNotificationThemeData
    extends ThemeExtension<MechanixNotificationThemeData> with Diagnosticable {
  const MechanixNotificationThemeData({
    this.backgroundColor,
    this.margin = const EdgeInsets.all(16),
  });

  final Color? backgroundColor;
  final EdgeInsetsGeometry margin;

  @override
  MechanixNotificationThemeData copyWith({
    backgroundColor,
    margin,
  }) {
    return MechanixNotificationThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      margin: margin ?? this.margin,
    );
  }

  @override
  MechanixNotificationThemeData lerp(
      ThemeExtension<MechanixNotificationThemeData>? other, double t) {
    if (other is! MechanixNotificationThemeData) return this;
    return MechanixNotificationThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) ?? margin,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('margin', margin));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixNotificationThemeData &&
        backgroundColor == other.backgroundColor &&
        margin == other.margin;
  }

  @override
  int get hashCode {
    return Object.hash(backgroundColor, margin);
  }
}

class MechanixNotificationTheme extends InheritedTheme {
  const MechanixNotificationTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixNotificationThemeData data;

  static MechanixNotificationThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixNotificationTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixNotificationThemeData>() ??
        const MechanixNotificationThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixNotificationTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixNotificationTheme oldWidget) {
    return data != oldWidget.data;
  }
}
