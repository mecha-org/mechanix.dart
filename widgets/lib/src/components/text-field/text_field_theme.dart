import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme configuration for [MechanixTextField].
///
/// Can be provided globally via [ThemeData.extensions] or scoped using
/// [MechanixTextFieldTheme].
@immutable
class TextFieldThemeDataConfig
    extends ThemeExtension<TextFieldThemeDataConfig>
    with Diagnosticable {
  const TextFieldThemeDataConfig({
    this.fillColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.contentPadding,
    this.labelStyle,
    this.floatingLabelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.prefixIconColor,
    this.suffixIconColor,
    this.cursorColor,
  });

  /// The background fill color of the text field container across interaction states.
  final WidgetStateProperty<Color?>? fillColor;

  /// The border color across interaction states (resting, hover, focus, error, disabled).
  final WidgetStateProperty<Color?>? borderColor;

  /// The border line width across interaction states.
  final WidgetStateProperty<double?>? borderWidth;

  /// The border radius applied to the text field borders.
  final BorderRadius? borderRadius;

  /// Padding within the text field content area.
  final EdgeInsetsGeometry? contentPadding;

  /// Style applied to the resting label.
  final TextStyle? labelStyle;

  /// Style applied to the floating label.
  final TextStyle? floatingLabelStyle;

  /// Style applied to placeholder / hint text.
  final TextStyle? hintStyle;

  /// Style applied to supporting / helper text.
  final TextStyle? helperStyle;

  /// Style applied to error text.
  final TextStyle? errorStyle;

  /// Color applied to the prefix icon.
  final Color? prefixIconColor;

  /// Color applied to the suffix icon.
  final Color? suffixIconColor;

  /// Color applied to the insertion cursor.
  final Color? cursorColor;

  @override
  TextFieldThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? borderColor,
    WidgetStateProperty<double?>? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    TextStyle? hintStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    Color? prefixIconColor,
    Color? suffixIconColor,
    Color? cursorColor,
  }) {
    return TextFieldThemeDataConfig(
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      labelStyle: labelStyle ?? this.labelStyle,
      floatingLabelStyle: floatingLabelStyle ?? this.floatingLabelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
      suffixIconColor: suffixIconColor ?? this.suffixIconColor,
      cursorColor: cursorColor ?? this.cursorColor,
    );
  }

  TextFieldThemeDataConfig merge(TextFieldThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      fillColor: other.fillColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      contentPadding: other.contentPadding,
      labelStyle: other.labelStyle,
      floatingLabelStyle: other.floatingLabelStyle,
      hintStyle: other.hintStyle,
      helperStyle: other.helperStyle,
      errorStyle: other.errorStyle,
      prefixIconColor: other.prefixIconColor,
      suffixIconColor: other.suffixIconColor,
      cursorColor: other.cursorColor,
    );
  }

  @override
  TextFieldThemeDataConfig lerp(
    ThemeExtension<TextFieldThemeDataConfig>? other,
    double t,
  ) {
    if (other is! TextFieldThemeDataConfig) return this;
    return TextFieldThemeDataConfig(
      fillColor: WidgetStateProperty.lerp<Color?>(
        fillColor,
        other.fillColor,
        t,
        Color.lerp,
      ),
      borderColor: WidgetStateProperty.lerp<Color?>(
        borderColor,
        other.borderColor,
        t,
        Color.lerp,
      ),
      borderWidth: WidgetStateProperty.lerp<double?>(
        borderWidth,
        other.borderWidth,
        t,
        lerpDouble,
      ),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t),
      floatingLabelStyle:
          TextStyle.lerp(floatingLabelStyle, other.floatingLabelStyle, t),
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t),
      helperStyle: TextStyle.lerp(helperStyle, other.helperStyle, t),
      errorStyle: TextStyle.lerp(errorStyle, other.errorStyle, t),
      prefixIconColor: Color.lerp(prefixIconColor, other.prefixIconColor, t),
      suffixIconColor: Color.lerp(suffixIconColor, other.suffixIconColor, t),
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('fillColor', fillColor));
    properties.add(DiagnosticsProperty('borderColor', borderColor));
    properties.add(DiagnosticsProperty('borderWidth', borderWidth));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('contentPadding', contentPadding));
    properties.add(DiagnosticsProperty('labelStyle', labelStyle));
    properties.add(DiagnosticsProperty('floatingLabelStyle', floatingLabelStyle));
    properties.add(DiagnosticsProperty('hintStyle', hintStyle));
    properties.add(DiagnosticsProperty('helperStyle', helperStyle));
    properties.add(DiagnosticsProperty('errorStyle', errorStyle));
    properties.add(ColorProperty('prefixIconColor', prefixIconColor));
    properties.add(ColorProperty('suffixIconColor', suffixIconColor));
    properties.add(ColorProperty('cursorColor', cursorColor));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextFieldThemeDataConfig &&
        fillColor == other.fillColor &&
        borderColor == other.borderColor &&
        borderWidth == other.borderWidth &&
        borderRadius == other.borderRadius &&
        contentPadding == other.contentPadding &&
        labelStyle == other.labelStyle &&
        floatingLabelStyle == other.floatingLabelStyle &&
        hintStyle == other.hintStyle &&
        helperStyle == other.helperStyle &&
        errorStyle == other.errorStyle &&
        prefixIconColor == other.prefixIconColor &&
        suffixIconColor == other.suffixIconColor &&
        cursorColor == other.cursorColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      fillColor,
      borderColor,
      borderWidth,
      borderRadius,
      contentPadding,
      labelStyle,
      floatingLabelStyle,
      hintStyle,
      helperStyle,
      errorStyle,
      prefixIconColor,
      suffixIconColor,
      cursorColor,
    );
  }
}

/// An inherited widget that scopes [TextFieldThemeDataConfig] down the widget tree.
class MechanixTextFieldTheme extends InheritedTheme {
  const MechanixTextFieldTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final TextFieldThemeDataConfig data;

  /// Resolves the nearest [TextFieldThemeDataConfig] from the given [context].
  static TextFieldThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixTextFieldTheme>();
    return theme?.data ??
        Theme.of(context).extension<TextFieldThemeDataConfig>() ??
        const TextFieldThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixTextFieldTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixTextFieldTheme oldWidget) {
    return data != oldWidget.data;
  }
}
