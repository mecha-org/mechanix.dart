import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme configuration for [MechanixListTile].
///
/// Can be provided globally via [ThemeData.extensions] or scoped using
/// [MechanixListTileTheme].
@immutable
class ListTileThemeDataConfig
    extends ThemeExtension<ListTileThemeDataConfig>
    with Diagnosticable {
  const ListTileThemeDataConfig({
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.selectedColor,
    this.disabledColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.showFocusIndicator,
    this.contentPadding,
    this.borderRadius,
    this.gap,
    this.minHeight,
    this.labelStyle,
    this.overlineStyle,
    this.supportingTextStyle,
    this.trailingTextStyle,
    this.leadingIconColor,
    this.trailingIconColor,
    this.leadingIconSize,
    this.trailingIconSize,
  });

  /// The default tile background color.
  final Color? backgroundColor;

  /// Background tint when the tile is hovered.
  final Color? hoverColor;

  /// Background tint when the tile is pressed.
  final Color? pressedColor;

  /// Background tint when the tile is selected.
  final Color? selectedColor;

  /// Opacity/color tint when the tile is disabled.
  final Color? disabledColor;

  /// Border color for keyboard focus outline ring.
  final Color? focusBorderColor;

  /// Border width for keyboard focus outline ring.
  final double? focusBorderWidth;

  /// Whether the focus outline ring is displayed when focused.
  final bool? showFocusIndicator;

  /// Padding around the internal row content.
  final EdgeInsetsGeometry? contentPadding;

  /// Corner radius of the tile (especially for segmented variant).
  final BorderRadius? borderRadius;

  /// Spacing gap between leading, title content, and trailing elements.
  final double? gap;

  /// Minimum height of the tile.
  final double? minHeight;

  /// Text style applied to the primary label text.
  final TextStyle? labelStyle;

  /// Text style applied to the uppercase overline text.
  final TextStyle? overlineStyle;

  /// Text style applied to the supporting description text.
  final TextStyle? supportingTextStyle;

  /// Text style applied to the trailing text (e.g. shortcut).
  final TextStyle? trailingTextStyle;

  /// Default color for the leading icon.
  final Color? leadingIconColor;

  /// Default color for the trailing icon.
  final Color? trailingIconColor;

  /// Default size for the leading icon.
  final double? leadingIconSize;

  /// Default size for the trailing icon.
  final double? trailingIconSize;

  @override
  ListTileThemeDataConfig copyWith({
    Color? backgroundColor,
    Color? hoverColor,
    Color? pressedColor,
    Color? selectedColor,
    Color? disabledColor,
    Color? focusBorderColor,
    double? focusBorderWidth,
    bool? showFocusIndicator,
    EdgeInsetsGeometry? contentPadding,
    BorderRadius? borderRadius,
    double? gap,
    double? minHeight,
    TextStyle? labelStyle,
    TextStyle? overlineStyle,
    TextStyle? supportingTextStyle,
    TextStyle? trailingTextStyle,
    Color? leadingIconColor,
    Color? trailingIconColor,
    double? leadingIconSize,
    double? trailingIconSize,
  }) {
    return ListTileThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverColor: hoverColor ?? this.hoverColor,
      pressedColor: pressedColor ?? this.pressedColor,
      selectedColor: selectedColor ?? this.selectedColor,
      disabledColor: disabledColor ?? this.disabledColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth,
      showFocusIndicator: showFocusIndicator ?? this.showFocusIndicator,
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      minHeight: minHeight ?? this.minHeight,
      labelStyle: labelStyle ?? this.labelStyle,
      overlineStyle: overlineStyle ?? this.overlineStyle,
      supportingTextStyle: supportingTextStyle ?? this.supportingTextStyle,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      leadingIconSize: leadingIconSize ?? this.leadingIconSize,
      trailingIconSize: trailingIconSize ?? this.trailingIconSize,
    );
  }

  /// Merges another [ListTileThemeDataConfig] into this one.
  ListTileThemeDataConfig merge(ListTileThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      hoverColor: other.hoverColor,
      pressedColor: other.pressedColor,
      selectedColor: other.selectedColor,
      disabledColor: other.disabledColor,
      focusBorderColor: other.focusBorderColor,
      focusBorderWidth: other.focusBorderWidth,
      showFocusIndicator: other.showFocusIndicator,
      contentPadding: other.contentPadding,
      borderRadius: other.borderRadius,
      gap: other.gap,
      minHeight: other.minHeight,
      labelStyle: other.labelStyle,
      overlineStyle: other.overlineStyle,
      supportingTextStyle: other.supportingTextStyle,
      trailingTextStyle: other.trailingTextStyle,
      leadingIconColor: other.leadingIconColor,
      trailingIconColor: other.trailingIconColor,
      leadingIconSize: other.leadingIconSize,
      trailingIconSize: other.trailingIconSize,
    );
  }

  @override
  ListTileThemeDataConfig lerp(
    covariant ListTileThemeDataConfig? other,
    double t,
  ) {
    if (other == null) return this;
    return ListTileThemeDataConfig(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t),
      pressedColor: Color.lerp(pressedColor, other.pressedColor, t),
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
      focusBorderColor:
          Color.lerp(focusBorderColor, other.focusBorderColor, t),
      focusBorderWidth:
          lerpDouble(focusBorderWidth, other.focusBorderWidth, t),
      showFocusIndicator: t < 0.5 ? showFocusIndicator : other.showFocusIndicator,
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      borderRadius:
          BorderRadius.lerp(borderRadius, other.borderRadius, t),
      gap: lerpDouble(gap, other.gap, t),
      minHeight: lerpDouble(minHeight, other.minHeight, t),
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t),
      overlineStyle: TextStyle.lerp(overlineStyle, other.overlineStyle, t),
      supportingTextStyle:
          TextStyle.lerp(supportingTextStyle, other.supportingTextStyle, t),
      trailingTextStyle:
          TextStyle.lerp(trailingTextStyle, other.trailingTextStyle, t),
      leadingIconColor:
          Color.lerp(leadingIconColor, other.leadingIconColor, t),
      trailingIconColor:
          Color.lerp(trailingIconColor, other.trailingIconColor, t),
      leadingIconSize:
          lerpDouble(leadingIconSize, other.leadingIconSize, t),
      trailingIconSize:
          lerpDouble(trailingIconSize, other.trailingIconSize, t),
    );
  }

  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }
}

/// An inherited widget that provides [ListTileThemeDataConfig] to its descendants.
class MechanixListTileTheme extends InheritedTheme {
  const MechanixListTileTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final ListTileThemeDataConfig data;

  /// Returns the nearest [ListTileThemeDataConfig] from the given [context].
  static ListTileThemeDataConfig of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MechanixListTileTheme>();
    return theme?.data ??
        Theme.of(context).extension<ListTileThemeDataConfig>() ??
        const ListTileThemeDataConfig();
  }

  @override
  bool updateShouldNotify(MechanixListTileTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixListTileTheme(data: data, child: child);
  }
}
