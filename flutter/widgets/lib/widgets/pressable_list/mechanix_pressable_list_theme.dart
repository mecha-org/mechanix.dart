import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSelectableListThemeData
    extends ThemeExtension<MechanixSelectableListThemeData>
    with Diagnosticable {
  const MechanixSelectableListThemeData({
    this.titleTextStyle,
    this.backgroundColor,
    this.itemPadding = const EdgeInsets.all(10),
    this.leadingIconPadding = const EdgeInsets.all(10),
    this.trailingPadding = const EdgeInsets.all(10),
    this.checkboxSpacing = const EdgeInsets.only(right: 10, left: 5),
    this.checkboxColor = const Color(0xFF3176FF), // LATER DO IT AS PER THEME
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? itemPadding;
  final EdgeInsetsGeometry? leadingIconPadding;
  final EdgeInsetsGeometry? trailingPadding;
  final EdgeInsetsGeometry? checkboxSpacing;
  final Color? checkboxColor;
  final BorderRadius? borderRadius;

  @override
  MechanixSelectableListThemeData copyWith({
    TextStyle? titleTextStyle,
    Color? backgroundColor,
    EdgeInsetsGeometry? itemPadding,
    EdgeInsetsGeometry? leadingIconPadding,
    EdgeInsetsGeometry? trailingPadding,
    EdgeInsetsGeometry? checkboxSpacing,
    Color? checkboxColor,
    MouseCursor? mouseCursor,
    BorderRadius? borderRadius,
  }) {
    return MechanixSelectableListThemeData(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      itemPadding: itemPadding ?? this.itemPadding,
      leadingIconPadding: leadingIconPadding ?? this.leadingIconPadding,
      trailingPadding: trailingPadding ?? this.trailingPadding,
      checkboxSpacing: checkboxSpacing ?? this.checkboxSpacing,
      checkboxColor: checkboxColor ?? this.checkboxColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<MechanixSelectableListThemeData> lerp(
    ThemeExtension<MechanixSelectableListThemeData>? other,
    double t,
  ) {
    final o = other as MechanixSelectableListThemeData?;
    if (o == null) return this;

    return MechanixSelectableListThemeData(
      titleTextStyle: TextStyle.lerp(titleTextStyle, o.titleTextStyle, t),
      backgroundColor: Color.lerp(backgroundColor, o.backgroundColor, t),
      itemPadding: EdgeInsetsGeometry.lerp(itemPadding, o.itemPadding, t),
      leadingIconPadding:
          EdgeInsetsGeometry.lerp(leadingIconPadding, o.leadingIconPadding, t),
      trailingPadding:
          EdgeInsetsGeometry.lerp(trailingPadding, o.trailingPadding, t),
      checkboxSpacing:
          EdgeInsetsGeometry.lerp(checkboxSpacing, o.checkboxSpacing, t),
      checkboxColor: Color.lerp(checkboxColor, o.checkboxColor, t),
      borderRadius: BorderRadius.lerp(borderRadius, o.borderRadius, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
        .add(DiagnosticsProperty<TextStyle?>('titleTextStyle', titleTextStyle));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(
        DiagnosticsProperty<EdgeInsetsGeometry?>('itemPadding', itemPadding));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry?>(
        'leadingIconPadding', leadingIconPadding));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry?>(
        'trailingPadding', trailingPadding));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry?>(
        'checkboxSpacing', checkboxSpacing));
    properties.add(ColorProperty('checkboxColor', checkboxColor));
    properties
        .add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSelectableListThemeData &&
        other.titleTextStyle == titleTextStyle &&
        other.backgroundColor == backgroundColor &&
        other.itemPadding == itemPadding &&
        other.leadingIconPadding == leadingIconPadding &&
        other.trailingPadding == trailingPadding &&
        other.checkboxSpacing == checkboxSpacing &&
        other.checkboxColor == checkboxColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      titleTextStyle,
      backgroundColor,
      itemPadding,
      leadingIconPadding,
      trailingPadding,
      checkboxSpacing,
      checkboxColor,
      borderRadius,
    );
  }
}

class MechanixSelectableListTheme extends InheritedTheme {
  const MechanixSelectableListTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixSelectableListThemeData data;

  static MechanixSelectableListThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixSelectableListTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixSelectableListThemeData>() ??
        const MechanixSelectableListThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSelectableListTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixSelectableListTheme oldWidget) {
    return data != oldWidget.data;
  }
}
