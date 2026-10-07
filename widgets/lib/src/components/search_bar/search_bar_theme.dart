import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines theme and styling configuration for [MechanixSearchBar]
/// Can be provided globally via [ThemeData.extensions] or scoped in the widget
/// tree using [MechanixSearchBarTheme].
@immutable
class SearchBarThemeDataConfig extends ThemeExtension<SearchBarThemeDataConfig>
    with Diagnosticable {
  const SearchBarThemeDataConfig({
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.overlayColor,
    this.side,
    this.shape,
    this.padding,
    this.textStyle,
    this.hintStyle,
    this.constraints,
    this.leadingIconColor,
    this.trailingIconColor,
    this.cursorColor,
    this.viewBackgroundColor,
    this.viewElevation,
    this.viewShape,
    this.viewConstraints,
    this.dividerColor,
    this.headerHeight,
  });

  /// The background color across interaction states.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The elevation across interaction states.
  final WidgetStateProperty<double?>? elevation;

  /// The shadow color across interaction states.
  final WidgetStateProperty<Color?>? shadowColor;

  /// The surface tint color across interaction states.
  final WidgetStateProperty<Color?>? surfaceTintColor;

  /// The overlay (splash / hover / focus) color across interaction states.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The border side across interaction states.
  final WidgetStateProperty<BorderSide?>? side;

  /// The shape across interaction states.
  final WidgetStateProperty<OutlinedBorder?>? shape;

  /// The internal padding across interaction states.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  /// The text style of the search query across interaction states.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// The text style of the hint text across interaction states.
  final WidgetStateProperty<TextStyle?>? hintStyle;

  /// The layout constraints of the search bar.
  final BoxConstraints? constraints;

  /// Color applied to the leading icon across states.
  final WidgetStateProperty<Color?>? leadingIconColor;

  /// Color applied to trailing icons across states.
  final WidgetStateProperty<Color?>? trailingIconColor;

  /// The color of the text insertion cursor.
  final Color? cursorColor;

  /// The background color of the search view (docked & full-screen).
  final Color? viewBackgroundColor;

  /// The elevation of the search view surface.
  final double? viewElevation;

  /// The shape of the search view container.
  final OutlinedBorder? viewShape;

  /// Default box constraints applied to the search view in docked mode.
  final BoxConstraints? viewConstraints;

  /// Color of the divider separating the search header from suggestions.
  final Color? dividerColor;

  /// Height of the search header row in the search view (defaults to 56.0).
  final double? headerHeight;

  /// Creates a standard [SearchBarThemeDataConfig] configured with Mechanix design tokens.
  factory SearchBarThemeDataConfig.standard(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return SearchBarThemeDataConfig(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.04);
        }
        if (states.contains(WidgetState.hovered)) {
          return Color.alphaBlend(
            colorScheme.onSurface.withValues(alpha: 0.04),
            colorScheme.surfaceContainerHigh,
          );
        }
        return colorScheme.surfaceContainerHigh;
      }),
      elevation: const WidgetStatePropertyAll(0.0),
      shadowColor: WidgetStatePropertyAll(colorScheme.shadow),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      overlayColor: WidgetStateProperty.resolveWith((states) {
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
        return Colors.transparent;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: colorScheme.outline, width: 1.0);
        }
        return BorderSide.none;
      }),
      shape: const WidgetStatePropertyAll(StadiumBorder()),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16.0),
      ),
      textStyle: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.disabled)
            ? colorScheme.onSurface.withValues(alpha: 0.38)
            : colorScheme.onSurface;
        return textTheme.bodyLarge?.copyWith(color: color);
      }),
      hintStyle: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.disabled)
            ? colorScheme.onSurfaceVariant.withValues(alpha: 0.38)
            : colorScheme.onSurfaceVariant;
        return textTheme.bodyLarge?.copyWith(color: color);
      }),
      constraints: const BoxConstraints(
        minHeight: 56.0,
        maxHeight: 56.0,
        minWidth: 360.0,
        maxWidth: 720.0,
      ),
      leadingIconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurfaceVariant.withValues(alpha: 0.38);
        }
        return colorScheme.onSurfaceVariant;
      }),
      trailingIconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurfaceVariant.withValues(alpha: 0.38);
        }
        return colorScheme.onSurfaceVariant;
      }),
      cursorColor: colorScheme.primary,
      viewBackgroundColor: colorScheme.surfaceContainerHigh,
      viewElevation: 0.0,
      viewShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      viewConstraints: const BoxConstraints(
        minWidth: 360.0,
        maxWidth: 720.0,
        minHeight: 240.0,
        maxHeight: 440.0,
      ),
      dividerColor: colorScheme.outlineVariant,
      headerHeight: 56.0,
    );
  }

  @override
  SearchBarThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<double?>? elevation,
    WidgetStateProperty<Color?>? shadowColor,
    WidgetStateProperty<Color?>? surfaceTintColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<BorderSide?>? side,
    WidgetStateProperty<OutlinedBorder?>? shape,
    WidgetStateProperty<EdgeInsetsGeometry?>? padding,
    WidgetStateProperty<TextStyle?>? textStyle,
    WidgetStateProperty<TextStyle?>? hintStyle,
    BoxConstraints? constraints,
    WidgetStateProperty<Color?>? leadingIconColor,
    WidgetStateProperty<Color?>? trailingIconColor,
    Color? cursorColor,
    Color? viewBackgroundColor,
    double? viewElevation,
    OutlinedBorder? viewShape,
    BoxConstraints? viewConstraints,
    Color? dividerColor,
    double? headerHeight,
  }) {
    return SearchBarThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      overlayColor: overlayColor ?? this.overlayColor,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      constraints: constraints ?? this.constraints,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      cursorColor: cursorColor ?? this.cursorColor,
      viewBackgroundColor: viewBackgroundColor ?? this.viewBackgroundColor,
      viewElevation: viewElevation ?? this.viewElevation,
      viewShape: viewShape ?? this.viewShape,
      viewConstraints: viewConstraints ?? this.viewConstraints,
      dividerColor: dividerColor ?? this.dividerColor,
      headerHeight: headerHeight ?? this.headerHeight,
    );
  }

  SearchBarThemeDataConfig merge(SearchBarThemeDataConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      elevation: other.elevation,
      shadowColor: other.shadowColor,
      surfaceTintColor: other.surfaceTintColor,
      overlayColor: other.overlayColor,
      side: other.side,
      shape: other.shape,
      padding: other.padding,
      textStyle: other.textStyle,
      hintStyle: other.hintStyle,
      constraints: other.constraints,
      leadingIconColor: other.leadingIconColor,
      trailingIconColor: other.trailingIconColor,
      cursorColor: other.cursorColor,
      viewBackgroundColor: other.viewBackgroundColor,
      viewElevation: other.viewElevation,
      viewShape: other.viewShape,
      viewConstraints: other.viewConstraints,
      dividerColor: other.dividerColor,
      headerHeight: other.headerHeight,
    );
  }

  @override
  SearchBarThemeDataConfig lerp(
    ThemeExtension<SearchBarThemeDataConfig>? other,
    double t,
  ) {
    if (other is! SearchBarThemeDataConfig) return this;
    return SearchBarThemeDataConfig(
      backgroundColor: WidgetStateProperty.lerp<Color?>(
        backgroundColor,
        other.backgroundColor,
        t,
        Color.lerp,
      ),
      elevation: WidgetStateProperty.lerp<double?>(
        elevation,
        other.elevation,
        t,
        lerpDouble,
      ),
      shadowColor: WidgetStateProperty.lerp<Color?>(
        shadowColor,
        other.shadowColor,
        t,
        Color.lerp,
      ),
      surfaceTintColor: WidgetStateProperty.lerp<Color?>(
        surfaceTintColor,
        other.surfaceTintColor,
        t,
        Color.lerp,
      ),
      overlayColor: WidgetStateProperty.lerp<Color?>(
        overlayColor,
        other.overlayColor,
        t,
        Color.lerp,
      ),
      side: WidgetStateProperty.lerp<BorderSide?>(
        side,
        other.side,
        t,
        (a, b, t) =>
            BorderSide.lerp(a ?? BorderSide.none, b ?? BorderSide.none, t),
      ),
      shape: WidgetStateProperty.lerp<OutlinedBorder?>(
        shape,
        other.shape,
        t,
        (a, b, t) => OutlinedBorder.lerp(a, b, t),
      ),
      padding: WidgetStateProperty.lerp<EdgeInsetsGeometry?>(
        padding,
        other.padding,
        t,
        EdgeInsetsGeometry.lerp,
      ),
      textStyle: WidgetStateProperty.lerp<TextStyle?>(
        textStyle,
        other.textStyle,
        t,
        TextStyle.lerp,
      ),
      hintStyle: WidgetStateProperty.lerp<TextStyle?>(
        hintStyle,
        other.hintStyle,
        t,
        TextStyle.lerp,
      ),
      constraints: BoxConstraints.lerp(constraints, other.constraints, t),
      leadingIconColor: WidgetStateProperty.lerp<Color?>(
        leadingIconColor,
        other.leadingIconColor,
        t,
        Color.lerp,
      ),
      trailingIconColor: WidgetStateProperty.lerp<Color?>(
        trailingIconColor,
        other.trailingIconColor,
        t,
        Color.lerp,
      ),
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t),
      viewBackgroundColor: Color.lerp(
        viewBackgroundColor,
        other.viewBackgroundColor,
        t,
      ),
      viewElevation: lerpDouble(viewElevation, other.viewElevation, t),
      viewShape: OutlinedBorder.lerp(viewShape, other.viewShape, t),
      viewConstraints: BoxConstraints.lerp(
        viewConstraints,
        other.viewConstraints,
        t,
      ),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('elevation', elevation));
    properties.add(DiagnosticsProperty('shadowColor', shadowColor));
    properties.add(DiagnosticsProperty('surfaceTintColor', surfaceTintColor));
    properties.add(DiagnosticsProperty('overlayColor', overlayColor));
    properties.add(DiagnosticsProperty('side', side));
    properties.add(DiagnosticsProperty('shape', shape));
    properties.add(DiagnosticsProperty('padding', padding));
    properties.add(DiagnosticsProperty('textStyle', textStyle));
    properties.add(DiagnosticsProperty('hintStyle', hintStyle));
    properties.add(DiagnosticsProperty('constraints', constraints));
    properties.add(DiagnosticsProperty('leadingIconColor', leadingIconColor));
    properties.add(DiagnosticsProperty('trailingIconColor', trailingIconColor));
    properties.add(ColorProperty('cursorColor', cursorColor));
    properties.add(ColorProperty('viewBackgroundColor', viewBackgroundColor));
    properties.add(DoubleProperty('viewElevation', viewElevation));
    properties.add(DiagnosticsProperty('viewShape', viewShape));
    properties.add(DiagnosticsProperty('viewConstraints', viewConstraints));
    properties.add(ColorProperty('dividerColor', dividerColor));
    properties.add(DoubleProperty('headerHeight', headerHeight));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchBarThemeDataConfig &&
        backgroundColor == other.backgroundColor &&
        elevation == other.elevation &&
        shadowColor == other.shadowColor &&
        surfaceTintColor == other.surfaceTintColor &&
        overlayColor == other.overlayColor &&
        side == other.side &&
        shape == other.shape &&
        padding == other.padding &&
        textStyle == other.textStyle &&
        hintStyle == other.hintStyle &&
        constraints == other.constraints &&
        leadingIconColor == other.leadingIconColor &&
        trailingIconColor == other.trailingIconColor &&
        cursorColor == other.cursorColor &&
        viewBackgroundColor == other.viewBackgroundColor &&
        viewElevation == other.viewElevation &&
        viewShape == other.viewShape &&
        viewConstraints == other.viewConstraints &&
        dividerColor == other.dividerColor &&
        headerHeight == other.headerHeight;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      elevation,
      shadowColor,
      surfaceTintColor,
      overlayColor,
      side,
      shape,
      padding,
      textStyle,
      hintStyle,
      constraints,
      leadingIconColor,
      trailingIconColor,
      cursorColor,
      viewBackgroundColor,
      viewElevation,
      viewShape,
      viewConstraints,
      dividerColor,
      headerHeight,
    ]);
  }
}

/// An [InheritedTheme] that provides [SearchBarThemeDataConfig] to descendant widgets.
class MechanixSearchBarTheme extends InheritedTheme {
  const MechanixSearchBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The [SearchBarThemeDataConfig] provided to descendants.
  final SearchBarThemeDataConfig data;

  /// Returns the nearest [SearchBarThemeDataConfig] from the given [context].
  static SearchBarThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixSearchBarTheme>();
    if (theme != null) return theme.data;

    final ext = Theme.of(context).extension<SearchBarThemeDataConfig>();
    if (ext != null) return ext;

    final themeData = Theme.of(context);
    return SearchBarThemeDataConfig.standard(
      themeData.colorScheme,
      themeData.textTheme,
    );
  }

  /// Returns the nearest [SearchBarThemeDataConfig] from the given [context], or null.
  static SearchBarThemeDataConfig? maybeOf(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixSearchBarTheme>();
    return theme?.data ??
        Theme.of(context).extension<SearchBarThemeDataConfig>();
  }

  @override
  bool updateShouldNotify(MechanixSearchBarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixSearchBarTheme(data: data, child: child);
  }
}
