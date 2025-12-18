import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixFilledButtonThemeData
    extends ThemeExtension<MechanixFilledButtonThemeData> with Diagnosticable {
  const MechanixFilledButtonThemeData({
    this.buttonSize = const Size(246, 40),
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Color.fromRGBO(70, 70, 70, 1),
    ),
    this.labelText,
    this.textStyle,
    this.padding,
    this.margin,
    this.constraints,
  });

  final Size? buttonSize;
  final BoxDecoration? decoration;
  final Text? labelText;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;

  @override
  MechanixFilledButtonThemeData copyWith({
    Size? buttonSize,
    BoxDecoration? decoration,
    Text? labelText,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxConstraints? constraints,
  }) {
    return MechanixFilledButtonThemeData(
      buttonSize: buttonSize ?? this.buttonSize,
      decoration: decoration ?? this.decoration,
      labelText: labelText ?? this.labelText,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      constraints: constraints ?? this.constraints,
    );
  }

  @override
  MechanixFilledButtonThemeData lerp(
      ThemeExtension<MechanixFilledButtonThemeData>? other, double t) {
    if (other is! MechanixFilledButtonThemeData) return this;
    return MechanixFilledButtonThemeData(
      buttonSize: Size.lerp(buttonSize, other.buttonSize, t),
      decoration:
          BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      constraints: BoxConstraints.lerp(constraints, other.constraints, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('buttonSize', buttonSize));
    properties.add(DiagnosticsProperty('decoration', decoration));
    properties.add(DiagnosticsProperty('labelText', labelText));
    properties.add(DiagnosticsProperty('textStyle', textStyle));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DiagnosticsProperty('margin', margin));
    properties.add(DiagnosticsProperty('constraints', constraints));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixFilledButtonThemeData &&
        buttonSize == other.buttonSize &&
        decoration == other.decoration &&
        labelText == other.labelText &&
        padding == other.padding &&
        margin == other.margin &&
        constraints == other.constraints &&
        textStyle == other.textStyle;
  }

  @override
  int get hashCode {
    return Object.hash(buttonSize, decoration, labelText, textStyle, padding,
        margin, constraints);
  }
}

class MechanixFilledButtonTheme extends InheritedTheme {
  const MechanixFilledButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MechanixFilledButtonThemeData data;

  static MechanixFilledButtonThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixFilledButtonTheme>();
    return theme?.data ??
        Theme.of(context).extension<MechanixFilledButtonThemeData>() ??
        const MechanixFilledButtonThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixFilledButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixFilledButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}
