import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines theme and styling properties for [MechanixNavigationBar] and
/// [MechanixNavigationDestination].
///
/// Can be provided globally via [ThemeData.extensions] or scoped in the widget
/// tree using [MechanixNavigationBarTheme].
@immutable
class NavigationBarThemeDataConfig
    extends ThemeExtension<NavigationBarThemeDataConfig>
    with Diagnosticable {
  const NavigationBarThemeDataConfig({
    this.height,
    this.verticalPadding,
    this.itemWidth,
    this.itemHeight,
    this.iconSize,
    this.itemGap,
    this.destinationGap,
    this.backgroundColor,
    this.itemBackgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.labelTextStyle,
    this.labelColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedBackgroundColor,
    this.selectedBorderColor,
    this.hoveredBackgroundColor,
    this.focusedBackgroundColor,
    this.pressedBackgroundColor,
    this.selectedBorderWidth,
    this.itemBorderRadius,
    this.applyToWholeItem,
    this.showDividers,
    this.dividerColor,
  });

  /// Total height of the navigation bar. Defaults to 80.0 dp.
  final double? height;

  /// Vertical padding applied to the navigation destination items. Defaults to 12.0 dp.
  final double? verticalPadding;

  /// Width of each destination item container / pill. Defaults to 56.0 dp.
  final double? itemWidth;

  /// Height of each destination item container / pill. Defaults to 32.0 dp.
  final double? itemHeight;

  /// Size of destination icons. Defaults to 24.0 dp.
  final double? iconSize;

  /// Vertical gap between destination icon and label. Defaults to 4.0 dp.
  final double? itemGap;

  /// Horizontal gap between adjacent navigation destination items. Defaults to 4.0 dp.
  final double? destinationGap;

  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Background color of enabled navigation destination items.
  /// Defaults to [ColorScheme.surfaceContainerLow].
  final Color? itemBackgroundColor;

  /// Elevation z-coordinate of the navigation bar.
  final double? elevation;

  /// Shadow color of the navigation bar when elevated.
  final Color? shadowColor;

  /// Surface tint color of the navigation bar.
  final Color? surfaceTintColor;

  /// Text style applied to destination labels. Defaults to [TextTheme.labelLarge].
  final TextStyle? labelTextStyle;

  /// Color applied to destination labels. Defaults to [ColorScheme.onSecondaryContainer].
  final Color? labelColor;

  /// Icon color for the selected destination. Defaults to [ColorScheme.onSurface].
  final Color? selectedItemColor;

  /// Icon color for unselected destinations. Defaults to [ColorScheme.onSurfaceVariant].
  final Color? unselectedItemColor;

  /// Background color applied when selected.
  /// Defaults to `onSurface` with 10% opacity (`rgba(245, 245, 245, 0.1)`).
  final Color? selectedBackgroundColor;

  /// Top border color applied when selected.
  /// Defaults to [ColorScheme.onSecondaryFixed] (`rgba(141, 141, 145, 1)`).
  final Color? selectedBorderColor;

  /// Background color applied when hovered.
  /// Defaults to `onSurface` with 8% opacity (`rgba(245, 245, 245, 0.08)`).
  final Color? hoveredBackgroundColor;

  /// Background color applied when focused.
  /// Defaults to [ColorScheme.surfaceContainerLow] (`rgba(20, 20, 21, 1)`).
  final Color? focusedBackgroundColor;

  /// Background color applied when pressed.
  /// Defaults to [ColorScheme.surfaceContainerLow] (`rgba(20, 20, 21, 1)`).
  final Color? pressedBackgroundColor;

  /// Width of the top border on selected items. Defaults to 1.0 dp.
  final double? selectedBorderWidth;

  /// Border radius of the item container. Defaults to null.
  final BorderRadius? itemBorderRadius;

  /// Whether hover, focus, pressed, and selected background colors and the top
  /// border apply to the entire nav item (including icon and label).
  ///
  /// Defaults to `true`.
  final bool? applyToWholeItem;

  /// Whether 1px vertical dividers are rendered between navigation destination items
  /// when [destinationGap] is 0.
  ///
  /// Defaults to `true`.
  final bool? showDividers;

  /// Color of the vertical dividers between destination items.
  final Color? dividerColor;

  /// Creates a standard [NavigationBarThemeDataConfig] configured with Mechanix design tokens.
  factory NavigationBarThemeDataConfig.standard(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return NavigationBarThemeDataConfig(
      height: 80.0,
      verticalPadding: 12.0,
      itemWidth: 56.0,
      itemHeight: 32.0,
      iconSize: 24.0,
      itemGap: 4.0,
      destinationGap: 4.0,
      backgroundColor: colorScheme.surfaceDim,
      itemBackgroundColor: colorScheme.surfaceContainerLow,
      elevation: 0.0,
      shadowColor: colorScheme.shadow,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSecondaryContainer,
      ),
      labelColor: colorScheme.onSecondaryContainer,
      selectedItemColor: colorScheme.onSurface,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      selectedBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.10),
      selectedBorderColor: colorScheme.onSecondaryFixed,
      hoveredBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.08),
      focusedBackgroundColor: colorScheme.surfaceContainerLow,
      pressedBackgroundColor: colorScheme.surfaceContainerLow,
      selectedBorderWidth: 1.0,
      applyToWholeItem: true,
      showDividers: true,
      dividerColor: colorScheme.outlineVariant.withValues(alpha: 0.2),
    );
  }

  @override
  NavigationBarThemeDataConfig copyWith({
    double? height,
    double? verticalPadding,
    double? itemWidth,
    double? itemHeight,
    double? iconSize,
    double? itemGap,
    double? destinationGap,
    Color? backgroundColor,
    Color? itemBackgroundColor,
    double? elevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    TextStyle? labelTextStyle,
    Color? labelColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    Color? selectedBackgroundColor,
    Color? selectedBorderColor,
    Color? hoveredBackgroundColor,
    Color? focusedBackgroundColor,
    Color? pressedBackgroundColor,
    double? selectedBorderWidth,
    BorderRadius? itemBorderRadius,
    bool? applyToWholeItem,
    bool? showDividers,
    Color? dividerColor,
  }) {
    return NavigationBarThemeDataConfig(
      height: height ?? this.height,
      verticalPadding: verticalPadding ?? this.verticalPadding,
      itemWidth: itemWidth ?? this.itemWidth,
      itemHeight: itemHeight ?? this.itemHeight,
      iconSize: iconSize ?? this.iconSize,
      itemGap: itemGap ?? this.itemGap,
      destinationGap: destinationGap ?? this.destinationGap,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelColor: labelColor ?? this.labelColor,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      hoveredBackgroundColor:
          hoveredBackgroundColor ?? this.hoveredBackgroundColor,
      focusedBackgroundColor:
          focusedBackgroundColor ?? this.focusedBackgroundColor,
      pressedBackgroundColor:
          pressedBackgroundColor ?? this.pressedBackgroundColor,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      applyToWholeItem: applyToWholeItem ?? this.applyToWholeItem,
      showDividers: showDividers ?? this.showDividers,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  /// Merges another [NavigationBarThemeDataConfig] into this configuration.
  NavigationBarThemeDataConfig merge(NavigationBarThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      verticalPadding: other.verticalPadding,
      itemWidth: other.itemWidth,
      itemHeight: other.itemHeight,
      iconSize: other.iconSize,
      itemGap: other.itemGap,
      destinationGap: other.destinationGap,
      backgroundColor: other.backgroundColor,
      itemBackgroundColor: other.itemBackgroundColor,
      elevation: other.elevation,
      shadowColor: other.shadowColor,
      surfaceTintColor: other.surfaceTintColor,
      labelTextStyle: other.labelTextStyle != null
          ? labelTextStyle?.merge(other.labelTextStyle) ?? other.labelTextStyle
          : labelTextStyle,
      labelColor: other.labelColor,
      selectedItemColor: other.selectedItemColor,
      unselectedItemColor: other.unselectedItemColor,
      selectedBackgroundColor: other.selectedBackgroundColor,
      selectedBorderColor: other.selectedBorderColor,
      hoveredBackgroundColor: other.hoveredBackgroundColor,
      focusedBackgroundColor: other.focusedBackgroundColor,
      pressedBackgroundColor: other.pressedBackgroundColor,
      selectedBorderWidth: other.selectedBorderWidth,
      itemBorderRadius: other.itemBorderRadius,
      applyToWholeItem: other.applyToWholeItem,
      showDividers: other.showDividers,
      dividerColor: other.dividerColor,
    );
  }

  @override
  NavigationBarThemeDataConfig lerp(
    ThemeExtension<NavigationBarThemeDataConfig>? other,
    double t,
  ) {
    if (other is! NavigationBarThemeDataConfig) return this;
    return NavigationBarThemeDataConfig(
      height: _lerpDouble(height, other.height, t),
      verticalPadding: _lerpDouble(verticalPadding, other.verticalPadding, t),
      itemWidth: _lerpDouble(itemWidth, other.itemWidth, t),
      itemHeight: _lerpDouble(itemHeight, other.itemHeight, t),
      iconSize: _lerpDouble(iconSize, other.iconSize, t),
      itemGap: _lerpDouble(itemGap, other.itemGap, t),
      destinationGap: _lerpDouble(destinationGap, other.destinationGap, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      itemBackgroundColor: Color.lerp(
        itemBackgroundColor,
        other.itemBackgroundColor,
        t,
      ),
      elevation: _lerpDouble(elevation, other.elevation, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      surfaceTintColor: Color.lerp(surfaceTintColor, other.surfaceTintColor, t),
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      labelColor: Color.lerp(labelColor, other.labelColor, t),
      selectedItemColor: Color.lerp(
        selectedItemColor,
        other.selectedItemColor,
        t,
      ),
      unselectedItemColor: Color.lerp(
        unselectedItemColor,
        other.unselectedItemColor,
        t,
      ),
      selectedBackgroundColor: Color.lerp(
        selectedBackgroundColor,
        other.selectedBackgroundColor,
        t,
      ),
      selectedBorderColor: Color.lerp(
        selectedBorderColor,
        other.selectedBorderColor,
        t,
      ),
      hoveredBackgroundColor: Color.lerp(
        hoveredBackgroundColor,
        other.hoveredBackgroundColor,
        t,
      ),
      focusedBackgroundColor: Color.lerp(
        focusedBackgroundColor,
        other.focusedBackgroundColor,
        t,
      ),
      pressedBackgroundColor: Color.lerp(
        pressedBackgroundColor,
        other.pressedBackgroundColor,
        t,
      ),
      selectedBorderWidth: _lerpDouble(
        selectedBorderWidth,
        other.selectedBorderWidth,
        t,
      ),
      itemBorderRadius: BorderRadius.lerp(
        itemBorderRadius,
        other.itemBorderRadius,
        t,
      ),
      applyToWholeItem: t < 0.5 ? applyToWholeItem : other.applyToWholeItem,
      showDividers: t < 0.5 ? showDividers : other.showDividers,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
    );
  }

  static double? _lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('verticalPadding', verticalPadding));
    properties.add(DoubleProperty('itemWidth', itemWidth));
    properties.add(DoubleProperty('itemHeight', itemHeight));
    properties.add(DoubleProperty('iconSize', iconSize));
    properties.add(DoubleProperty('itemGap', itemGap));
    properties.add(DoubleProperty('destinationGap', destinationGap));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('itemBackgroundColor', itemBackgroundColor));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('shadowColor', shadowColor));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor));
    properties.add(
      DiagnosticsProperty<TextStyle>('labelTextStyle', labelTextStyle),
    );
    properties.add(ColorProperty('labelColor', labelColor));
    properties.add(ColorProperty('selectedItemColor', selectedItemColor));
    properties.add(ColorProperty('unselectedItemColor', unselectedItemColor));
    properties.add(
      ColorProperty('selectedBackgroundColor', selectedBackgroundColor),
    );
    properties.add(ColorProperty('selectedBorderColor', selectedBorderColor));
    properties.add(
      ColorProperty('hoveredBackgroundColor', hoveredBackgroundColor),
    );
    properties.add(
      ColorProperty('focusedBackgroundColor', focusedBackgroundColor),
    );
    properties.add(
      ColorProperty('pressedBackgroundColor', pressedBackgroundColor),
    );
    properties.add(DoubleProperty('selectedBorderWidth', selectedBorderWidth));
    properties.add(
      DiagnosticsProperty<BorderRadius>('itemBorderRadius', itemBorderRadius),
    );
    properties.add(
      DiagnosticsProperty<bool>('applyToWholeItem', applyToWholeItem),
    );
    properties.add(DiagnosticsProperty<bool>('showDividers', showDividers));
    properties.add(ColorProperty('dividerColor', dividerColor));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavigationBarThemeDataConfig &&
        other.height == height &&
        other.verticalPadding == verticalPadding &&
        other.itemWidth == itemWidth &&
        other.itemHeight == itemHeight &&
        other.iconSize == iconSize &&
        other.itemGap == itemGap &&
        other.destinationGap == destinationGap &&
        other.backgroundColor == backgroundColor &&
        other.itemBackgroundColor == itemBackgroundColor &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor &&
        other.surfaceTintColor == surfaceTintColor &&
        other.labelTextStyle == labelTextStyle &&
        other.labelColor == labelColor &&
        other.selectedItemColor == selectedItemColor &&
        other.unselectedItemColor == unselectedItemColor &&
        other.selectedBackgroundColor == selectedBackgroundColor &&
        other.selectedBorderColor == selectedBorderColor &&
        other.hoveredBackgroundColor == hoveredBackgroundColor &&
        other.focusedBackgroundColor == focusedBackgroundColor &&
        other.pressedBackgroundColor == pressedBackgroundColor &&
        other.selectedBorderWidth == selectedBorderWidth &&
        other.itemBorderRadius == itemBorderRadius &&
        other.applyToWholeItem == applyToWholeItem &&
        other.showDividers == showDividers &&
        other.dividerColor == dividerColor;
  }

  @override
  int get hashCode => Object.hashAll([
    height,
    verticalPadding,
    itemWidth,
    itemHeight,
    iconSize,
    itemGap,
    destinationGap,
    backgroundColor,
    itemBackgroundColor,
    elevation,
    shadowColor,
    surfaceTintColor,
    labelTextStyle,
    labelColor,
    selectedItemColor,
    unselectedItemColor,
    selectedBackgroundColor,
    selectedBorderColor,
    hoveredBackgroundColor,
    focusedBackgroundColor,
    pressedBackgroundColor,
    selectedBorderWidth,
    itemBorderRadius,
    applyToWholeItem,
    showDividers,
    dividerColor,
  ]);
}

/// An [InheritedTheme] that provides [NavigationBarThemeDataConfig] to descendant widgets.
class MechanixNavigationBarTheme extends InheritedTheme {
  const MechanixNavigationBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The [NavigationBarThemeDataConfig] provided to descendants.
  final NavigationBarThemeDataConfig data;

  /// Returns the nearest [NavigationBarThemeDataConfig] from the given [context].
  static NavigationBarThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixNavigationBarTheme>();
    if (theme != null) return theme.data;

    final ext = Theme.of(context).extension<NavigationBarThemeDataConfig>();
    if (ext != null) return ext;

    final themeData = Theme.of(context);
    return NavigationBarThemeDataConfig.standard(
      themeData.colorScheme,
      themeData.textTheme,
    );
  }

  /// Returns the nearest [NavigationBarThemeDataConfig] from the given [context], or null.
  static NavigationBarThemeDataConfig? maybeOf(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixNavigationBarTheme>();
    return theme?.data ??
        Theme.of(context).extension<NavigationBarThemeDataConfig>();
  }

  @override
  bool updateShouldNotify(MechanixNavigationBarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixNavigationBarTheme(data: data, child: child);
  }
}
