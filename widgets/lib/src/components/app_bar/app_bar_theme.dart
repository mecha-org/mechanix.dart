import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines theme and styling properties for [MechanixAppBar] and [MechanixSliverAppBar].
///
/// Can be provided globally via [ThemeData.extensions] or scoped in the widget
/// tree using [MechanixAppBarTheme].
@immutable
class AppBarThemeDataConfig extends ThemeExtension<AppBarThemeDataConfig>
    with Diagnosticable {
  const AppBarThemeDataConfig({
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.smallTitleTextStyle,
    this.smallSupportingTextStyle,
    this.mediumTitleTextStyle,
    this.mediumSupportingTextStyle,
    this.largeTitleTextStyle,
    this.largeSupportingTextStyle,
    this.searchHintTextStyle,
    this.searchBackgroundColor,
    this.searchBorderRadius,
    this.actionsPadding,
    this.iconTheme,
    this.actionsIconTheme,
  });

  /// The background color of the app bar.
  final Color? backgroundColor;

  /// The default color for text and icons within the app bar.
  final Color? foregroundColor;

  /// The default z-coordinate elevation of the app bar.
  final double? elevation;

  /// The elevation used when scrolled under content.
  final double? scrolledUnderElevation;

  /// The color of the shadow beneath the app bar.
  final Color? shadowColor;

  /// The surface tint overlay color applied when elevated.
  final Color? surfaceTintColor;

  /// Whether the title should be centered by default.
  final bool? centerTitle;

  /// The horizontal spacing around the title.
  final double? titleSpacing;

  /// Default height for small / standard app bars (typically 64.0 dp).
  final double? toolbarHeight;

  /// Text style applied to the title label in small app bar variants.
  /// Defaults to [TextTheme.headlineSmall].
  final TextStyle? smallTitleTextStyle;

  final TextStyle? smallSupportingTextStyle;

  /// Text style applied to the title label in medium flexible app bar variants.
  /// Defaults to [TextTheme.headlineMedium].
  final TextStyle? mediumTitleTextStyle;

  final TextStyle? mediumSupportingTextStyle;

  /// Text style applied to the title label in large flexible app bar variants.
  /// Defaults to [TextTheme.displayMedium].
  final TextStyle? largeTitleTextStyle;

  /// Text style applied to the supporting text / subtitle in large app bar variants.
  /// Defaults to [TextTheme.bodyMedium].
  final TextStyle? largeSupportingTextStyle;

  /// Text style applied to the search bar placeholder text.
  final TextStyle? searchHintTextStyle;

  /// Background color of the search bar container.
  final Color? searchBackgroundColor;

  /// Corner radius of the search bar container.
  final BorderRadius? searchBorderRadius;

  /// Padding applied around the trailing actions list.
  final EdgeInsetsGeometry? actionsPadding;

  /// Icon theme applied to navigation / leading icons.
  final IconThemeData? iconTheme;

  /// Icon theme applied to trailing action icons.
  final IconThemeData? actionsIconTheme;

  /// Creates a standard [AppBarThemeDataConfig] configured with Mechanix design tokens.
  factory AppBarThemeDataConfig.standard(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return AppBarThemeDataConfig(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0.0,
      scrolledUnderElevation: 3.0,
      shadowColor: colorScheme.shadow,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleSpacing: 16.0,
      toolbarHeight: 64.0,
      smallTitleTextStyle: textTheme.headlineSmall?.copyWith(
        color: colorScheme.onSurface,
      ),
      smallSupportingTextStyle: textTheme.labelMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      mediumTitleTextStyle: textTheme.headlineMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      mediumSupportingTextStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      largeTitleTextStyle: textTheme.displayMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      largeSupportingTextStyle: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      searchHintTextStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      searchBackgroundColor: colorScheme.surfaceContainerHigh,
      searchBorderRadius: BorderRadius.circular(24.0),
      actionsPadding: const EdgeInsets.only(right: 8.0),
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24.0),
      actionsIconTheme: IconThemeData(color: colorScheme.onSurface, size: 24.0),
    );
  }

  @override
  AppBarThemeDataConfig copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    double? scrolledUnderElevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    bool? centerTitle,
    double? titleSpacing,
    double? toolbarHeight,
    TextStyle? smallTitleTextStyle,
    TextStyle? mediumTitleTextStyle,
    TextStyle? largeTitleTextStyle,
    TextStyle? largeSupportingTextStyle,
    TextStyle? searchHintTextStyle,
    Color? searchBackgroundColor,
    BorderRadius? searchBorderRadius,
    EdgeInsetsGeometry? actionsPadding,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
  }) {
    return AppBarThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      elevation: elevation ?? this.elevation,
      scrolledUnderElevation:
          scrolledUnderElevation ?? this.scrolledUnderElevation,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      centerTitle: centerTitle ?? this.centerTitle,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
      smallTitleTextStyle: smallTitleTextStyle ?? this.smallTitleTextStyle,
      mediumTitleTextStyle: mediumTitleTextStyle ?? this.mediumTitleTextStyle,
      largeTitleTextStyle: largeTitleTextStyle ?? this.largeTitleTextStyle,
      largeSupportingTextStyle:
          largeSupportingTextStyle ?? this.largeSupportingTextStyle,
      searchHintTextStyle: searchHintTextStyle ?? this.searchHintTextStyle,
      searchBackgroundColor:
          searchBackgroundColor ?? this.searchBackgroundColor,
      searchBorderRadius: searchBorderRadius ?? this.searchBorderRadius,
      actionsPadding: actionsPadding ?? this.actionsPadding,
      iconTheme: iconTheme ?? this.iconTheme,
      actionsIconTheme: actionsIconTheme ?? this.actionsIconTheme,
    );
  }

  /// Merges another [AppBarThemeDataConfig] into this configuration.
  AppBarThemeDataConfig merge(AppBarThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      elevation: other.elevation,
      scrolledUnderElevation: other.scrolledUnderElevation,
      shadowColor: other.shadowColor,
      surfaceTintColor: other.surfaceTintColor,
      centerTitle: other.centerTitle,
      titleSpacing: other.titleSpacing,
      toolbarHeight: other.toolbarHeight,
      smallTitleTextStyle: other.smallTitleTextStyle != null
          ? smallTitleTextStyle?.merge(other.smallTitleTextStyle) ??
                other.smallTitleTextStyle
          : smallTitleTextStyle,
      mediumTitleTextStyle: other.mediumTitleTextStyle != null
          ? mediumTitleTextStyle?.merge(other.mediumTitleTextStyle) ??
                other.mediumTitleTextStyle
          : mediumTitleTextStyle,
      largeTitleTextStyle: other.largeTitleTextStyle != null
          ? largeTitleTextStyle?.merge(other.largeTitleTextStyle) ??
                other.largeTitleTextStyle
          : largeTitleTextStyle,
      largeSupportingTextStyle: other.largeSupportingTextStyle != null
          ? largeSupportingTextStyle?.merge(other.largeSupportingTextStyle) ??
                other.largeSupportingTextStyle
          : largeSupportingTextStyle,
      searchHintTextStyle: other.searchHintTextStyle != null
          ? searchHintTextStyle?.merge(other.searchHintTextStyle) ??
                other.searchHintTextStyle
          : searchHintTextStyle,
      searchBackgroundColor: other.searchBackgroundColor,
      searchBorderRadius: other.searchBorderRadius,
      actionsPadding: other.actionsPadding,
      iconTheme: other.iconTheme,
      actionsIconTheme: other.actionsIconTheme,
    );
  }

  @override
  AppBarThemeDataConfig lerp(
    ThemeExtension<AppBarThemeDataConfig>? other,
    double t,
  ) {
    if (other is! AppBarThemeDataConfig) return this;
    return AppBarThemeDataConfig(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      elevation: _lerpDouble(elevation, other.elevation, t),
      scrolledUnderElevation: _lerpDouble(
        scrolledUnderElevation,
        other.scrolledUnderElevation,
        t,
      ),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      surfaceTintColor: Color.lerp(surfaceTintColor, other.surfaceTintColor, t),
      centerTitle: t < 0.5 ? centerTitle : other.centerTitle,
      titleSpacing: _lerpDouble(titleSpacing, other.titleSpacing, t),
      toolbarHeight: _lerpDouble(toolbarHeight, other.toolbarHeight, t),
      smallTitleTextStyle: TextStyle.lerp(
        smallTitleTextStyle,
        other.smallTitleTextStyle,
        t,
      ),
      mediumTitleTextStyle: TextStyle.lerp(
        mediumTitleTextStyle,
        other.mediumTitleTextStyle,
        t,
      ),
      largeTitleTextStyle: TextStyle.lerp(
        largeTitleTextStyle,
        other.largeTitleTextStyle,
        t,
      ),
      largeSupportingTextStyle: TextStyle.lerp(
        largeSupportingTextStyle,
        other.largeSupportingTextStyle,
        t,
      ),
      searchHintTextStyle: TextStyle.lerp(
        searchHintTextStyle,
        other.searchHintTextStyle,
        t,
      ),
      searchBackgroundColor: Color.lerp(
        searchBackgroundColor,
        other.searchBackgroundColor,
        t,
      ),
      searchBorderRadius: BorderRadius.lerp(
        searchBorderRadius,
        other.searchBorderRadius,
        t,
      ),
      actionsPadding: EdgeInsetsGeometry.lerp(
        actionsPadding,
        other.actionsPadding,
        t,
      ),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      actionsIconTheme: IconThemeData.lerp(
        actionsIconTheme,
        other.actionsIconTheme,
        t,
      ),
    );
  }

  static double? _lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('foregroundColor', foregroundColor));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(
      DoubleProperty('scrolledUnderElevation', scrolledUnderElevation),
    );
    properties.add(ColorProperty('shadowColor', shadowColor));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor));
    properties.add(DiagnosticsProperty<bool>('centerTitle', centerTitle));
    properties.add(DoubleProperty('titleSpacing', titleSpacing));
    properties.add(DoubleProperty('toolbarHeight', toolbarHeight));
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'smallTitleTextStyle',
        smallTitleTextStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'mediumTitleTextStyle',
        mediumTitleTextStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'largeTitleTextStyle',
        largeTitleTextStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'largeSupportingTextStyle',
        largeSupportingTextStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'searchHintTextStyle',
        searchHintTextStyle,
      ),
    );
    properties.add(
      ColorProperty('searchBackgroundColor', searchBackgroundColor),
    );
    properties.add(
      DiagnosticsProperty<BorderRadius>(
        'searchBorderRadius',
        searchBorderRadius,
      ),
    );
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>('actionsPadding', actionsPadding),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppBarThemeDataConfig &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.elevation == elevation &&
        other.scrolledUnderElevation == scrolledUnderElevation &&
        other.shadowColor == shadowColor &&
        other.surfaceTintColor == surfaceTintColor &&
        other.centerTitle == centerTitle &&
        other.titleSpacing == titleSpacing &&
        other.toolbarHeight == toolbarHeight &&
        other.smallTitleTextStyle == smallTitleTextStyle &&
        other.mediumTitleTextStyle == mediumTitleTextStyle &&
        other.largeTitleTextStyle == largeTitleTextStyle &&
        other.largeSupportingTextStyle == largeSupportingTextStyle &&
        other.searchHintTextStyle == searchHintTextStyle &&
        other.searchBackgroundColor == searchBackgroundColor &&
        other.searchBorderRadius == searchBorderRadius &&
        other.actionsPadding == actionsPadding &&
        other.iconTheme == iconTheme &&
        other.actionsIconTheme == actionsIconTheme;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    foregroundColor,
    elevation,
    scrolledUnderElevation,
    shadowColor,
    surfaceTintColor,
    centerTitle,
    titleSpacing,
    toolbarHeight,
    smallTitleTextStyle,
    mediumTitleTextStyle,
    largeTitleTextStyle,
    largeSupportingTextStyle,
    searchHintTextStyle,
    searchBackgroundColor,
    searchBorderRadius,
    actionsPadding,
    iconTheme,
    actionsIconTheme,
  );
}

/// An [InheritedTheme] that provides [AppBarThemeDataConfig] to descendant widgets.
class MechanixAppBarTheme extends InheritedTheme {
  const MechanixAppBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The [AppBarThemeDataConfig] provided to descendants.
  final AppBarThemeDataConfig data;

  /// Returns the nearest [AppBarThemeDataConfig] from the given [context].
  static AppBarThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixAppBarTheme>();
    if (theme != null) return theme.data;

    final ext = Theme.of(context).extension<AppBarThemeDataConfig>();
    if (ext != null) return ext;

    final themeData = Theme.of(context);
    return AppBarThemeDataConfig.standard(
      themeData.colorScheme,
      themeData.textTheme,
    );
  }

  /// Returns the nearest [AppBarThemeDataConfig] from the given [context], or null.
  static AppBarThemeDataConfig? maybeOf(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixAppBarTheme>();
    return theme?.data ?? Theme.of(context).extension<AppBarThemeDataConfig>();
  }

  @override
  bool updateShouldNotify(MechanixAppBarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixAppBarTheme(data: data, child: child);
  }
}
