import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'menu_entry.dart';
import 'menu_enums.dart';
import 'menu_theme.dart';

/// Internal widget that renders an individual [MechanixMenuItem] tile
/// with full interactive state resolution, accessible semantics, and platform-specific
/// touch target sizing.
class MenuItemTile<T> extends StatefulWidget {
  const MenuItemTile({
    super.key,
    required this.item,
    required this.size,
    required this.theme,
    required this.isFocused,
    this.onActivate,
    this.onHoverChanged,
  });

  /// The item definition.
  final MechanixMenuItem<T> item;

  /// The menu size variant (regular or small).
  final MechanixMenuSize size;

  /// The resolved menu configuration.
  final MenuThemeDataConfig theme;

  /// Whether this item currently holds keyboard focus.
  final bool isFocused;

  /// Callback when this item is activated (tapped or Enter/Space pressed).
  final VoidCallback? onActivate;

  /// Callback when hover state changes.
  final ValueChanged<bool>? onHoverChanged;

  @override
  State<MenuItemTile<T>> createState() => _MenuItemTileState<T>();
}

class _MenuItemTileState<T> extends State<MenuItemTile<T>> {
  bool _isHovered = false;
  bool _isPressed = false;

  Set<WidgetState> get _states {
    final states = <WidgetState>{};
    if (!widget.item.enabled) {
      states.add(WidgetState.disabled);
    } else {
      if (widget.item.selected) states.add(WidgetState.selected);
      if (_isPressed) states.add(WidgetState.pressed);
      if (_isHovered) states.add(WidgetState.hovered);
      if (widget.isFocused) states.add(WidgetState.focused);
    }
    return states;
  }

  void _handleTap() {
    if (!widget.item.enabled) return;
    widget.onActivate?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final item = widget.item;
    final states = _states;

    // Resolve colors based on current states
    final backgroundColor =
        theme.itemBackgroundColor?.resolve(states) ?? Colors.transparent;
    final foregroundColor =
        theme.itemForegroundColor?.resolve(states) ??
        Theme.of(context).colorScheme.onSurface;
    final iconColor =
        theme.itemIconColor?.resolve(states) ??
        Theme.of(context).colorScheme.onSurfaceVariant;
    final focusBorderColor =
        theme.focusBorderColor?.resolve(states) ??
        Theme.of(context).colorScheme.primary;

    // Dimensions
    final iconSize = theme.resolveIconSize(widget.size);
    final iconLabelGap = theme.iconLabelGap ?? 8.0;
    final itemPadding =
        theme.itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0);

    // Height & touch target resolution
    final visualHeight = theme.resolveItemHeight(widget.size);
    final isTouchPlatform = switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.fuchsia => true,
      _ => false,
    };

    // On touch platforms, minimum touch target is kept >= 48dp
    final effectiveHeight = isTouchPlatform
        ? (visualHeight < (theme.minTapTargetSize ?? kMinInteractiveDimension)
              ? (theme.minTapTargetSize ?? kMinInteractiveDimension)
              : visualHeight)
        : visualHeight;

    final labelStyle = theme
        .resolveLabelStyle(widget.size)
        .copyWith(color: foregroundColor);

    // Build leading widget
    Widget? leadingWidget;
    if (item.leading != null) {
      leadingWidget = item.leading;
    } else if (item.leadingIcon != null) {
      leadingWidget = Icon(item.leadingIcon, size: iconSize, color: iconColor);
    }

    // Build trailing widget
    Widget? trailingWidget;
    if (item.trailing != null) {
      trailingWidget = item.trailing;
    } else if (item.trailingIcon != null) {
      trailingWidget = Icon(
        item.trailingIcon,
        size: iconSize,
        color: iconColor,
      );
    }

    // Border for focus indication
    final border = widget.isFocused && item.enabled
        ? Border.all(
            color: focusBorderColor,
            width: theme.focusBorderWidth ?? 2.0,
          )
        : null;

    final tileContent = Container(
      height: effectiveHeight,
      padding: itemPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
        border: border,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingWidget != null) ...[
            leadingWidget,
            SizedBox(width: iconLabelGap),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.label != null)
                  DefaultTextStyle(
                    style: labelStyle,
                    child: item.label!,
                  )
                else if (item.labelText != null)
                  Text(
                    item.labelText!,
                    style: labelStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (item.supportingText != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.supportingText!,
                    style:
                        (theme.supportingTextStyle ??
                                Theme.of(context).textTheme.bodySmall)
                            ?.copyWith(
                              color: theme.itemIconColor?.resolve(states),
                            ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (item.badge != null) ...[const SizedBox(width: 8), item.badge!],
          if (item.trailingText != null) ...[
            const SizedBox(width: 8),
            Text(
              item.trailingText!,
              style:
                  (theme.trailingTextStyle ??
                          Theme.of(context).textTheme.labelSmall)
                      ?.copyWith(color: theme.itemIconColor?.resolve(states)),
            ),
          ],
          if (trailingWidget != null) ...[
            const SizedBox(width: 8),
            trailingWidget,
          ],
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: item.enabled,
      selected: item.selected,
      label: item.semanticLabel ?? item.labelText,
      child: MouseRegion(
        cursor: item.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) {
          if (!item.enabled) return;
          setState(() => _isHovered = true);
          widget.onHoverChanged?.call(true);
        },
        onExit: (_) {
          if (!item.enabled) return;
          setState(() => _isHovered = false);
          widget.onHoverChanged?.call(false);
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: item.enabled
              ? (_) => setState(() => _isPressed = true)
              : null,
          onTapUp: item.enabled
              ? (_) => setState(() => _isPressed = false)
              : null,
          onTapCancel: item.enabled
              ? () => setState(() => _isPressed = false)
              : null,
          onTap: item.enabled ? _handleTap : null,
          child: tileContent,
        ),
      ),
    );
  }
}
