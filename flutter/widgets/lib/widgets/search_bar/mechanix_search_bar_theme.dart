import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSearchBarThemeData
    extends ThemeExtension<MechanixSearchBarThemeData> with Diagnosticable {
  const MechanixSearchBarThemeData({
    this.borderSide =
        const WidgetStatePropertyAll(BorderSide(color: Color(0xFF4D4D4D))),
    this.hintStyle =
        const WidgetStatePropertyAll(TextStyle(color: Color(0xFFA6A6A6))),
    this.backgroundColor = const WidgetStatePropertyAll(Color(0xFF363636)),
    this.overlayColor = const WidgetStatePropertyAll(Colors.transparent),
    this.borderColor = const Color(0xFF4D4D4D),
    this.defaultLeadingIconSize = 24.0,
    this.searchIconSize = 17.0,
    this.defaultTrailingIconSize = 15.0,
    this.buttonSize = 40.0,
    this.buttonBorderRadius = 22,
    this.trailingContainerWidth = 113.0,
  });

  final WidgetStateProperty<BorderSide?>? borderSide;
  final WidgetStateProperty<Color?>? backgroundColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final WidgetStateProperty<TextStyle?>? hintStyle;
  final Color? borderColor;
  final double? defaultLeadingIconSize;
  final double? searchIconSize;
  final double? defaultTrailingIconSize;
  final double? buttonSize;
  final double? buttonBorderRadius;
  final double? trailingContainerWidth;

  @override
  MechanixSearchBarThemeData copyWith({
    WidgetStateProperty<BorderSide?>? borderSide,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<TextStyle?>? hintStyle,
    Color? borderColor,
    double? defaultLeadingIconSize,
    double? searchIconSize,
    double? defaultTrailingIconSize,
    double? buttonSize,
    double? buttonBorderRadius,
    double? trailingContainerWidth,
  }) {
    return MechanixSearchBarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      hintStyle: hintStyle ?? this.hintStyle,
      borderColor: borderColor ?? this.borderColor,
      defaultLeadingIconSize:
          defaultLeadingIconSize ?? this.defaultLeadingIconSize,
      searchIconSize: searchIconSize ?? this.searchIconSize,
      defaultTrailingIconSize:
          defaultTrailingIconSize ?? this.defaultTrailingIconSize,
      buttonSize: buttonSize ?? this.buttonSize,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      trailingContainerWidth:
          trailingContainerWidth ?? this.trailingContainerWidth,
    );
  }

  @override
  MechanixSearchBarThemeData lerp(
    ThemeExtension<MechanixSearchBarThemeData>? other,
    double t,
  ) {
    if (other is! MechanixSearchBarThemeData) return this;

    return MechanixSearchBarThemeData(
      backgroundColor: WidgetStateProperty.lerp<Color?>(
          backgroundColor, other.backgroundColor, t, Color.lerp),
      overlayColor: WidgetStateProperty.lerp<Color?>(
          overlayColor, other.overlayColor, t, Color.lerp),
      hintStyle: WidgetStateProperty.lerp<TextStyle?>(
          hintStyle, other.hintStyle, t, TextStyle.lerp),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      defaultLeadingIconSize:
          lerpDouble(defaultLeadingIconSize, other.defaultLeadingIconSize, t),
      searchIconSize: lerpDouble(searchIconSize, other.searchIconSize, t),
      defaultTrailingIconSize:
          lerpDouble(defaultTrailingIconSize, other.defaultTrailingIconSize, t),
      buttonSize: lerpDouble(buttonSize, other.buttonSize, t),
      buttonBorderRadius:
          lerpDouble(buttonBorderRadius, other.buttonBorderRadius, t),
      trailingContainerWidth:
          lerpDouble(trailingContainerWidth, other.trailingContainerWidth, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('overlayColor', overlayColor));
    properties.add(DiagnosticsProperty('hintStyle', hintStyle));
    properties.add(ColorProperty('borderColor', borderColor));
    properties
        .add(DoubleProperty('defaultLeadingIconSize', defaultLeadingIconSize));
    properties.add(DoubleProperty('searchIconSize', searchIconSize));
    properties.add(
        DoubleProperty('defaultTrailingIconSize', defaultTrailingIconSize));
    properties.add(DoubleProperty('buttonSize', buttonSize));
    properties.add(DoubleProperty('buttonBorderRadius', buttonBorderRadius));
    properties
        .add(DoubleProperty('trailingContainerWidth', trailingContainerWidth));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSearchBarThemeData &&
        other.backgroundColor == backgroundColor &&
        other.overlayColor == overlayColor &&
        other.hintStyle == hintStyle &&
        other.borderColor == borderColor &&
        other.defaultLeadingIconSize == defaultLeadingIconSize &&
        other.searchIconSize == searchIconSize &&
        other.defaultTrailingIconSize == defaultTrailingIconSize &&
        other.buttonSize == buttonSize &&
        other.buttonBorderRadius == buttonBorderRadius &&
        other.trailingContainerWidth == trailingContainerWidth;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        overlayColor,
        hintStyle,
        borderColor,
        defaultLeadingIconSize,
        searchIconSize,
        defaultTrailingIconSize,
        buttonSize,
        buttonBorderRadius,
        trailingContainerWidth,
      );
}

class MechanixSearchBarTheme extends InheritedTheme {
  const MechanixSearchBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixSearchBarThemeData data;

  static MechanixSearchBarThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixSearchBarTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixSearchBarThemeData>() ??
        const MechanixSearchBarThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSearchBarTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixSearchBarTheme oldWidget) {
    return data != oldWidget.data;
  }
}
