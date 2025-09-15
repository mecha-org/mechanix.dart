import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSimpleListThemeData
    extends ThemeExtension<MechanixSimpleListThemeData> with Diagnosticable {
  const MechanixSimpleListThemeData({
    this.backgroundColor,
    this.widgetRadius = const BorderRadius.all(Radius.circular(4)),
    this.widgetMargin = const EdgeInsets.only(bottom: 40),
    this.itemRadius,
    this.dividerThickness = 1,
    this.dividerHeight = 1,
    this.dividerColor,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.height = 56,
  });

  final Color? backgroundColor;

  final Color? dividerColor;

  final BorderRadius? widgetRadius;

  final double? dividerThickness;

  final double? dividerHeight;

  final EdgeInsets? itemPadding;

  final EdgeInsets? widgetMargin;

  final BorderRadius? itemRadius;
  final double? height;

  @override
  MechanixSimpleListThemeData copyWith({
    Color? backgroundColor,
    BorderRadius? widgetRadius,
    BorderRadius? itemRadius,
    double? dividerThickness,
    double? dividerHeight,
    Color? dividerColor,
    EdgeInsets? itemPadding,
    EdgeInsets? widgetMargin,
  }) {
    return MechanixSimpleListThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      widgetRadius: widgetRadius ?? this.widgetRadius,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerHeight: dividerHeight ?? this.dividerHeight,
      dividerColor: dividerColor ?? this.dividerColor,
      itemPadding: itemPadding ?? this.itemPadding,
      widgetMargin: widgetMargin ?? this.widgetMargin,
      itemRadius: itemRadius ?? this.itemRadius,
    );
  }

  @override
  ThemeExtension<MechanixSimpleListThemeData> lerp(
      ThemeExtension<MechanixSimpleListThemeData>? other, double t) {
    final o = other as MechanixSimpleListThemeData?;
    return MechanixSimpleListThemeData(
      backgroundColor: Color.lerp(backgroundColor, o?.backgroundColor, t),
      dividerColor: Color.lerp(dividerColor, o?.dividerColor, t),
      widgetRadius: BorderRadius.lerp(widgetRadius, o?.widgetRadius, t),
      dividerThickness: lerpDouble(dividerThickness, o?.dividerThickness, t),
      dividerHeight: lerpDouble(dividerHeight, o?.dividerHeight, t),
      itemPadding: EdgeInsets.lerp(itemPadding, o?.itemPadding, t),
      widgetMargin: EdgeInsets.lerp(widgetMargin, o?.widgetMargin, t),
      itemRadius: BorderRadius.lerp(itemRadius, o?.itemRadius, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('dividerColor', dividerColor));
    properties.add(DiagnosticsProperty('widgetRadius', widgetRadius));
    properties.add(DiagnosticsProperty('dividerThickness', dividerThickness));
    properties.add(DiagnosticsProperty('dividerHeight', dividerHeight));
    properties.add(DiagnosticsProperty('itemPadding', itemPadding));
    properties.add(DiagnosticsProperty('widgetMargin', widgetMargin));
    properties.add(DiagnosticsProperty('itemRadius', itemRadius));
    properties.add(DiagnosticsProperty('height', height));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSimpleListThemeData &&
        backgroundColor == other.backgroundColor &&
        dividerColor == other.dividerColor &&
        widgetRadius == other.widgetRadius &&
        dividerThickness == other.dividerThickness &&
        dividerHeight == other.dividerHeight &&
        widgetMargin == other.widgetMargin &&
        itemRadius == other.itemRadius &&
        itemPadding == other.itemPadding;
  }

  @override
  int get hashCode {
    return Object.hash(backgroundColor, dividerColor, widgetRadius,
        dividerThickness, dividerHeight, widgetMargin, itemPadding, itemRadius);
  }
}

class MechanixSimpleListTheme extends InheritedTheme {
  const MechanixSimpleListTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final MechanixSimpleListThemeData style;

  static MechanixSimpleListThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixSimpleListTheme>();
    return theme?.style ??
        Theme.of(context).extension<MechanixSimpleListThemeData>() ??
        const MechanixSimpleListThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSimpleListTheme(
      style: style,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(MechanixSimpleListTheme oldWidget) {
    return style != oldWidget.style;
  }
}
