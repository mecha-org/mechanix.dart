import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixMenuThemeData extends ThemeExtension<MechanixMenuThemeData>
    with Diagnosticable {
  const MechanixMenuThemeData({
    this.elevation = 4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.width = 200,
    this.maxHeight = 400,
    this.constraints,
    this.itemBackgroundColor,
    this.itemHoverColor,
    this.itemPadding = const EdgeInsets.all(12),
    this.itemBorderRadius,
    this.itemHeight,
    this.disabledTextStyle,
    this.titleTextStyle,
    this.iconColor,
    this.disabledIconColor,
    this.divider,
    this.dropDownOffset,
  });

  final double? elevation;
  final BorderRadius? borderRadius;
  final double? width;
  final double? maxHeight;
  final BoxConstraints? constraints;
  final Color? itemBackgroundColor;
  final Color? itemHoverColor;
  final EdgeInsets? itemPadding;
  final BorderRadius? itemBorderRadius;
  final double? itemHeight;
  final TextStyle? disabledTextStyle;
  final TextStyle? titleTextStyle;
  final Color? iconColor;
  final Color? disabledIconColor;
  final Divider? divider;
  final Offset? dropDownOffset;

  @override
  MechanixMenuThemeData copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    double? elevation,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? width,
    double? maxHeight,
    BoxConstraints? constraints,
    Color? itemBackgroundColor,
    Color? itemHoverColor,
    EdgeInsets? itemPadding,
    BorderRadius? itemBorderRadius,
    double? itemHeight,
    TextStyle? textStyle,
    TextStyle? disabledTextStyle,
    TextStyle? titleTextStyle,
    Color? iconColor,
    Color? disabledIconColor,
    double? iconSize,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? dividerColor,
    double? dividerHeight,
    double? dividerThickness,
  }) {
    return MechanixMenuThemeData(
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      maxHeight: maxHeight ?? this.maxHeight,
      constraints: constraints ?? this.constraints,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemHoverColor: itemHoverColor ?? this.itemHoverColor,
      itemPadding: itemPadding ?? this.itemPadding,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemHeight: itemHeight ?? this.itemHeight,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      iconColor: iconColor ?? this.iconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
    );
  }

  @override
  ThemeExtension<MechanixMenuThemeData> lerp(
    ThemeExtension<MechanixMenuThemeData>? other,
    double t,
  ) {
    final o = other as MechanixMenuThemeData?;
    return MechanixMenuThemeData(
      elevation: lerpDouble(elevation, o?.elevation, t),
      borderRadius: BorderRadius.lerp(borderRadius, o?.borderRadius, t),
      width: lerpDouble(width, o?.width, t),
      maxHeight: lerpDouble(maxHeight, o?.maxHeight, t),
      constraints: constraints,
      itemBackgroundColor:
          Color.lerp(itemBackgroundColor, o?.itemBackgroundColor, t),
      itemHoverColor: Color.lerp(itemHoverColor, o?.itemHoverColor, t),
      itemPadding:
          EdgeInsets.lerp(itemPadding, o?.itemPadding, t) ?? itemPadding,
      itemBorderRadius:
          BorderRadius.lerp(itemBorderRadius, o?.itemBorderRadius, t),
      itemHeight: lerpDouble(itemHeight, o?.itemHeight, t),
      disabledTextStyle:
          TextStyle.lerp(disabledTextStyle, o?.disabledTextStyle, t),
      iconColor: Color.lerp(iconColor, o?.iconColor, t),
      disabledIconColor: Color.lerp(disabledIconColor, o?.disabledIconColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('maxHeight', maxHeight));
    properties.add(DiagnosticsProperty('constraints', constraints));

    properties
        .add(DiagnosticsProperty('itemBackgroundColor', itemBackgroundColor));
    properties.add(DiagnosticsProperty('itemHoverColor', itemHoverColor));
    properties.add(DiagnosticsProperty('itemPadding', itemPadding));
    properties.add(DiagnosticsProperty('itemBorderRadius', itemBorderRadius));
    properties.add(DoubleProperty('itemHeight', itemHeight));

    properties.add(DiagnosticsProperty('disabledTextStyle', disabledTextStyle));

    properties.add(DiagnosticsProperty('iconColor', iconColor));
    properties.add(DiagnosticsProperty('disabledIconColor', disabledIconColor));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixMenuThemeData &&
        elevation == other.elevation &&
        borderRadius == other.borderRadius &&
        width == other.width &&
        maxHeight == other.maxHeight &&
        constraints == other.constraints &&
        itemBackgroundColor == other.itemBackgroundColor &&
        itemHoverColor == other.itemHoverColor &&
        itemPadding == other.itemPadding &&
        itemBorderRadius == other.itemBorderRadius &&
        itemHeight == other.itemHeight &&
        disabledTextStyle == other.disabledTextStyle &&
        iconColor == other.iconColor &&
        disabledIconColor == other.disabledIconColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      elevation,
      borderRadius,
      width,
      maxHeight,
      constraints,
      itemBackgroundColor,
      itemHoverColor,
      itemPadding,
      itemBorderRadius,
      itemHeight,
      disabledTextStyle,
      iconColor,
      disabledIconColor,
    ]);
  }
}

class MechanixMenuTheme extends InheritedTheme {
  const MechanixMenuTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final MechanixMenuThemeData style;

  static MechanixMenuThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixMenuTheme>();
    return theme?.style ??
        Theme.of(context).extension<MechanixMenuThemeData>() ??
        const MechanixMenuThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixMenuTheme(
      style: style,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(MechanixMenuTheme oldWidget) {
    return style != oldWidget.style;
  }
}
