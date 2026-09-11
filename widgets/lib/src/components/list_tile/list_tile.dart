import 'package:flutter/material.dart';

import 'list_tile_enums.dart';
import 'list_tile_theme.dart';

export 'list_tile_enums.dart';
export 'list_tile_theme.dart';

/// A customizable, accessible List Tile component conforming to the
/// Mechanix design system specifications.
///
/// Supports Standard (transparent) and Segmented (filled container) variants,
/// overline text, title label, supporting line text with ellipsis,
/// leading and trailing elements, middle-alignment, and focus indicators.
class MechanixListTile extends StatefulWidget {
  const MechanixListTile({
    super.key,
    this.variant = ListTileVariant.standard,
    this.label,
    this.labelText,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.content,
    this.leading,
    this.showLeading = true,
    this.trailingWidgets = const [],
    this.trailingText,
    this.showTrailing = true,
    this.enabled = true,
    this.selected = false,
    this.showFocusIndicator = true,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.minHeight = 52.0,
    this.height,
    this.width,
    this.margin,
    this.gap = 8.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.selectedColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.leadingIconColor,
    this.labelColor,
    this.overlineColor,
    this.supportingTextColor,
    this.trailingTextColor,
    this.theme,
  }) : assert(
         trailingWidgets.length <= 2,
         'MechanixListTile supports a maximum of 2 trailing widgets.',
       );

  /// Factory constructor for a Segmented Filled [MechanixListTile].
  const MechanixListTile.segmented({
    super.key,
    this.label,
    this.labelText,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.content,
    this.leading,
    this.showLeading = true,
    this.trailingWidgets = const [],
    this.trailingText,
    this.showTrailing = true,
    this.enabled = true,
    this.selected = false,
    this.showFocusIndicator = true,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.minHeight = 52.0,
    this.height,
    this.width,
    this.margin,
    this.gap = 8.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.selectedColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.leadingIconColor,
    this.labelColor,
    this.overlineColor,
    this.supportingTextColor,
    this.trailingTextColor,
    this.theme,
  }) : assert(
         trailingWidgets.length <= 2,
         'MechanixListTile supports a maximum of 2 trailing widgets.',
       ),
       variant = ListTileVariant.segmented;

  /// Visual styling variant ([ListTileVariant.standard] or [ListTileVariant.segmented]).
  final ListTileVariant variant;

  /// Primary label text string.
  final String? label;

  /// Custom widget for primary label (overrides [label] if provided).
  final Widget? labelText;

  /// Uppercase overline text string.
  final String? overline;

  /// Whether to display the overline text when available.
  final bool showOverline;

  /// Supporting description text string.
  final String? supportingText;

  /// Whether to display the supporting description text when available.
  final bool showSupportingText;

  /// Custom central content widget (overrides overline, label, and supporting text).
  final Widget? content;

  /// Leading element widget (e.g. icon or avatar).
  final Widget? leading;

  /// Whether to show the leading element. Defaults to true.
  final bool showLeading;

  /// Custom trailing widgets. Supports a maximum of 2 widgets.
  final List<Widget> trailingWidgets;

  /// Trailing shortcut/status text (e.g., '⌘C').
  final String? trailingText;

  /// Whether to show trailing elements. Defaults to true.
  final bool showTrailing;

  /// Whether this list tile is enabled and interactive.
  final bool enabled;

  /// Whether this list tile is selected.
  final bool selected;

  /// Whether to show a focus indicator ring when focused.
  final bool showFocusIndicator;

  /// Callback when the tile is tapped.
  final VoidCallback? onTap;

  /// Callback when the tile is long pressed.
  final VoidCallback? onLongPress;

  /// Optional [FocusNode] for controlling keyboard focus.
  final FocusNode? focusNode;

  /// Whether the tile should autofocus on init.
  final bool autofocus;

  /// Minimum height of the tile. Defaults to 32.0.
  final double minHeight;

  /// Explicit height for the tile. Defaults to null (hugs content or single-line standard 51.0).
  final double? height;

  /// Explicit width for the tile.
  final double? width;

  /// Outer margin around the tile container.
  final EdgeInsetsGeometry? margin;

  /// Spacing gap between leading, content, and trailing elements. Defaults to 8.0.
  final double gap;

  /// Internal padding for the tile.
  final EdgeInsetsGeometry? contentPadding;

  /// Corner radius of the tile container.
  final BorderRadius? borderRadius;

  /// Background color override.
  final Color? backgroundColor;

  /// Hover overlay color override.
  final Color? hoverColor;

  /// Pressed overlay color override.
  final Color? pressedColor;

  /// Selected background color override.
  final Color? selectedColor;

  /// Keyboard focus border color override.
  final Color? focusBorderColor;

  /// Keyboard focus border width override.
  final double? focusBorderWidth;

  /// Leading icon color override.
  final Color? leadingIconColor;

  /// Primary label text color override.
  final Color? labelColor;

  /// Overline text color override.
  final Color? overlineColor;

  /// Supporting text color override.
  final Color? supportingTextColor;

  /// Trailing text color override.
  final Color? trailingTextColor;

  /// Custom scoped theme override.
  final ListTileThemeDataConfig? theme;

  @override
  State<MechanixListTile> createState() => _MechanixListTileState();
}

class _MechanixListTileState extends State<MechanixListTile> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  void _handleHover(bool hovering) {
    if (!widget.enabled) return;
    if (_isHovered != hovering) {
      setState(() => _isHovered = hovering);
    }
  }

  void _handleFocusChange(bool focused) {
    if (_isFocused != focused) {
      setState(() => _isFocused = focused);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;
    final scopedTheme = MechanixListTileTheme.of(context).merge(widget.theme);

    // Resolve BorderRadius
    final effectiveBorderRadius =
        widget.borderRadius ?? scopedTheme.borderRadius ?? BorderRadius.zero;

    // Resolve Padding
    final effectivePadding =
        widget.contentPadding ??
        scopedTheme.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    final effectiveGap = scopedTheme.gap ?? widget.gap;
    final effectiveMinHeight = scopedTheme.minHeight ?? widget.minHeight;

    // Resolve Background Color
    Color resolvedBackgroundColor;
    if (widget.backgroundColor != null) {
      resolvedBackgroundColor = widget.backgroundColor!;
    } else if (scopedTheme.backgroundColor != null) {
      resolvedBackgroundColor = scopedTheme.backgroundColor!;
    } else if (widget.variant == ListTileVariant.segmented) {
      resolvedBackgroundColor = colorScheme.secondaryContainer;
    } else {
      resolvedBackgroundColor = Colors.transparent;
    }

    // Apply interactive state tinting
    if (widget.enabled) {
      if (widget.selected) {
        final selColor =
            widget.selectedColor ??
            scopedTheme.selectedColor ??
            colorScheme.primary.withValues(alpha: 0.12);
        resolvedBackgroundColor = Color.alphaBlend(
          selColor,
          resolvedBackgroundColor,
        );
      }
      if (_isPressed) {
        final prColor =
            widget.pressedColor ??
            scopedTheme.pressedColor ??
            colorScheme.onSurface.withValues(alpha: 0.12);
        resolvedBackgroundColor = Color.alphaBlend(
          prColor,
          resolvedBackgroundColor,
        );
      } else if (_isHovered) {
        final hovColor =
            widget.hoverColor ??
            scopedTheme.hoverColor ??
            colorScheme.onSurface.withValues(alpha: 0.08);
        resolvedBackgroundColor = Color.alphaBlend(
          hovColor,
          resolvedBackgroundColor,
        );
      }
    }

    // Focus indicator
    final showFocus =
        widget.showFocusIndicator &&
        (scopedTheme.showFocusIndicator ?? true) &&
        _isFocused;
    final focusColor =
        widget.focusBorderColor ??
        scopedTheme.focusBorderColor ??
        colorScheme.outline;
    final focusWidth =
        widget.focusBorderWidth ?? scopedTheme.focusBorderWidth ?? 3.0;

    // Disabled opacity
    final double opacity = widget.enabled ? 1.0 : 0.38;

    // Build Leading
    Widget? leadingWidget;
    if (widget.showLeading && widget.leading != null) {
      final leadIconColor =
          widget.leadingIconColor ??
          scopedTheme.leadingIconColor ??
          colorScheme.onSurface;
      final leadIconSize = scopedTheme.leadingIconSize ?? 20.0;

      leadingWidget = IconTheme(
        data: IconThemeData(color: leadIconColor, size: leadIconSize),
        child: SizedBox(
          width: leadIconSize,
          height: leadIconSize,
          child: Center(child: widget.leading),
        ),
      );
    }

    // Build Central Content
    Widget contentWidget;
    if (widget.content != null) {
      contentWidget = widget.content!;
    } else {
      final children = <Widget>[];

      // 1. Overline Text (Label Large Medium uppercase, OnSurfaceVariant)
      final hasOverline =
          widget.showOverline &&
          widget.overline != null &&
          widget.overline!.isNotEmpty;
      if (hasOverline) {
        final baseOverlineStyle =
            textTheme.labelLarge ??
            const TextStyle(fontSize: 14, height: 20 / 14, letterSpacing: -0.5);
        final overlineStyle =
            (widget.overlineColor != null
                    ? baseOverlineStyle.copyWith(color: widget.overlineColor)
                    : baseOverlineStyle.copyWith(
                        color:
                            scopedTheme.overlineStyle?.color ??
                            colorScheme.onSurfaceVariant,
                      ))
                .copyWith(fontWeight: FontWeight.w500, letterSpacing: -0.5)
                .merge(scopedTheme.overlineStyle);

        children.add(
          Text(
            widget.overline!.toUpperCase(),
            style: overlineStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }

      // 2. Primary Label Text (Title Large Regular, OnSecondaryFixed / OnSurface)
      final baseLabelStyle =
          textTheme.titleLarge ??
          const TextStyle(fontSize: 20, height: 26 / 20, letterSpacing: 0);
      final labelStyle =
          (widget.labelColor != null
                  ? baseLabelStyle.copyWith(color: widget.labelColor)
                  : baseLabelStyle.copyWith(
                      color:
                          scopedTheme.labelStyle?.color ??
                          colorScheme.onSecondaryFixed,
                    ))
              .copyWith(fontWeight: FontWeight.w400)
              .merge(scopedTheme.labelStyle);

      if (widget.labelText != null) {
        children.add(
          DefaultTextStyle(style: labelStyle, child: widget.labelText!),
        );
      } else if (widget.label != null && widget.label!.isNotEmpty) {
        children.add(
          Text(
            widget.label!,
            style: labelStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }

      // 3. Supporting Text (Body Large Regular, OnSurfaceVariant, with text ellipsis)
      final hasSupporting =
          widget.showSupportingText &&
          widget.supportingText != null &&
          widget.supportingText!.isNotEmpty;
      if (hasSupporting) {
        final baseSupportingStyle =
            textTheme.bodyLarge ??
            const TextStyle(fontSize: 16, height: 22 / 16, letterSpacing: 0);
        final supportingStyle =
            (widget.supportingTextColor != null
                    ? baseSupportingStyle.copyWith(
                        color: widget.supportingTextColor,
                      )
                    : baseSupportingStyle.copyWith(
                        color:
                            scopedTheme.supportingTextStyle?.color ??
                            colorScheme.onSurfaceVariant,
                      ))
                .copyWith(fontWeight: FontWeight.w400)
                .merge(scopedTheme.supportingTextStyle);

        children.add(
          Text(
            widget.supportingText!,
            style: supportingStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }

      contentWidget = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    // Build Trailing
    Widget? trailingWidget;

    if (widget.showTrailing) {
      final trailingItems = <Widget>[];

      // Styled trailing text.
      if (widget.trailingText != null && widget.trailingText!.isNotEmpty) {
        final baseTrailingTextStyle =
            textTheme.labelLarge ??
            const TextStyle(fontSize: 14, height: 20 / 14, letterSpacing: -0.5);

        final trailingTextStyle =
            (widget.trailingTextColor != null
                    ? baseTrailingTextStyle.copyWith(
                        color: widget.trailingTextColor,
                      )
                    : baseTrailingTextStyle.copyWith(
                        color:
                            scopedTheme.trailingTextStyle?.color ??
                            colorScheme.onSurfaceVariant,
                      ))
                .merge(scopedTheme.trailingTextStyle);

        trailingItems.add(
          Text(
            widget.trailingText!,
            style: trailingTextStyle,
            textAlign: TextAlign.right,
          ),
        );
      }

      // Custom trailing widgets.
      for (final trailing in widget.trailingWidgets) {
        if (trailingItems.isNotEmpty) {
          trailingItems.add(SizedBox(width: effectiveGap));
        }

        trailingItems.add(trailing);
      }

      if (trailingItems.isNotEmpty) {
        trailingWidget = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: trailingItems,
        );
      }
    }

    // Main Row Layout (Middle-aligned)
    // Main Row Layout (Middle-aligned)
    Widget rowContent = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.enabled ? widget.onTap : null,
            onLongPress: widget.enabled ? widget.onLongPress : null,
            onTapDown: widget.enabled
                ? (_) => setState(() => _isPressed = true)
                : null,
            onTapUp: widget.enabled
                ? (_) => setState(() => _isPressed = false)
                : null,
            onTapCancel: widget.enabled
                ? () => setState(() => _isPressed = false)
                : null,
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leadingWidget != null) ...[
                  leadingWidget,
                  SizedBox(width: effectiveGap),
                ],
                Expanded(child: contentWidget),
              ],
            ),
          ),
        ),

        if (trailingWidget != null) ...[
          SizedBox(width: effectiveGap),
          trailingWidget,
        ],
      ],
    );

    // Padding & Dimensions
    Widget tileBox = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      constraints: BoxConstraints(minHeight: effectiveMinHeight),
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: resolvedBackgroundColor,
        borderRadius: effectiveBorderRadius,
        border: showFocus
            ? Border.all(color: focusColor, width: focusWidth)
            : null,
      ),
      child: rowContent,
    );

    if (opacity < 1.0) {
      tileBox = Opacity(opacity: opacity, child: tileBox);
    }

    // Interactive wrapper
    final hasInteractions =
        widget.enabled && (widget.onTap != null || widget.onLongPress != null);

    return FocusableActionDetector(
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onShowHoverHighlight: _handleHover,
      onShowFocusHighlight: _handleFocusChange,
      mouseCursor: widget.enabled
          ? (hasInteractions
                ? SystemMouseCursors.click
                : SystemMouseCursors.basic)
          : SystemMouseCursors.basic,
      child: tileBox,
    );
  }
}

/// A container that lays out segmented list tiles in a vertical group
/// with the design-specified 2px gap between adjacent tiles (`gap = 2.0`).
///
/// Using [MechanixSegmentedList] eliminates the need to manually insert
/// `SizedBox(height: 2)` between segmented list items.
class MechanixSegmentedList extends StatelessWidget {
  const MechanixSegmentedList({
    super.key,
    required this.children,
    this.gap = 2.0,
    this.padding,
    this.shrinkWrap = true,
    this.physics,
  });

  /// The list of items, typically [MechanixListTile.segmented].
  final List<Widget> children;

  /// Vertical spacing gap between adjacent tiles. Defaults to 2.0.
  final double gap;

  /// Optional padding around the list.
  final EdgeInsetsGeometry? padding;

  /// Whether to shrink wrap the list. Defaults to true.
  final bool shrinkWrap;

  /// Optional scroll physics.
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final items = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      if (i > 0) {
        items.add(SizedBox(height: gap));
      }
      items.add(children[i]);
    }

    Widget content = Column(
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    return content;
  }
}
