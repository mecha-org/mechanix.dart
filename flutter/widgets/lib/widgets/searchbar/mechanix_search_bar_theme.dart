import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSearchBarThemeData
    extends ThemeExtension<MechanixSearchBarThemeData> with Diagnosticable {
  const MechanixSearchBarThemeData({
    this.side,
    this.backgroundColor,
    this.overlayColor,
    this.hintText,
    this.hintStyle,
    this.leading,
    this.trailing,
    this.showDefaultTrailing = true,
  });

  final WidgetStateProperty<BorderSide?>? side;
  final WidgetStateProperty<Color?>? backgroundColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final String? hintText;
  final WidgetStateProperty<TextStyle?>? hintStyle;
  final Widget? leading;
  final List<Widget>? trailing;
  final bool showDefaultTrailing;

  @override
  MechanixSearchBarThemeData copyWith({
    WidgetStateProperty<BorderSide?>? side,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    String? hintText,
    WidgetStateProperty<TextStyle?>? hintStyle,
    Widget? leading,
    List<Widget>? trailing,
    bool? showDefaultTrailing,
  }) {
    return MechanixSearchBarThemeData(
      side: side ?? this.side,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      showDefaultTrailing: showDefaultTrailing ?? this.showDefaultTrailing,
    );
  }

  MechanixSearchBarThemeData mergeWith({
    WidgetStateProperty<BorderSide?>? side,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    String? hintText,
    WidgetStateProperty<TextStyle?>? hintStyle,
    Widget? leading,
    List<Widget>? trailing,
    bool? showDefaultTrailing,
  }) {
    return copyWith(
      side: side ?? this.side,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      showDefaultTrailing: showDefaultTrailing ?? this.showDefaultTrailing,
    );
  }

  @override
  MechanixSearchBarThemeData lerp(
    ThemeExtension<MechanixSearchBarThemeData>? other,
    double t,
  ) {
    if (other is! MechanixSearchBarThemeData) return this;

    return MechanixSearchBarThemeData(
      side: WidgetStateProperty.lerp<BorderSide?>(
        side,
        other.side,
        t,
        (BorderSide? a, BorderSide? b, double t) {
          if (a == null && b == null) return null;
          return BorderSide.lerp(a ?? b!, b ?? a!, t);
        },
      ),
      backgroundColor: WidgetStateProperty.lerp<Color?>(
          backgroundColor, other.backgroundColor, t, Color.lerp),
      overlayColor: WidgetStateProperty.lerp<Color?>(
          overlayColor, other.overlayColor, t, Color.lerp),
      hintText: t < 0.5 ? hintText : other.hintText,
      hintStyle: WidgetStateProperty.lerp<TextStyle?>(
          hintStyle, other.hintStyle, t, TextStyle.lerp),
      leading: t < 0.5 ? leading : other.leading,
      trailing: t < 0.5 ? trailing : other.trailing,
      showDefaultTrailing:
          t < 0.5 ? showDefaultTrailing : other.showDefaultTrailing,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('side', side));
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('overlayColor', overlayColor));
    properties.add(StringProperty('hintText', hintText));
    properties.add(DiagnosticsProperty('hintStyle', hintStyle));
    properties.add(DiagnosticsProperty('leading', leading));
    properties.add(IterableProperty('trailing', trailing));
    properties.add(FlagProperty(
      'showDefaultTrailing',
      value: showDefaultTrailing,
      ifTrue: 'true',
      ifFalse: 'false',
    ));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSearchBarThemeData &&
        other.side == side &&
        other.backgroundColor == backgroundColor &&
        other.overlayColor == overlayColor &&
        other.hintText == hintText &&
        other.hintStyle == hintStyle &&
        other.leading == leading &&
        other.trailing == trailing &&
        other.showDefaultTrailing == showDefaultTrailing;
  }

  @override
  int get hashCode => Object.hash(
        side,
        backgroundColor,
        overlayColor,
        hintText,
        hintStyle,
        leading,
        trailing,
        showDefaultTrailing,
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
