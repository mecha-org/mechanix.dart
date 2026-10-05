import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../foundation/shape/shape_theme.dart';
import '../../foundation/spacing/spacing.dart';
import '../../foundation/typography/typography.dart';
import 'menu_enums.dart';

/// Configuration for styling [MechanixMenu] and [MechanixMenuItem] via Flutter's [ThemeExtension].
///
/// Uses [WidgetStateProperty] to dynamically resolve visual styling across
/// states such as [WidgetState.hovered], [WidgetState.focused], [WidgetState.pressed],
/// [WidgetState.selected], and [WidgetState.disabled].
@immutable
class MenuThemeDataConfig extends ThemeExtension<MenuThemeDataConfig>
    with Diagnosticable {
  /// Creates a [MenuThemeDataConfig].
  const MenuThemeDataConfig({
    this.backgroundColor,
    this.surfaceColor,
    this.groupSurfaceColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.padding,
    this.regularItemHeight,
    this.smallItemHeight,
    this.itemPadding,
    this.regularIconSize,
    this.smallIconSize,
    this.iconLabelGap,
    this.regularLabelStyle,
    this.smallLabelStyle,
    this.supportingTextStyle,
    this.trailingTextStyle,
    this.headerTextStyle,
    this.itemBackgroundColor,
    this.itemForegroundColor,
    this.itemIconColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.minTapTargetSize,
    this.dividerColor,
    this.dividerHeight,
  });

  /// The default background color of the menu container.
  final Color? backgroundColor;

  /// The surface color of the menu panel.
  final Color? surfaceColor;

  /// An alternate surface color for secondary groups within the menu.
  final Color? groupSurfaceColor;

  /// Border color around the menu container.
  final Color? borderColor;

  /// Border width around the menu container. Defaults to 0.0 (no visible border).
  final double? borderWidth;

  /// Corner radius of the menu container.
  final BorderRadius? borderRadius;

  /// Elevation of the menu surface.
  final double? elevation;

  /// Shadow color cast by the elevation.
  final Color? shadowColor;

  /// Outer padding inside the menu container.
  final EdgeInsetsGeometry? padding;

  /// Height of a menu item row when using [MechanixMenuSize.regular].
  final double? regularItemHeight;

  /// Height of a menu item row when using [MechanixMenuSize.small] on pointer/desktop platforms.
  final double? smallItemHeight;

  /// Inner padding of an individual menu item row.
  final EdgeInsetsGeometry? itemPadding;

  /// Icon size for [MechanixMenuSize.regular].
  final double? regularIconSize;

  /// Icon size for [MechanixMenuSize.small].
  final double? smallIconSize;

  /// Gap between leading icon and label text.
  final double? iconLabelGap;

  /// Text style for [MechanixMenuSize.regular] item labels.
  final TextStyle? regularLabelStyle;

  /// Text style for [MechanixMenuSize.small] item labels.
  final TextStyle? smallLabelStyle;

  /// Text style for item supporting text.
  final TextStyle? supportingTextStyle;

  /// Text style for item trailing shortcut text (e.g. '⌘C').
  final TextStyle? trailingTextStyle;

  /// Text style for group header labels.
  final TextStyle? headerTextStyle;

  /// Background color of an item row across widget states.
  final WidgetStateProperty<Color?>? itemBackgroundColor;

  /// Foreground / label text color of an item row across widget states.
  final WidgetStateProperty<Color?>? itemForegroundColor;

  /// Icon color of an item row across widget states.
  final WidgetStateProperty<Color?>? itemIconColor;

  /// Focus indicator border color across widget states.
  final WidgetStateProperty<Color?>? focusBorderColor;

  /// Focus indicator outline width.
  final double? focusBorderWidth;

  /// Minimum interactive touch target size (48dp on Android/touch platforms).
  final double? minTapTargetSize;

  /// Color of separators and group dividers.
  final Color? dividerColor;

  /// Height of separators and group dividers.
  final double? dividerHeight;

  /// Resolves the item height based on the given [size].
  double resolveItemHeight(MechanixMenuSize size) {
    switch (size) {
      case MechanixMenuSize.regular:
        return regularItemHeight ?? 44.0;
      case MechanixMenuSize.small:
        return smallItemHeight ?? 36.0;
    }
  }

  /// Resolves the icon size based on the given [size].
  double resolveIconSize(MechanixMenuSize size) {
    switch (size) {
      case MechanixMenuSize.regular:
        return regularIconSize ?? 20.0;
      case MechanixMenuSize.small:
        return smallIconSize ?? 18.0;
    }
  }

  /// Resolves the label text style based on the given [size].
  TextStyle resolveLabelStyle(MechanixMenuSize size) {
    switch (size) {
      case MechanixMenuSize.regular:
        return regularLabelStyle ??
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: MechanixFontFamily.geist,
            );
      case MechanixMenuSize.small:
        return smallLabelStyle ??
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: MechanixFontFamily.geist,
            );
    }
  }

  /// Creates a standard [MenuThemeDataConfig] tailored to the provided [ColorScheme],
  /// [TextTheme], and [ShapeTheme].
  factory MenuThemeDataConfig.standard(
    ColorScheme colorScheme,
    TextTheme textTheme,
    ShapeTheme shapeTheme,
  ) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final surface = isDark
        ? colorScheme.surfaceContainerHigh
        : colorScheme.surface;
    final groupSurface = isDark
        ? colorScheme.surfaceContainerHighest
        : colorScheme.surfaceContainerLow;

    return MenuThemeDataConfig(
      backgroundColor: surface,
      surfaceColor: surface,
      groupSurfaceColor: groupSurface,
      borderColor: colorScheme.outline,
      borderWidth: 0.0,
      borderRadius: shapeTheme.small,
      elevation: 4.0,
      shadowColor: colorScheme.shadow.withValues(alpha: isDark ? 0.4 : 0.15),
      padding: const EdgeInsets.symmetric(vertical: MechanixSpacing.xxSmall),
      regularItemHeight: 44.0,
      smallItemHeight: 36.0,
      itemPadding: const EdgeInsets.symmetric(
        horizontal: MechanixSpacing.medium,
      ),
      regularIconSize: 20.0,
      smallIconSize: 18.0,
      iconLabelGap: MechanixSpacing.xSmall,
      regularLabelStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontFamily: MechanixFontFamily.geist,
      ),
      smallLabelStyle: textTheme.labelMedium?.copyWith(
        color: colorScheme.onSurface,
        fontFamily: MechanixFontFamily.geist,
      ),
      supportingTextStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontFamily: MechanixFontFamily.geist,
      ),
      trailingTextStyle: textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontFamily: MechanixFontFamily.geistMono,
      ),
      headerTextStyle: textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontFamily: MechanixFontFamily.geist,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
      itemBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onSurface.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return colorScheme.onSurface.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onSurface.withValues(alpha: 0.06);
        }
        return Colors.transparent;
      }),
      itemForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.38);
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onSurface;
        }
        return colorScheme.onSurface;
      }),
      itemIconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.38);
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onSurface;
        }
        return colorScheme.onSurfaceVariant;
      }),
      focusBorderColor: WidgetStateProperty.all(colorScheme.primary),
      focusBorderWidth: 2.0,
      minTapTargetSize: 48.0,
      dividerColor: colorScheme.outlineVariant,
      dividerHeight: 1.0,
    );
  }

  @override
  MenuThemeDataConfig copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? groupSurfaceColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    double? elevation,
    Color? shadowColor,
    EdgeInsetsGeometry? padding,
    double? regularItemHeight,
    double? smallItemHeight,
    EdgeInsetsGeometry? itemPadding,
    double? regularIconSize,
    double? smallIconSize,
    double? iconLabelGap,
    TextStyle? regularLabelStyle,
    TextStyle? smallLabelStyle,
    TextStyle? supportingTextStyle,
    TextStyle? trailingTextStyle,
    TextStyle? headerTextStyle,
    WidgetStateProperty<Color?>? itemBackgroundColor,
    WidgetStateProperty<Color?>? itemForegroundColor,
    WidgetStateProperty<Color?>? itemIconColor,
    WidgetStateProperty<Color?>? focusBorderColor,
    double? focusBorderWidth,
    double? minTapTargetSize,
    Color? dividerColor,
    double? dividerHeight,
  }) {
    return MenuThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      groupSurfaceColor: groupSurfaceColor ?? this.groupSurfaceColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      padding: padding ?? this.padding,
      regularItemHeight: regularItemHeight ?? this.regularItemHeight,
      smallItemHeight: smallItemHeight ?? this.smallItemHeight,
      itemPadding: itemPadding ?? this.itemPadding,
      regularIconSize: regularIconSize ?? this.regularIconSize,
      smallIconSize: smallIconSize ?? this.smallIconSize,
      iconLabelGap: iconLabelGap ?? this.iconLabelGap,
      regularLabelStyle: regularLabelStyle ?? this.regularLabelStyle,
      smallLabelStyle: smallLabelStyle ?? this.smallLabelStyle,
      supportingTextStyle: supportingTextStyle ?? this.supportingTextStyle,
      trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemForegroundColor: itemForegroundColor ?? this.itemForegroundColor,
      itemIconColor: itemIconColor ?? this.itemIconColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth,
      minTapTargetSize: minTapTargetSize ?? this.minTapTargetSize,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerHeight: dividerHeight ?? this.dividerHeight,
    );
  }

  /// Merges another [MenuThemeDataConfig] on top of this one.
  MenuThemeDataConfig merge(MenuThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      surfaceColor: other.surfaceColor,
      groupSurfaceColor: other.groupSurfaceColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      elevation: other.elevation,
      shadowColor: other.shadowColor,
      padding: other.padding,
      regularItemHeight: other.regularItemHeight,
      smallItemHeight: other.smallItemHeight,
      itemPadding: other.itemPadding,
      regularIconSize: other.regularIconSize,
      smallIconSize: other.smallIconSize,
      iconLabelGap: other.iconLabelGap,
      regularLabelStyle: other.regularLabelStyle,
      smallLabelStyle: other.smallLabelStyle,
      supportingTextStyle: other.supportingTextStyle,
      trailingTextStyle: other.trailingTextStyle,
      headerTextStyle: other.headerTextStyle,
      itemBackgroundColor: other.itemBackgroundColor,
      itemForegroundColor: other.itemForegroundColor,
      itemIconColor: other.itemIconColor,
      focusBorderColor: other.focusBorderColor,
      focusBorderWidth: other.focusBorderWidth,
      minTapTargetSize: other.minTapTargetSize,
      dividerColor: other.dividerColor,
      dividerHeight: other.dividerHeight,
    );
  }

  @override
  MenuThemeDataConfig lerp(
    ThemeExtension<MenuThemeDataConfig>? other,
    double t,
  ) {
    if (other is! MenuThemeDataConfig) return this;
    return MenuThemeDataConfig(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t),
      groupSurfaceColor: Color.lerp(
        groupSurfaceColor,
        other.groupSurfaceColor,
        t,
      ),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: _lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      elevation: _lerpDouble(elevation, other.elevation, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      regularItemHeight: _lerpDouble(
        regularItemHeight,
        other.regularItemHeight,
        t,
      ),
      smallItemHeight: _lerpDouble(smallItemHeight, other.smallItemHeight, t),
      itemPadding: EdgeInsetsGeometry.lerp(itemPadding, other.itemPadding, t),
      regularIconSize: _lerpDouble(regularIconSize, other.regularIconSize, t),
      smallIconSize: _lerpDouble(smallIconSize, other.smallIconSize, t),
      iconLabelGap: _lerpDouble(iconLabelGap, other.iconLabelGap, t),
      regularLabelStyle: TextStyle.lerp(
        regularLabelStyle,
        other.regularLabelStyle,
        t,
      ),
      smallLabelStyle: TextStyle.lerp(
        smallLabelStyle,
        other.smallLabelStyle,
        t,
      ),
      supportingTextStyle: TextStyle.lerp(
        supportingTextStyle,
        other.supportingTextStyle,
        t,
      ),
      trailingTextStyle: TextStyle.lerp(
        trailingTextStyle,
        other.trailingTextStyle,
        t,
      ),
      headerTextStyle: TextStyle.lerp(
        headerTextStyle,
        other.headerTextStyle,
        t,
      ),
      itemBackgroundColor: WidgetStateProperty.lerp<Color?>(
        itemBackgroundColor,
        other.itemBackgroundColor,
        t,
        Color.lerp,
      ),
      itemForegroundColor: WidgetStateProperty.lerp<Color?>(
        itemForegroundColor,
        other.itemForegroundColor,
        t,
        Color.lerp,
      ),
      itemIconColor: WidgetStateProperty.lerp<Color?>(
        itemIconColor,
        other.itemIconColor,
        t,
        Color.lerp,
      ),
      focusBorderColor: WidgetStateProperty.lerp<Color?>(
        focusBorderColor,
        other.focusBorderColor,
        t,
        Color.lerp,
      ),
      focusBorderWidth: _lerpDouble(
        focusBorderWidth,
        other.focusBorderWidth,
        t,
      ),
      minTapTargetSize: _lerpDouble(
        minTapTargetSize,
        other.minTapTargetSize,
        t,
      ),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      dividerHeight: _lerpDouble(dividerHeight, other.dividerHeight, t),
    );
  }

  static double? _lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('surfaceColor', surfaceColor));
    properties.add(DiagnosticsProperty('groupSurfaceColor', groupSurfaceColor));
    properties.add(DiagnosticsProperty('borderColor', borderColor));
    properties.add(DiagnosticsProperty('borderWidth', borderWidth));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('elevation', elevation));
    properties.add(DiagnosticsProperty('shadowColor', shadowColor));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DiagnosticsProperty('regularItemHeight', regularItemHeight));
    properties.add(DiagnosticsProperty('smallItemHeight', smallItemHeight));
    properties.add(DiagnosticsProperty('itemPadding', itemPadding));
    properties.add(DiagnosticsProperty('regularIconSize', regularIconSize));
    properties.add(DiagnosticsProperty('smallIconSize', smallIconSize));
    properties.add(DiagnosticsProperty('iconLabelGap', iconLabelGap));
    properties.add(DiagnosticsProperty('regularLabelStyle', regularLabelStyle));
    properties.add(DiagnosticsProperty('smallLabelStyle', smallLabelStyle));
    properties.add(
      DiagnosticsProperty('supportingTextStyle', supportingTextStyle),
    );
    properties.add(DiagnosticsProperty('trailingTextStyle', trailingTextStyle));
    properties.add(DiagnosticsProperty('headerTextStyle', headerTextStyle));
    properties.add(
      DiagnosticsProperty('itemBackgroundColor', itemBackgroundColor),
    );
    properties.add(
      DiagnosticsProperty('itemForegroundColor', itemForegroundColor),
    );
    properties.add(DiagnosticsProperty('itemIconColor', itemIconColor));
    properties.add(DiagnosticsProperty('focusBorderColor', focusBorderColor));
    properties.add(DiagnosticsProperty('focusBorderWidth', focusBorderWidth));
    properties.add(DiagnosticsProperty('minTapTargetSize', minTapTargetSize));
    properties.add(DiagnosticsProperty('dividerColor', dividerColor));
    properties.add(DiagnosticsProperty('dividerHeight', dividerHeight));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuThemeDataConfig &&
        backgroundColor == other.backgroundColor &&
        surfaceColor == other.surfaceColor &&
        groupSurfaceColor == other.groupSurfaceColor &&
        borderColor == other.borderColor &&
        borderWidth == other.borderWidth &&
        borderRadius == other.borderRadius &&
        elevation == other.elevation &&
        shadowColor == other.shadowColor &&
        padding == other.padding &&
        regularItemHeight == other.regularItemHeight &&
        smallItemHeight == other.smallItemHeight &&
        itemPadding == other.itemPadding &&
        regularIconSize == other.regularIconSize &&
        smallIconSize == other.smallIconSize &&
        iconLabelGap == other.iconLabelGap &&
        regularLabelStyle == other.regularLabelStyle &&
        smallLabelStyle == other.smallLabelStyle &&
        supportingTextStyle == other.supportingTextStyle &&
        trailingTextStyle == other.trailingTextStyle &&
        headerTextStyle == other.headerTextStyle &&
        itemBackgroundColor == other.itemBackgroundColor &&
        itemForegroundColor == other.itemForegroundColor &&
        itemIconColor == other.itemIconColor &&
        focusBorderColor == other.focusBorderColor &&
        focusBorderWidth == other.focusBorderWidth &&
        minTapTargetSize == other.minTapTargetSize &&
        dividerColor == other.dividerColor &&
        dividerHeight == other.dividerHeight;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      surfaceColor,
      groupSurfaceColor,
      borderColor,
      borderWidth,
      borderRadius,
      elevation,
      shadowColor,
      padding,
      regularItemHeight,
      smallItemHeight,
      itemPadding,
      regularIconSize,
      smallIconSize,
      iconLabelGap,
      regularLabelStyle,
      smallLabelStyle,
      supportingTextStyle,
      trailingTextStyle,
      headerTextStyle,
      itemBackgroundColor,
      itemForegroundColor,
      itemIconColor,
      focusBorderColor,
      focusBorderWidth,
      minTapTargetSize,
      dividerColor,
      dividerHeight,
    ]);
  }
}

/// An inherited theme widget that defines the visual properties of [MechanixMenu]
/// inside a widget tree.
class MechanixMenuTheme extends InheritedTheme {
  /// Creates a [MechanixMenuTheme].
  const MechanixMenuTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration data applied to descendant [MechanixMenu] widgets.
  final MenuThemeDataConfig data;

  /// Obtains the current [MenuThemeDataConfig] from the given [context].
  static MenuThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixMenuTheme>();
    return theme?.data ??
        Theme.of(context).extension<MenuThemeDataConfig>() ??
        const MenuThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixMenuTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixMenuTheme oldWidget) {
    return data != oldWidget.data;
  }
}
