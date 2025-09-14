import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSectionListThemeData
    extends ThemeExtension<MechanixSectionListThemeData> with Diagnosticable {
  const MechanixSectionListThemeData({
    this.backgroundColor,
    this.titleTextStyle,
    this.dividerThickness = 1,
    this.dividerHeight = 1,
    this.dividerColor,
    this.isDividerRequired = true,
    this.divider,
    this.widgetPadding = const EdgeInsets.only(bottom: 40),
    this.titlePadding = const EdgeInsets.only(bottom: 8),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.dividerPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.widgetRadius = const BorderRadius.all(Radius.circular(4)),
    this.itemBorderRadius = BorderRadius.zero,
  });

  final WidgetStateProperty<Color?>? backgroundColor;
  final EdgeInsets widgetPadding;
  final BorderRadius? widgetRadius;

  final TextStyle? titleTextStyle;
  final EdgeInsets titlePadding;

  final Color? dividerColor;
  final double? dividerThickness;
  final double? dividerHeight;
  final EdgeInsets dividerPadding;
  final bool isDividerRequired;
  final Widget? divider;

  final EdgeInsets itemPadding;
  final BorderRadius? itemBorderRadius;

  @override
  MechanixSectionListThemeData copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    TextStyle? titleTextStyle,
    double? dividerThickness,
    double? dividerHeight,
    Color? dividerColor,
    bool? isDividerRequired,
    Widget? divider,
    EdgeInsets? widgetPadding,
    EdgeInsets? titlePadding,
    EdgeInsets? itemPadding,
    EdgeInsets? dividerPadding,
    BorderRadius? widgetRadius,
    BorderRadius? itemBorderRadius,
  }) {
    return MechanixSectionListThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerHeight: dividerHeight ?? this.dividerHeight,
      dividerColor: dividerColor ?? this.dividerColor,
      isDividerRequired: isDividerRequired ?? this.isDividerRequired,
      divider: divider ?? this.divider,
      widgetPadding: widgetPadding ?? this.widgetPadding,
      titlePadding: titlePadding ?? this.titlePadding,
      itemPadding: itemPadding ?? this.itemPadding,
      dividerPadding: dividerPadding ?? this.dividerPadding,
      widgetRadius: widgetRadius ?? this.widgetRadius,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
    );
  }

  @override
  ThemeExtension<MechanixSectionListThemeData> lerp(
      ThemeExtension<MechanixSectionListThemeData>? other, double t) {
    final o = other as MechanixSectionListThemeData?;
    return MechanixSectionListThemeData(
      backgroundColor: WidgetStateProperty.lerp<Color?>(
          backgroundColor, o?.backgroundColor, t, Color.lerp),
      titleTextStyle: TextStyle.lerp(titleTextStyle, o?.titleTextStyle, t),
      dividerThickness: lerpDouble(dividerThickness, o?.dividerThickness, t),
      dividerHeight: lerpDouble(dividerHeight, o?.dividerThickness, t),
      dividerColor: Color.lerp(dividerColor, o?.dividerColor, t),
      isDividerRequired: isDividerRequired,
      divider: divider,
      widgetPadding:
          EdgeInsets.lerp(widgetPadding, o?.widgetPadding, t) ?? widgetPadding,
      titlePadding:
          EdgeInsets.lerp(titlePadding, o?.titlePadding, t) ?? titlePadding,
      itemPadding:
          EdgeInsets.lerp(itemPadding, o?.itemPadding, t) ?? itemPadding,
      dividerPadding: EdgeInsets.lerp(dividerPadding, o?.dividerPadding, t) ??
          dividerPadding,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('titleTextStyle', titleTextStyle));
    properties.add(DiagnosticsProperty('dividerThickness', dividerThickness));
    properties.add(DiagnosticsProperty('dividerHeight', dividerHeight));
    properties.add(DiagnosticsProperty('dividerColor', dividerColor));
    properties.add(DiagnosticsProperty('isDividerRequired', isDividerRequired));
    properties.add(DiagnosticsProperty('divider', divider));
    properties.add(DiagnosticsProperty('widgetPadding', widgetPadding));
    properties.add(DiagnosticsProperty('titlePadding', titlePadding));
    properties.add(DiagnosticsProperty('itemPadding', itemPadding));
    properties.add(DiagnosticsProperty('dividerPadding', dividerPadding));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSectionListThemeData &&
        backgroundColor == other.backgroundColor &&
        titleTextStyle == other.titleTextStyle &&
        dividerThickness == other.dividerThickness &&
        dividerHeight == other.dividerHeight &&
        dividerColor == other.dividerColor &&
        isDividerRequired == other.isDividerRequired &&
        divider == other.divider &&
        widgetPadding == other.widgetPadding &&
        titlePadding == other.titlePadding &&
        itemPadding == other.itemPadding &&
        dividerPadding == other.dividerPadding;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      titleTextStyle,
      dividerThickness,
      dividerHeight,
      dividerColor,
      isDividerRequired,
      divider,
      widgetPadding,
      titlePadding,
      itemPadding,
      dividerPadding,
    );
  }
}

class MechanixSectionListTheme extends InheritedTheme {
  const MechanixSectionListTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final MechanixSectionListThemeData style;

  static MechanixSectionListThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixSectionListTheme>();
    return theme?.style ??
        Theme.of(context).extension<MechanixSectionListThemeData>() ??
        const MechanixSectionListThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSectionListTheme(
      style: style,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(MechanixSectionListTheme oldWidget) {
    return style != oldWidget.style;
  }
}
