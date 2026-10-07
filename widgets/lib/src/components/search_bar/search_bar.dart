import 'dart:async';

import 'package:flutter/material.dart';

import 'search_bar_theme.dart';

export 'search_bar_theme.dart';

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
  TextEditingController? _internalController;
  FocusNode? _internalFocusNode;
  Timer? _debounceTimer;

  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_internalController ??= TextEditingController());

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ??
      (_internalFocusNode ??= FocusNode(debugLabel: 'MechanixSearchBar'));

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant MechanixSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)?.removeListener(
        _handleFocusChange,
      );
      if (oldWidget.focusNode == null && widget.focusNode != null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      }
      _effectiveFocusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    (widget.focusNode ?? _internalFocusNode)?.removeListener(
      _handleFocusChange,
    );
    _internalFocusNode?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_isFocused != _effectiveFocusNode.hasFocus) {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    }
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

  Set<WidgetState> get _states => <WidgetState>{
    if (!widget.enabled) WidgetState.disabled,
    if (widget.enabled && _isHovered) WidgetState.hovered,
    if (widget.enabled && _isFocused) WidgetState.focused,
    if (widget.enabled && _isPressed) WidgetState.pressed,
  };

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;
    final componentTheme = MechanixSearchBarTheme.of(context)
        .merge(widget.theme);

    final states = _states;

    // Resolve styling properties
    final resolvedBg =
        widget.backgroundColor?.resolve(states) ??
        componentTheme.backgroundColor?.resolve(states) ??
        colorScheme.surfaceContainerHigh;

    final resolvedElevation =
        widget.elevation?.resolve(states) ??
        componentTheme.elevation?.resolve(states) ??
        0.0;

    final resolvedShadowColor =
        widget.shadowColor?.resolve(states) ??
        componentTheme.shadowColor?.resolve(states) ??
        colorScheme.shadow;

    final resolvedSurfaceTintColor =
        widget.surfaceTintColor?.resolve(states) ??
        componentTheme.surfaceTintColor?.resolve(states) ??
        Colors.transparent;

    final resolvedOverlayColor =
        widget.overlayColor?.resolve(states) ??
        componentTheme.overlayColor?.resolve(states) ??
        Colors.transparent;

    final resolvedSide =
        widget.side?.resolve(states) ??
        componentTheme.side?.resolve(states) ??
        (_isFocused
            ? BorderSide(color: colorScheme.outline, width: 1.0)
            : BorderSide.none);

    final baseShape =
        widget.shape?.resolve(states) ?? componentTheme.shape?.resolve(states);

    final OutlinedBorder resolvedShape = (baseShape != null)
        ? baseShape.copyWith(side: resolvedSide)
        : StadiumBorder(side: resolvedSide);

    final resolvedPadding =
        widget.padding?.resolve(states) ??
        componentTheme.padding?.resolve(states) ??
        const EdgeInsets.symmetric(horizontal: 16.0);

    final resolvedTextStyle =
        widget.textStyle?.resolve(states) ??
        componentTheme.textStyle?.resolve(states) ??
        textTheme.bodyLarge?.copyWith(
          color: widget.enabled
              ? colorScheme.onSurface
              : colorScheme.onSurface.withValues(alpha: 0.38),
        );

    final resolvedHintStyle =
        widget.hintStyle?.resolve(states) ??
        componentTheme.hintStyle?.resolve(states) ??
        textTheme.bodyLarge?.copyWith(
          color: widget.enabled
              ? colorScheme.onSurfaceVariant
              : colorScheme.onSurfaceVariant.withValues(alpha: 0.38),
        );

    final resolvedConstraints =
        widget.constraints ??
        componentTheme.constraints ??
        const BoxConstraints(
          minHeight: 56.0,
          maxHeight: 56.0,
          minWidth: 360.0,
          maxWidth: 720.0,
        );

    final resolvedLeadingIconColor =
        componentTheme.leadingIconColor?.resolve(states) ??
        (widget.enabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.38));

    final resolvedTrailingIconColor =
        componentTheme.trailingIconColor?.resolve(states) ??
        (widget.enabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurfaceVariant.withValues(alpha: 0.38));

    final effectiveCursorColor =
        componentTheme.cursorColor ?? colorScheme.primary;

    // Build leading widget
    Widget? leadingWidget;
    if (widget.leading != null) {
      leadingWidget = IconTheme.merge(
        data: IconThemeData(color: resolvedLeadingIconColor, size: 24.0),
        child: widget.leading!,
      );
    }

    // Build trailing widgets
    final trailingWidgets = <Widget>[];
    if (widget.trailing != null) {
      for (final t in widget.trailing!) {
        trailingWidgets.add(
          IconTheme.merge(
            data: IconThemeData(color: resolvedTrailingIconColor, size: 24.0),
            child: t,
          ),
        );
      }
    }

    // Build avatar if shown
    if ((widget.avatar != null) && widget.avatar != null) {
      trailingWidgets.add(widget.avatar!);
    }

    // Build main row contents
    final rowChildren = <Widget>[
      if (leadingWidget != null) ...[
        leadingWidget,
        const SizedBox(width: 12.0),
      ],
      Expanded(
        child: TextField(
          controller: _effectiveController,
          focusNode: _effectiveFocusNode,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          style: resolvedTextStyle,
          cursorColor: effectiveCursorColor,
          onTapOutside: widget.onTapOutside,
          onChanged: _handleTextChanged,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: widget.hintText,
            hintStyle: resolvedHintStyle,
            fillColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
        ),
      ),
      if (trailingWidgets.isNotEmpty) ...[
        const SizedBox(width: 8.0),
        for (int i = 0; i < trailingWidgets.length; i++) ...[
          if (i > 0) const SizedBox(width: 8.0),
          trailingWidgets[i],
        ],
      ],
    ];

    Widget content = Container(
      constraints: resolvedConstraints,
      padding: resolvedPadding,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowChildren,
      ),
    );

    return Semantics(
      container: true,
      label: widget.semanticLabel ?? 'Search bar',
      enabled: widget.enabled,
      child: MouseRegion(
        cursor: widget.enabled
            ? (widget.readOnly
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.text)
            : SystemMouseCursors.basic,
        onEnter: (_) {
          if (widget.enabled && !_isHovered) {
            setState(() => _isHovered = true);
          }
        },
        onExit: (_) {
          if (widget.enabled && _isHovered) {
            setState(() => _isHovered = false);
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (!widget.enabled) return;
            if (!widget.readOnly && !_effectiveFocusNode.hasFocus) {
              _effectiveFocusNode.requestFocus();
            }
            widget.onTap?.call();
          },
          onTapDown: widget.enabled
              ? (_) => setState(() => _isPressed = true)
              : null,
          onTapUp: widget.enabled
              ? (_) => setState(() => _isPressed = false)
              : null,
          onTapCancel: () {
            if (widget.enabled && _isPressed) {
              setState(() => _isPressed = false);
            }
          },
          child: Material(
            elevation: resolvedElevation,
            shadowColor: resolvedShadowColor,
            surfaceTintColor: resolvedSurfaceTintColor,
            color: resolvedBg,
            shape: resolvedShape,
            clipBehavior: Clip.antiAlias,
            child: (resolvedOverlayColor != Colors.transparent)
                ? ColoredBox(color: resolvedOverlayColor, child: content)
                : content,
          ),
        ),
      ),
    );
  }
}
