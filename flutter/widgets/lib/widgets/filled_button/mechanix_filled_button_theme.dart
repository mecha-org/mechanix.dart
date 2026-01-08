import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixFilledButtonThemeData
    extends ThemeExtension<MechanixFilledButtonThemeData> with Diagnosticable {
  const MechanixFilledButtonThemeData({
    this.buttonSize = const Size(246, 40),
    this.labelText,
    this.textStyle,
    this.padding,
    // this.margin,
    // this.constraints,
    this.buttonColor,
    this.pressedButtonColor,
  });

  final Size? buttonSize;
  final Text? labelText;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor;
  final Color? pressedButtonColor;

  @override
  MechanixFilledButtonThemeData copyWith({
    Size? buttonSize,
    Text? labelText,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Color? buttonColor,
    Color? pressedButtonColor,
  }) {
    return MechanixFilledButtonThemeData(
      buttonSize: buttonSize ?? this.buttonSize,
      labelText: labelText ?? this.labelText,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      buttonColor: buttonColor ?? this.buttonColor,
      pressedButtonColor: pressedButtonColor ?? this.pressedButtonColor,
    );
  }

  @override
  MechanixFilledButtonThemeData lerp(
      ThemeExtension<MechanixFilledButtonThemeData>? other, double t) {
    if (other is! MechanixFilledButtonThemeData) return this;
    return MechanixFilledButtonThemeData(
      buttonSize: Size.lerp(buttonSize, other.buttonSize, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      pressedButtonColor:
          Color.lerp(pressedButtonColor, other.pressedButtonColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('buttonSize', buttonSize));
    properties.add(DiagnosticsProperty('labelText', labelText));
    properties.add(DiagnosticsProperty('textStyle', textStyle));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DiagnosticsProperty('buttonColor', buttonColor));
    properties
        .add(DiagnosticsProperty('pressedButtonColor', pressedButtonColor));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixFilledButtonThemeData &&
        buttonSize == other.buttonSize &&
        labelText == other.labelText &&
        padding == other.padding &&
        buttonColor == other.buttonColor &&
        pressedButtonColor == other.pressedButtonColor &&
        textStyle == other.textStyle;
  }

  @override
  int get hashCode {
    return Object.hash(
      buttonSize,
      labelText,
      textStyle,
      padding,
      buttonColor,
      pressedButtonColor,
    );
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
