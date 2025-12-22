import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixTextInputThemeData
    extends ThemeExtension<MechanixTextInputThemeData> with Diagnosticable {
  const MechanixTextInputThemeData({
    this.labelTextStyle,
    this.textStyle = const TextStyle(fontSize: 16),
    this.hintTextStyle,
    this.fillColor,
    this.contentPadding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.borderSide,
    this.focusedBorderSide,
    this.obscureTextIcon = Icons.visibility_off,
    this.visibleTextIcon = Icons.visibility,
    this.iconColor,
    this.enabledBorderSide,
  });

  final TextStyle? labelTextStyle;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final BorderRadius borderRadius;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final BorderSide? enabledBorderSide;
  final IconData? obscureTextIcon;
  final IconData? visibleTextIcon;
  final Color? iconColor;

  @override
  MechanixTextInputThemeData copyWith({
    TextStyle? labelTextStyle,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    Color? fillColor,
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    BorderSide? borderSide,
    BorderSide? focusedBorderSide,
    IconData? obscureTextIcon,
    IconData? visibleTextIcon,
    Color? iconColor,
    BorderSide? enabledBorderSide,
  }) {
    return MechanixTextInputThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      textStyle: textStyle ?? this.textStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      fillColor: fillColor ?? this.fillColor,
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      borderSide: borderSide ?? this.borderSide,
      focusedBorderSide: focusedBorderSide ?? this.focusedBorderSide,
      obscureTextIcon: obscureTextIcon ?? this.obscureTextIcon,
      visibleTextIcon: visibleTextIcon ?? this.visibleTextIcon,
      iconColor: iconColor ?? this.iconColor,
      enabledBorderSide: enabledBorderSide ?? this.enabledBorderSide,
    );
  }

  @override
  ThemeExtension<MechanixTextInputThemeData> lerp(
      ThemeExtension<MechanixTextInputThemeData>? other, double t) {
    final o = other as MechanixTextInputThemeData?;
    return MechanixTextInputThemeData(
      labelTextStyle: TextStyle.lerp(labelTextStyle, o?.labelTextStyle, t),
      textStyle: TextStyle.lerp(textStyle, o?.textStyle, t),
      hintTextStyle: TextStyle.lerp(hintTextStyle, o?.hintTextStyle, t),
      fillColor: Color.lerp(fillColor, o?.fillColor, t),
      contentPadding: EdgeInsets.lerp(contentPadding, o?.contentPadding, t),
      borderRadius:
          BorderRadius.lerp(borderRadius, o?.borderRadius, t) ?? borderRadius,
      borderSide: BorderSide.lerp(
          borderSide ?? BorderSide.none, o?.borderSide ?? BorderSide.none, t),
      focusedBorderSide: BorderSide.lerp(focusedBorderSide ?? BorderSide.none,
          o?.focusedBorderSide ?? BorderSide.none, t),
      obscureTextIcon: t < 0.5 ? obscureTextIcon : o?.obscureTextIcon,
      visibleTextIcon: t < 0.5 ? visibleTextIcon : o?.visibleTextIcon,
      iconColor: Color.lerp(iconColor, o?.iconColor, t),
      enabledBorderSide: BorderSide.lerp(enabledBorderSide ?? BorderSide.none,
          o?.enabledBorderSide ?? BorderSide.none, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('labelTextStyle', labelTextStyle));
    properties.add(DiagnosticsProperty('textStyle', textStyle));
    properties.add(DiagnosticsProperty('hintTextStyle', hintTextStyle));
    properties.add(DiagnosticsProperty('fillColor', fillColor));
    properties.add(DiagnosticsProperty('contentPadding', contentPadding));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('borderSide', borderSide));
    properties.add(DiagnosticsProperty('focusedBorderSide', focusedBorderSide));
    properties.add(DiagnosticsProperty('obscureTextIcon', obscureTextIcon));
    properties.add(DiagnosticsProperty('visibleTextIcon', visibleTextIcon));
    properties.add(DiagnosticsProperty('iconColor', iconColor));
    properties.add(DiagnosticsProperty('enabledBorderSide', enabledBorderSide));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixTextInputThemeData &&
        labelTextStyle == other.labelTextStyle &&
        textStyle == other.textStyle &&
        hintTextStyle == other.hintTextStyle &&
        fillColor == other.fillColor &&
        contentPadding == other.contentPadding &&
        borderRadius == other.borderRadius &&
        borderSide == other.borderSide &&
        focusedBorderSide == other.focusedBorderSide &&
        obscureTextIcon == other.obscureTextIcon &&
        visibleTextIcon == other.visibleTextIcon &&
        enabledBorderSide == other.enabledBorderSide &&
        iconColor == other.iconColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      labelTextStyle,
      textStyle,
      hintTextStyle,
      fillColor,
      contentPadding,
      borderRadius,
      borderSide,
      focusedBorderSide,
      obscureTextIcon,
      visibleTextIcon,
      enabledBorderSide,
      iconColor,
    );
  }
}

class MechanixTextInputTheme extends InheritedTheme {
  const MechanixTextInputTheme({
    super.key,
    required this.style,
    required super.child,
  });

  final MechanixTextInputThemeData style;

  static MechanixTextInputThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixTextInputTheme>();
    return theme?.style ??
        Theme.of(context).extension<MechanixTextInputThemeData>() ??
        const MechanixTextInputThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixTextInputTheme(
      style: style,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(MechanixTextInputTheme oldWidget) {
    return style != oldWidget.style;
  }
}
