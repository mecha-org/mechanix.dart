import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../foundation/typography/typography.dart';

/// Defines default property values for descendant [MechanixSnackbar] widgets.
@immutable
class MechanixSnackbarThemeData
    extends ThemeExtension<MechanixSnackbarThemeData>
    with Diagnosticable {
  const MechanixSnackbarThemeData({
    this.backgroundColor,
    this.foregroundColor,
    this.actionColor,
    this.actionHoverColor,
    this.closeIconColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.maxWidth,
    this.behavior,
    this.actionOverflowThreshold,
    this.contentTextStyle,
    this.actionTextStyle,
    this.showFocusIndicator,
    this.focusBorderColor,
  });

  /// The background color of the snackbar container.
  final Color? backgroundColor;

  /// The default color for the supporting message text.
  final Color? foregroundColor;

  /// The text and ripple color of the action button.
  final Color? actionColor;

  /// Hover overlay color for the action button.
  final Color? actionHoverColor;

  /// The color of the optional dismiss '✕' icon.
  final Color? closeIconColor;

  /// The border outline color of the snackbar container.
  final Color? borderColor;

  /// The border width of the snackbar outline.
  final double? borderWidth;

  /// The border radius applied to the corners of the snackbar container.
  final BorderRadius? borderRadius;

  /// The z-coordinate elevation of the snackbar container.
  final double? elevation;

  /// The inner padding between the snackbar border and its content.
  final EdgeInsetsGeometry? padding;

  /// The outer margin surrounding the floating snackbar.
  final EdgeInsetsGeometry? margin;

  /// The maximum layout width for the snackbar on wide desktop windows.
  final double? maxWidth;

  /// The default behavior ([SnackBarBehavior.floating] or [SnackBarBehavior.fixed]).
  final SnackBarBehavior? behavior;

  /// The threshold ratio (0.0 to 1.0) of action width to snackbar width above
  /// which layout automatically switches from inline to stacked.
  final double? actionOverflowThreshold;

  /// The text style applied to the message text.
  final TextStyle? contentTextStyle;

  /// The text style applied to the action button label.
  final TextStyle? actionTextStyle;

  /// Whether to display a focus ring around the action or close button when keyboard focused.
  final bool? showFocusIndicator;

  /// The color of the keyboard focus ring.
  final Color? focusBorderColor;

  /// Creates a standard [MechanixSnackbarThemeData] configured with Mechanix design tokens.
  factory MechanixSnackbarThemeData.standard(
    ColorScheme colorScheme, [
    TextTheme? textTheme,
  ]) {
    final isDark = colorScheme.brightness == Brightness.dark;

    // Following Material 3, dark mode uses surfaceContainer / surfaceContainerHigh with outline,
    // and light mode uses inverseSurface so the snackbar remains a high-contrast toast.
    final Color bg = isDark
        ? colorScheme.surfaceContainer
        : colorScheme.inverseSurface;
    final Color fg = isDark
        ? colorScheme.onSurface
        : colorScheme.onInverseSurface;
    final Color actionCol = colorScheme.primary;
    final Color closeCol = colorScheme.primary;
    final Color borderCol = isDark
        ? colorScheme.outline
        : colorScheme.outlineVariant;

    final TextStyle baseContentStyle = textTheme?.bodyMedium ??
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: mechanixFontFamily,
          color: fg,
        );

    final TextStyle baseActionStyle = textTheme?.labelLarge ??
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: mechanixFontFamily,
          color: actionCol,
        );

    return MechanixSnackbarThemeData(
      backgroundColor: bg,
      foregroundColor: fg,
      actionColor: actionCol,
      actionHoverColor: actionCol.withValues(alpha: 0.12),
      closeIconColor: closeCol,
      borderColor: borderCol,
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(8.0),
      elevation: 2.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      maxWidth: 672.0,
      behavior: SnackBarBehavior.floating,
      actionOverflowThreshold: 0.25,
      contentTextStyle: baseContentStyle.copyWith(color: fg),
      actionTextStyle: baseActionStyle.copyWith(color: actionCol),
      showFocusIndicator: true,
      focusBorderColor: actionCol,
    );
  }

  @override
  MechanixSnackbarThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? actionColor,
    Color? actionHoverColor,
    Color? closeIconColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    double? elevation,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? maxWidth,
    SnackBarBehavior? behavior,
    double? actionOverflowThreshold,
    TextStyle? contentTextStyle,
    TextStyle? actionTextStyle,
    bool? showFocusIndicator,
    Color? focusBorderColor,
  }) {
    return MechanixSnackbarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      actionColor: actionColor ?? this.actionColor,
      actionHoverColor: actionHoverColor ?? this.actionHoverColor,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      maxWidth: maxWidth ?? this.maxWidth,
      behavior: behavior ?? this.behavior,
      actionOverflowThreshold:
          actionOverflowThreshold ?? this.actionOverflowThreshold,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      showFocusIndicator: showFocusIndicator ?? this.showFocusIndicator,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
    );
  }

  @override
  MechanixSnackbarThemeData lerp(
    ThemeExtension<MechanixSnackbarThemeData>? other,
    double t,
  ) {
    if (other is! MechanixSnackbarThemeData) return this;
    return MechanixSnackbarThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      actionColor: Color.lerp(actionColor, other.actionColor, t),
      actionHoverColor:
          Color.lerp(actionHoverColor, other.actionHoverColor, t),
      closeIconColor: Color.lerp(closeIconColor, other.closeIconColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      maxWidth: lerpDouble(maxWidth, other.maxWidth, t),
      behavior: t < 0.5 ? behavior : other.behavior,
      actionOverflowThreshold: lerpDouble(
        actionOverflowThreshold,
        other.actionOverflowThreshold,
        t,
      ),
      contentTextStyle:
          TextStyle.lerp(contentTextStyle, other.contentTextStyle, t),
      actionTextStyle:
          TextStyle.lerp(actionTextStyle, other.actionTextStyle, t),
      showFocusIndicator:
          t < 0.5 ? showFocusIndicator : other.showFocusIndicator,
      focusBorderColor:
          Color.lerp(focusBorderColor, other.focusBorderColor, t),
    );
  }

  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSnackbarThemeData &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.actionColor == actionColor &&
        other.actionHoverColor == actionHoverColor &&
        other.closeIconColor == closeIconColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.elevation == elevation &&
        other.padding == padding &&
        other.margin == margin &&
        other.maxWidth == maxWidth &&
        other.behavior == behavior &&
        other.actionOverflowThreshold == actionOverflowThreshold &&
        other.contentTextStyle == contentTextStyle &&
        other.actionTextStyle == actionTextStyle &&
        other.showFocusIndicator == showFocusIndicator &&
        other.focusBorderColor == focusBorderColor;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        foregroundColor,
        actionColor,
        actionHoverColor,
        closeIconColor,
        borderColor,
        borderWidth,
        borderRadius,
        elevation,
        padding,
        margin,
        maxWidth,
        behavior,
        actionOverflowThreshold,
        contentTextStyle,
        actionTextStyle,
        showFocusIndicator,
        focusBorderColor,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('foregroundColor', foregroundColor));
    properties.add(ColorProperty('actionColor', actionColor));
    properties.add(ColorProperty('borderColor', borderColor));
    properties.add(DoubleProperty('borderWidth', borderWidth));
    properties.add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin));
    properties.add(DoubleProperty('maxWidth', maxWidth));
    properties.add(EnumProperty<SnackBarBehavior>('behavior', behavior));
    properties.add(DoubleProperty('actionOverflowThreshold', actionOverflowThreshold));
  }
}

/// An inherited widget that defines the visual properties of [MechanixSnackbar]
/// in its widget subtree.
class MechanixSnackbarTheme extends InheritedTheme {
  const MechanixSnackbarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration of this theme.
  final MechanixSnackbarThemeData data;

  /// Returns the [MechanixSnackbarThemeData] from the closest ancestor [MechanixSnackbarTheme].
  static MechanixSnackbarThemeData of(BuildContext context) {
    final MechanixSnackbarTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<MechanixSnackbarTheme>();
    return inheritedTheme?.data ??
        Theme.of(context).extension<MechanixSnackbarThemeData>() ??
        MechanixSnackbarThemeData.standard(
          Theme.of(context).colorScheme,
          Theme.of(context).textTheme,
        );
  }

  /// Returns the [MechanixSnackbarThemeData] from the closest ancestor [MechanixSnackbarTheme],
  /// or null if none is found.
  static MechanixSnackbarThemeData? maybeOf(BuildContext context) {
    final MechanixSnackbarTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<MechanixSnackbarTheme>();
    return inheritedTheme?.data ??
        Theme.of(context).extension<MechanixSnackbarThemeData>();
  }

  @override
  bool updateShouldNotify(MechanixSnackbarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSnackbarTheme(data: data, child: child);
  }
}
