import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixMenuThemeData extends ThemeExtension<MechanixMenuThemeData>
    with Diagnosticable {
  const MechanixMenuThemeData({
    this.elevation = 4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.dropdownWidth,
    this.dropdownHeight,
    this.constraints = const BoxConstraints(maxHeight: 400, maxWidth: 200),
    this.itemBackgroundColor,
    this.itemPadding = const EdgeInsets.all(12),
    this.itemBorderRadius,
    this.itemHeight,
    this.disabledTextStyle,
    this.disabledBackgroundColor,
    this.titleTextStyle,
    this.padding,
    this.clipBehavior = Clip.none,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.alignment,
    this.decoration,
    this.foregroundDecoration,
    this.disableOpacity = 0.5,
  });

  final double? elevation;
  final double? disableOpacity;
  final BorderRadius? borderRadius;
  final double? dropdownWidth;
  final double? dropdownHeight;
  final BoxConstraints? constraints;
  final Color? itemBackgroundColor;
  final EdgeInsets? itemPadding;
  final BorderRadius? itemBorderRadius;
  final double? itemHeight;
  final TextStyle? disabledTextStyle;
  final Color? disabledBackgroundColor;
  final TextStyle? titleTextStyle;
  final EdgeInsets? padding;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;

  @override
  MechanixMenuThemeData copyWith({
    double? elevation,
    BorderRadius? borderRadius,
    double? dropdownWidth,
    double? dropdownHeight,
    BoxConstraints? constraints,
    Color? itemBackgroundColor,
    EdgeInsets? itemPadding,
    BorderRadius? itemBorderRadius,
    double? itemHeight,
    TextStyle? disabledTextStyle,
    Color? disabledBackgroundColor,
    TextStyle? titleTextStyle,
    Color? iconColor,
    Color? disabledIconColor,
    EdgeInsets? padding,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    AlignmentGeometry? alignment,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? disableOpacity,
  }) {
    return MechanixMenuThemeData(
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      dropdownWidth: dropdownWidth ?? this.dropdownWidth,
      dropdownHeight: dropdownHeight ?? this.dropdownHeight,
      constraints: constraints ?? this.constraints,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemPadding: itemPadding ?? this.itemPadding,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemHeight: itemHeight ?? this.itemHeight,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      transform: transform ?? this.transform,
      transformAlignment: transformAlignment ?? this.transformAlignment,
      alignment: alignment ?? this.alignment,
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      disableOpacity: disableOpacity ?? this.disableOpacity,
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
      disableOpacity: lerpDouble(disableOpacity, o?.disableOpacity, t),
      borderRadius: BorderRadius.lerp(borderRadius, o?.borderRadius, t),
      dropdownWidth: lerpDouble(dropdownWidth, o?.dropdownWidth, t),
      dropdownHeight: lerpDouble(dropdownHeight, o?.dropdownHeight, t),
      constraints: constraints,
      itemBackgroundColor:
          Color.lerp(itemBackgroundColor, o?.itemBackgroundColor, t),
      itemPadding:
          EdgeInsets.lerp(itemPadding, o?.itemPadding, t) ?? itemPadding,
      itemBorderRadius:
          BorderRadius.lerp(itemBorderRadius, o?.itemBorderRadius, t),
      itemHeight: lerpDouble(itemHeight, o?.itemHeight, t),
      disabledTextStyle:
          TextStyle.lerp(disabledTextStyle, o?.disabledTextStyle, t),
      disabledBackgroundColor:
          Color.lerp(disabledBackgroundColor, o?.disabledBackgroundColor, t),
      padding: EdgeInsets.lerp(padding, o?.padding, t) ?? padding,
      margin: EdgeInsetsGeometry.lerp(margin, o?.margin, t),
      transformAlignment:
          AlignmentGeometry.lerp(transformAlignment, o?.transformAlignment, t),
      alignment: AlignmentGeometry.lerp(alignment, o?.alignment, t),
      decoration: Decoration.lerp(decoration, o?.decoration, t) ?? decoration,
      foregroundDecoration:
          Decoration.lerp(foregroundDecoration, o?.foregroundDecoration, t) ??
              foregroundDecoration,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(DoubleProperty('disableOpacity', disableOpacity));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DoubleProperty('dropdownWidth', dropdownWidth));
    properties.add(DoubleProperty('dropdownHeight', dropdownHeight));
    properties.add(DiagnosticsProperty('constraints', constraints));
    properties
        .add(DiagnosticsProperty('itemBackgroundColor', itemBackgroundColor));
    properties.add(DiagnosticsProperty('itemPadding', itemPadding));
    properties.add(DiagnosticsProperty('itemBorderRadius', itemBorderRadius));
    properties.add(DoubleProperty('itemHeight', itemHeight));
    properties.add(DiagnosticsProperty('disabledTextStyle', disabledTextStyle));
    properties.add(DiagnosticsProperty(
        'disabledBackgroundColor', disabledBackgroundColor));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DiagnosticsProperty('margin', margin));
    properties.add(DiagnosticsProperty('clipBehavior', clipBehavior));
    properties.add(DiagnosticsProperty('transform', transform));
    properties
        .add(DiagnosticsProperty('transformAlignment', transformAlignment));
    properties.add(DiagnosticsProperty('alignment', alignment));
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties
        .add(DiagnosticsProperty('foregroundDecoration', foregroundDecoration));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixMenuThemeData &&
        elevation == other.elevation &&
        borderRadius == other.borderRadius &&
        dropdownWidth == other.dropdownWidth &&
        dropdownHeight == other.dropdownHeight &&
        constraints == other.constraints &&
        itemBackgroundColor == other.itemBackgroundColor &&
        itemPadding == other.itemPadding &&
        itemBorderRadius == other.itemBorderRadius &&
        itemHeight == other.itemHeight &&
        padding == other.padding &&
        clipBehavior == other.clipBehavior &&
        margin == other.margin &&
        transform == other.transform &&
        transformAlignment == other.transformAlignment &&
        alignment == other.alignment &&
        decoration == other.decoration &&
        foregroundDecoration == other.foregroundDecoration &&
        disableOpacity == other.disableOpacity &&
        disabledBackgroundColor == other.disabledBackgroundColor &&
        disabledTextStyle == other.disabledTextStyle;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      elevation,
      borderRadius,
      dropdownWidth,
      dropdownHeight,
      constraints,
      itemBackgroundColor,
      itemPadding,
      itemBorderRadius,
      itemHeight,
      disabledBackgroundColor,
      disabledTextStyle,
      padding,
      clipBehavior,
      margin,
      transform,
      transformAlignment,
      alignment,
      decoration,
      disableOpacity,
      foregroundDecoration,
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
