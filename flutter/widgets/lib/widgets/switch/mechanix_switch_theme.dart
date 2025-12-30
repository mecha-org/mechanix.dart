import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MechanixSwitchStyle with Diagnosticable {
  const MechanixSwitchStyle({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeTrackGradient,
    this.inactiveTrackGradient,
    this.trackBorder,
    this.trackShadow,
    // Thumb styling
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbGradient,
    this.thumbBorder,
    this.thumbShadow,
    this.thumbSpacing = const EdgeInsets.symmetric(horizontal: 12),
    this.activeThumbIcon,
    this.inactiveThumbIcon,
    // Dimensions
    this.width = 76.0,
    this.height = 36.0,
    this.trackPadding = 6.0,
    this.thumbSize = const Size(24, 24),
    // Border radius
    this.trackBorderRadius = const BorderRadius.all(Radius.circular(6.0)),
    this.thumbBorderRadius = const BorderRadius.all(Radius.circular(4.0)),
    // Animation
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    // Text
    this.activeTextStyle = const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    this.inactiveTextStyle = const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    // Interaction
    this.dragThreshold = 0.5,
    this.dragSensitivity = 1.0,
  })  : assert(width != null && width > 0, 'Width must be positive'),
        assert(height != null && height > 0, 'Height must be positive'),
        assert(trackPadding != null && trackPadding >= 0,
            'Track padding must be non-negative'),
        assert(
            dragThreshold != null &&
                dragThreshold >= 0.0 &&
                dragThreshold <= 1.0,
            'Drag threshold must be between 0.0 and 1.0');

  // Track Customization
  /// Color of the track when switch is active/on
  final Color? activeTrackColor;

  /// Color of the track when switch is inactive/off
  final Color? inactiveTrackColor;

  /// Gradient for active track (overrides activeTrackColor if provided)
  final Gradient? activeTrackGradient;

  /// Gradient for inactive track (overrides inactiveTrackColor if provided)
  final Gradient? inactiveTrackGradient;

  /// Border for the track
  final Border? trackBorder;

  /// Shadow for the track
  final List<BoxShadow>? trackShadow;

  /// Color of the thumb when active/on
  final Color? activeThumbColor;

  /// Color of the thumb when inactive/off
  final Color? inactiveThumbColor;

  /// Gradient for thumb (overrides thumbColor if provided)
  final Gradient? thumbGradient;

  /// Border for the thumb
  final Border? thumbBorder;

  /// Shadow for the thumb
  final List<BoxShadow>? thumbShadow;

  /// Spacing around the thumb (top, right, bottom, left)
  final EdgeInsets? thumbSpacing;

  /// Icon to display on the thumb when active
  final Widget? activeThumbIcon;

  /// Icon to display on the thumb when inactive
  final Widget? inactiveThumbIcon;

  // Dimensions
  /// Width of the entire switch
  final double? width;

  /// Height of the entire switch
  final double? height;

  /// Margin/padding inside the track
  final double? trackPadding;

  /// Custom thumb size (if null, calculated from height and trackPadding)
  final Size? thumbSize;

  // Border Radius
  /// Border radius of the track
  final BorderRadius? trackBorderRadius;

  /// Border radius of the thumb
  final BorderRadius? thumbBorderRadius;

  // Animation
  /// Duration of the switch animation
  final Duration? animationDuration;

  /// Animation curve for the switch transition
  final Curve? animationCurve;

  /// Text style for active text
  final TextStyle? activeTextStyle;

  /// Text style for inactive text
  final TextStyle? inactiveTextStyle;

  // Interaction
  /// Minimum drag distance to trigger switch
  final double? dragThreshold;

  /// Custom drag sensitivity (1.0 = normal, <1.0 = less sensitive, >1.0 = more sensitive)
  final double? dragSensitivity;
  // 26 properties
  MechanixSwitchStyle copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Gradient? activeTrackGradient,
    Gradient? inactiveTrackGradient,
    Border? trackBorder,
    List<BoxShadow>? trackShadow,
    Gradient? thumbGradient,
    Border? thumbBorder,
    List<BoxShadow>? thumbShadow,
    Widget? activeThumbIcon,
    Widget? inactiveThumbIcon,
    double? width,
    double? height,
    double? trackPadding,
    Size? thumbSize,
    BorderRadius? trackBorderRadius,
    BorderRadius? thumbBorderRadius,
    Duration? animationDuration,
    Curve? animationCurve,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    double? dragThreshold,
    double? dragSensitivity,
    Color? activeThumbColor,
    Color? inactiveThumbColor,
  }) {
    return MechanixSwitchStyle(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeTrackGradient: activeTrackGradient ?? this.activeTrackGradient,
      inactiveTrackGradient:
          inactiveTrackGradient ?? this.inactiveTrackGradient,
      trackBorder: trackBorder ?? this.trackBorder,
      trackShadow: trackShadow ?? this.trackShadow,
      activeThumbColor: activeThumbColor ?? this.activeThumbColor,
      inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
      thumbGradient: thumbGradient ?? this.thumbGradient,
      thumbBorder: thumbBorder ?? this.thumbBorder,
      thumbShadow: thumbShadow ?? this.thumbShadow,
      thumbSpacing: thumbSpacing,
      activeThumbIcon: activeThumbIcon ?? this.activeThumbIcon,
      inactiveThumbIcon: inactiveThumbIcon ?? this.inactiveThumbIcon,
      width: width ?? this.width,
      height: height ?? this.height,
      trackPadding: trackPadding ?? this.trackPadding,
      thumbSize: thumbSize ?? this.thumbSize,
      trackBorderRadius: trackBorderRadius ?? this.trackBorderRadius,
      thumbBorderRadius: thumbBorderRadius ?? this.thumbBorderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
      dragThreshold: dragThreshold ?? this.dragThreshold,
      dragSensitivity: dragSensitivity ?? this.dragSensitivity,
    );
  }

  // Method to merge with another style (theme + widget override)
  MechanixSwitchStyle merge(MechanixSwitchStyle? other) {
    if (other == null) return this;

    return MechanixSwitchStyle(
      activeTrackColor: other.activeTrackColor ?? activeTrackColor,
      inactiveTrackColor: other.inactiveTrackColor ?? inactiveTrackColor,
      activeTrackGradient: other.activeTrackGradient ?? activeTrackGradient,
      inactiveTrackGradient:
          other.inactiveTrackGradient ?? inactiveTrackGradient,
      trackBorder: other.trackBorder ?? trackBorder,
      trackShadow: other.trackShadow ?? trackShadow,
      activeThumbColor: other.activeThumbColor ?? activeThumbColor,
      inactiveThumbColor: other.inactiveThumbColor ?? inactiveThumbColor,
      thumbGradient: other.thumbGradient ?? thumbGradient,
      thumbBorder: other.thumbBorder ?? thumbBorder,
      thumbShadow: other.thumbShadow ?? thumbShadow,
      thumbSpacing: other.thumbSpacing ?? thumbSpacing,
      activeThumbIcon: other.activeThumbIcon ?? activeThumbIcon,
      inactiveThumbIcon: other.inactiveThumbIcon ?? inactiveThumbIcon,
      width: other.width ?? width,
      height: other.height ?? height,
      trackPadding: other.trackPadding ?? trackPadding,
      thumbSize: other.thumbSize ?? thumbSize,
      trackBorderRadius: other.trackBorderRadius ?? trackBorderRadius,
      thumbBorderRadius: other.thumbBorderRadius ?? thumbBorderRadius,
      animationDuration: other.animationDuration ?? animationDuration,
      animationCurve: other.animationCurve ?? animationCurve,
      activeTextStyle: other.activeTextStyle ?? activeTextStyle,
      inactiveTextStyle: other.inactiveTextStyle ?? inactiveTextStyle,
      dragThreshold: other.dragThreshold ?? dragThreshold,
      dragSensitivity: other.dragSensitivity ?? dragSensitivity,
    );
  }

  static MechanixSwitchStyle resolveWith(
      BuildContext context, MechanixSwitchStyle? style) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Create defaults based on current theme
    final defaultStyle = MechanixSwitchStyle(
      // Use theme colors as defaults
      activeTrackColor: colorScheme.surface,
      inactiveTrackColor: colorScheme.primary,
      activeThumbColor: colorScheme.primary,

      inactiveThumbColor: colorScheme.onSurface.withValues(alpha: 0.6),
      activeTextStyle: textTheme.labelMedium?.copyWith(
        // color: colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      ),
      inactiveTextStyle: textTheme.labelMedium?.copyWith(
        // color: colorScheme.onSurface.withValues(alpha: 0.6),
        fontWeight: FontWeight.w600,
      ),
      trackShadow: [
        BoxShadow(
          color: colorScheme.shadow.withValues(alpha: 0.1),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
      thumbShadow: [
        BoxShadow(
          color: colorScheme.shadow.withValues(alpha: 0.2),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    );

    // Merge with provided style
    return defaultStyle.merge(style);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    // Colors and gradients
    properties.add(ColorProperty('activeTrackColor', activeTrackColor));
    properties.add(ColorProperty('inactiveTrackColor', inactiveTrackColor));
    properties.add(DiagnosticsProperty<Gradient>(
        'activeTrackGradient', activeTrackGradient));
    properties.add(DiagnosticsProperty<Gradient>(
        'inactiveTrackGradient', inactiveTrackGradient));

    // Track styling
    properties.add(DiagnosticsProperty<Border>('trackBorder', trackBorder));
    properties.add(IterableProperty<BoxShadow>('trackShadow', trackShadow));
    properties.add(DoubleProperty('trackPadding', trackPadding));
    properties.add(DiagnosticsProperty<BorderRadius>(
        'trackBorderRadius', trackBorderRadius));

    // Thumb styling
    properties.add(ColorProperty('activeThumbColor', activeThumbColor));
    properties.add(ColorProperty('inactiveThumbColor', inactiveThumbColor));
    properties.add(
        DiagnosticsProperty<EdgeInsetsGeometry>('thumbSpacing', thumbSpacing));
    properties
        .add(DiagnosticsProperty<Gradient>('thumbGradient', thumbGradient));
    properties.add(DiagnosticsProperty<Border>('thumbBorder', thumbBorder));
    properties.add(IterableProperty<BoxShadow>('thumbShadow', thumbShadow));
    properties.add(DiagnosticsProperty<Size>('thumbSize', thumbSize));
    properties.add(DiagnosticsProperty<BorderRadius>(
        'thumbBorderRadius', thumbBorderRadius));

    // Thumb icons
    properties
        .add(DiagnosticsProperty<Widget>('activeThumbIcon', activeThumbIcon));
    properties.add(
        DiagnosticsProperty<Widget>('inactiveThumbIcon', inactiveThumbIcon));

    // Dimensions
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));

    // Animation
    properties.add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration));
    properties
        .add(DiagnosticsProperty<Curve>('animationCurve', animationCurve));

    // Text styles
    properties.add(
        DiagnosticsProperty<TextStyle>('activeTextStyle', activeTextStyle));
    properties.add(
        DiagnosticsProperty<TextStyle>('inactiveTextStyle', inactiveTextStyle));

    // Interaction
    properties.add(DoubleProperty('dragThreshold', dragThreshold));
    properties.add(DoubleProperty('dragSensitivity', dragSensitivity));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixSwitchStyle &&
        other.activeTrackColor == activeTrackColor &&
        other.inactiveTrackColor == inactiveTrackColor &&
        other.activeTrackGradient == activeTrackGradient &&
        other.inactiveTrackGradient == inactiveTrackGradient &&
        other.trackBorder == trackBorder &&
        other.trackShadow == trackShadow &&
        other.inactiveThumbColor == inactiveThumbColor &&
        other.activeThumbColor == activeThumbColor &&
        other.thumbSpacing == thumbSpacing &&
        other.thumbGradient == thumbGradient &&
        other.thumbBorder == thumbBorder &&
        other.thumbShadow == thumbShadow &&
        other.activeThumbIcon == activeThumbIcon &&
        other.inactiveThumbIcon == inactiveThumbIcon &&
        other.width == width &&
        other.height == height &&
        other.trackPadding == trackPadding &&
        other.thumbSize == thumbSize &&
        other.trackBorderRadius == trackBorderRadius &&
        other.thumbBorderRadius == thumbBorderRadius &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        other.activeTextStyle == activeTextStyle &&
        other.inactiveTextStyle == inactiveTextStyle &&
        other.dragThreshold == dragThreshold &&
        other.dragSensitivity == dragSensitivity;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      activeTrackColor,
      inactiveTrackColor,
      activeTrackGradient,
      inactiveTrackGradient,
      trackBorder,
      trackShadow,
      inactiveThumbColor,
      activeThumbColor,
      thumbSpacing,
      thumbGradient,
      thumbBorder,
      thumbShadow,
      activeThumbIcon,
      inactiveThumbIcon,
      width,
      height,
      trackPadding,
      thumbSize,
      trackBorderRadius,
      thumbBorderRadius,
      animationDuration,
      animationCurve,
      activeTextStyle,
      inactiveTextStyle,
      dragThreshold,
      dragSensitivity,
    ]);
  }
}

// Theme Extension for Flutter's ThemeData
@immutable
class MechanixSwitchThemeData extends ThemeExtension<MechanixSwitchThemeData> {
  const MechanixSwitchThemeData({this.style});

  final MechanixSwitchStyle? style;

  @override
  MechanixSwitchThemeData copyWith({MechanixSwitchStyle? style}) {
    return MechanixSwitchThemeData(style: style ?? this.style);
  }

  @override
  MechanixSwitchThemeData lerp(
    ThemeExtension<MechanixSwitchThemeData>? other,
    double t,
  ) {
    if (other is! MechanixSwitchThemeData) return this;

    // For simplicity, we'll use step interpolation
    // You could implement smooth lerp for individual properties if needed
    return MechanixSwitchThemeData(style: t < 0.5 ? style : other.style);
  }

  // Static method to get the theme from context
  static MechanixSwitchStyle? of(BuildContext context) {
    final theme = Theme.of(context).extension<MechanixSwitchThemeData>();
    return theme?.style;
  }
}
