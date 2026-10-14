import 'dart:async';

import 'package:flutter/material.dart';

import 'search_bar_theme.dart';

export 'search_bar_theme.dart';

/// A customizable, accessible Search Bar component conforming to the
/// Mechanix design system specifications, wrapping Flutter's [SearchBar].
///
/// Features a pill-shaped container (56 dp height, 28 dp border radius),
/// leading search icon, placeholder text, trailing action icons (e.g. mic),
/// optional trailing avatar, and automatic debounced search triggering after
/// reaching [minSearchChars] (defaults to 3 characters).
class MechanixSearchBar extends StatefulWidget {
  const MechanixSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Hinted search text',
    this.leading = const Icon(Icons.search, size: 24.0),
    this.trailing,
    this.avatar,
    this.onChanged,
    this.onSubmitted,
    this.onAutoSearch,
    this.minSearchChars = 3,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.onTap,
    this.onTapOutside,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
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
    this.keyboardType,
    this.textInputAction,
    this.theme,
    this.semanticLabel,
  });

  /// Controls the text being edited in the search bar.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this search bar.
  final FocusNode? focusNode;

  /// Text displayed when the search bar is empty.
  final String? hintText;

  /// Widget placed before the text input (typically [Icons.search]).
  final Widget? leading;

  /// Widgets placed after the text input (e.g., mic icon, clear button).
  final Iterable<Widget>? trailing;

  /// Optional avatar widget displayed on the far right (e.g., [CircleAvatar]).
  final Widget? avatar;

  /// Called immediately when the search query changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user indicates that they are done editing the search query.
  final ValueChanged<String>? onSubmitted;

  /// Automatically called after [debounceDuration] when the trimmed query reaches
  /// at least [minSearchChars] characters (defaults to 3).
  final ValueChanged<String>? onAutoSearch;

  /// Minimum number of characters typed before [onAutoSearch] triggers (defaults to 3).
  final int minSearchChars;

  /// Debounce interval before executing [onAutoSearch] (defaults to 300ms).
  final Duration debounceDuration;

  /// Called when the search bar container is tapped.
  final VoidCallback? onTap;

  /// Called when a tap event occurs outside of the search bar.
  final TapRegionCallback? onTapOutside;

  /// If false, the search bar is visually disabled and does not respond to input.
  final bool enabled;

  /// Whether the text can be edited directly.
  final bool readOnly;

  /// Whether this search bar should focus itself on build.
  final bool autofocus;

  /// Background color of the search bar container across widget states.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The elevation z-coordinate across widget states.
  final WidgetStateProperty<double?>? elevation;

  /// The shadow color beneath the search bar across widget states.
  final WidgetStateProperty<Color?>? shadowColor;

  /// The surface tint color across widget states.
  final WidgetStateProperty<Color?>? surfaceTintColor;

  /// Highlight/overlay color across widget states.
  final WidgetStateProperty<Color?>? overlayColor;

  /// Border outline side across widget states.
  final WidgetStateProperty<BorderSide?>? side;

  /// Border shape across widget states (defaults to stadium / pill border).
  final WidgetStateProperty<OutlinedBorder?>? shape;

  /// Padding applied within the search bar.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  /// Style applied to the query text across widget states.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// Style applied to the hint placeholder text across widget states.
  final WidgetStateProperty<TextStyle?>? hintStyle;

  /// Optional box constraints overriding standard 56dp height and 360-720dp width.
  final BoxConstraints? constraints;

  /// The type of keyboard to use.
  final TextInputType? keyboardType;

  /// The action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional theme configuration overrides.
  final SearchBarThemeDataConfig? theme;

  /// Optional semantic label for accessibility.
  final String? semanticLabel;

  @override
  State<MechanixSearchBar> createState() => _MechanixSearchBarState();
}

class _MechanixSearchBarState extends State<MechanixSearchBar> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleTextChanged(String value) {
    widget.onChanged?.call(value);

    _debounceTimer?.cancel();
    final trimmed = value.trim();
    if (trimmed.length >= widget.minSearchChars) {
      _debounceTimer = Timer(widget.debounceDuration, () {
        if (mounted) {
          widget.onAutoSearch?.call(trimmed);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;
    final componentTheme = MechanixSearchBarTheme.of(context)
        .merge(widget.theme);

    // Resolve leading icon with theme color
    Widget? effectiveLeading = widget.leading;
    if (effectiveLeading != null && componentTheme.leadingIconColor != null) {
      effectiveLeading = IconTheme.merge(
        data: IconThemeData(
          color: componentTheme.leadingIconColor?.resolve({}),
          size: 24.0,
        ),
        child: effectiveLeading,
      );
    }

    // Combine trailing widgets and avatar
    final trailingItems = <Widget>[
      if (widget.trailing != null) ...widget.trailing!,
      if (widget.avatar != null) widget.avatar!,
    ];

    Iterable<Widget>? effectiveTrailing;
    if (trailingItems.isNotEmpty) {
      if (componentTheme.trailingIconColor != null) {
        effectiveTrailing = trailingItems.map(
          (item) => IconTheme.merge(
            data: IconThemeData(
              color: componentTheme.trailingIconColor?.resolve({}),
              size: 24.0,
            ),
            child: item,
          ),
        );
      } else {
        effectiveTrailing = trailingItems;
      }
    }

    final effectiveBackgroundColor =
        widget.backgroundColor ??
        componentTheme.backgroundColor ??
        WidgetStateProperty.resolveWith((states) {
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
        });

    final effectiveElevation =
        widget.elevation ??
        componentTheme.elevation ??
        const WidgetStatePropertyAll(0.0);

    final effectiveShadowColor =
        widget.shadowColor ??
        componentTheme.shadowColor ??
        WidgetStatePropertyAll(colorScheme.shadow);

    final effectiveSurfaceTintColor =
        widget.surfaceTintColor ??
        componentTheme.surfaceTintColor ??
        const WidgetStatePropertyAll(Colors.transparent);

    final effectiveOverlayColor =
        widget.overlayColor ??
        componentTheme.overlayColor ??
        WidgetStateProperty.resolveWith((states) {
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
        });

    final effectiveSide =
        widget.side ??
        componentTheme.side ??
        WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: colorScheme.outline, width: 1.0);
          }
          return BorderSide.none;
        });

    final effectiveShape =
        widget.shape ??
        componentTheme.shape ??
        const WidgetStatePropertyAll(StadiumBorder());

    final effectivePadding =
        widget.padding ??
        componentTheme.padding ??
        const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.0));

    final effectiveTextStyle =
        widget.textStyle ??
        componentTheme.textStyle ??
        WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.disabled)
              ? colorScheme.onSurface.withValues(alpha: 0.38)
              : colorScheme.onSurface;
          return textTheme.bodyLarge?.copyWith(color: color);
        });

    final effectiveHintStyle =
        widget.hintStyle ??
        componentTheme.hintStyle ??
        WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.disabled)
              ? colorScheme.onSurfaceVariant.withValues(alpha: 0.38)
              : colorScheme.onSurfaceVariant;
          return textTheme.bodyLarge?.copyWith(color: color);
        });

    final effectiveConstraints =
        widget.constraints ??
        componentTheme.constraints ??
        const BoxConstraints(
          minHeight: 56.0,
          maxHeight: 56.0,
          minWidth: 360.0,
          maxWidth: 720.0,
        );

    final searchBarWidget = SearchBar(
      controller: widget.controller,
      focusNode: widget.focusNode,
      hintText: widget.hintText,
      leading: effectiveLeading,
      trailing: effectiveTrailing,
      onChanged: _handleTextChanged,
      onSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autoFocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      backgroundColor: effectiveBackgroundColor,
      elevation: effectiveElevation,
      shadowColor: effectiveShadowColor,
      surfaceTintColor: effectiveSurfaceTintColor,
      overlayColor: effectiveOverlayColor,
      side: effectiveSide,
      shape: effectiveShape,
      padding: effectivePadding,
      textStyle: effectiveTextStyle,
      hintStyle: effectiveHintStyle,
      constraints: effectiveConstraints,
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        container: true,
        label: widget.semanticLabel,
        child: searchBarWidget,
      );
    }

    return searchBarWidget;
  }
}
