import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSelectThemeData extends ThemeExtension<MechanixSelectThemeData>
    with Diagnosticable {
  const MechanixSelectThemeData({
    this.backgroundColor,
    this.selectionColor,
    this.titleStyle,
    this.selectedTitleStyle,
    this.leadingPadding = const EdgeInsets.only(right: 8),
    this.trailingIconColor,
    this.optionPadding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.elevation = 2,
  });

  final Color? backgroundColor;
  final Color? selectionColor;
  final TextStyle? titleStyle;
  final TextStyle? selectedTitleStyle;
  final EdgeInsets? leadingPadding;
  final Color? trailingIconColor;
  final EdgeInsets optionPadding;
  final BorderRadius? borderRadius;
  final double elevation;

  @override
  MechanixSelectThemeData copyWith({
    Color? backgroundColor,
    Color? selectionColor,
    TextStyle? titleStyle,
    TextStyle? selectedTitleStyle,
    EdgeInsets? leadingPadding,
    Color? trailingIconColor,
    EdgeInsets? optionPadding,
    BorderRadius? borderRadius,
    double? elevation,
  }) {
    return MechanixSelectThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectionColor: selectionColor ?? this.selectionColor,
      titleStyle: titleStyle ?? this.titleStyle,
      selectedTitleStyle: selectedTitleStyle ?? this.selectedTitleStyle,
      leadingPadding: leadingPadding ?? this.leadingPadding,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      optionPadding: optionPadding ?? this.optionPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
    );
  }

  @override
  ThemeExtension<MechanixSelectThemeData> lerp(
    ThemeExtension<MechanixSelectThemeData>? other,
    double t,
  ) {
    if (other is! MechanixSelectThemeData) {
      return this;
    }

    return MechanixSelectThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      selectedTitleStyle:
          TextStyle.lerp(selectedTitleStyle, other.selectedTitleStyle, t),
      leadingPadding:
          EdgeInsets.lerp(leadingPadding, other.leadingPadding, t) ??
              leadingPadding,
      trailingIconColor:
          Color.lerp(trailingIconColor, other.trailingIconColor, t),
      optionPadding: EdgeInsets.lerp(optionPadding, other.optionPadding, t) ??
          optionPadding,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      elevation: lerpDouble(elevation, other.elevation, t) ?? elevation,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('selectionColor', selectionColor));
    properties.add(DiagnosticsProperty('titleStyle', titleStyle));
    properties
        .add(DiagnosticsProperty('selectedTitleStyle', selectedTitleStyle));
    properties.add(DiagnosticsProperty('leadingPadding', leadingPadding));
    properties.add(DiagnosticsProperty('trailingIconColor', trailingIconColor));
    properties.add(DiagnosticsProperty('padding', optionPadding));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('elevation', elevation));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSelectThemeData &&
        backgroundColor == other.backgroundColor &&
        selectionColor == other.selectionColor &&
        titleStyle == other.titleStyle &&
        selectedTitleStyle == other.selectedTitleStyle &&
        leadingPadding == other.leadingPadding &&
        trailingIconColor == other.trailingIconColor &&
        optionPadding == other.optionPadding &&
        borderRadius == other.borderRadius &&
        elevation == other.elevation;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      selectionColor,
      titleStyle,
      selectedTitleStyle,
      leadingPadding,
      trailingIconColor,
      optionPadding,
      borderRadius,
      elevation,
    );
  }
}

class MechanixSelectTheme extends InheritedTheme {
  const MechanixSelectTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixSelectThemeData data;

  static MechanixSelectThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixSelectTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixSelectThemeData>() ??
        const MechanixSelectThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSelectTheme(
      data: data,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(MechanixSelectTheme oldWidget) {
    return data != oldWidget.data;
  }
}
