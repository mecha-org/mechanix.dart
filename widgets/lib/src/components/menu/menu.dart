import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_menu_keyboard_helper.dart';
import '_menu_panel.dart';
import 'menu_controller.dart';
import 'menu_entry.dart';
import 'menu_enums.dart';
import 'menu_theme.dart';

class MechanixMenu<T> extends StatefulWidget {
  /// Creates a [MechanixMenu].
  const MechanixMenu({
    super.key,
    required this.anchorBuilder,
    required this.entries,
    this.onSelected,
    this.controller,
    this.size = MechanixMenuSize.regular,
    this.alignment = MechanixMenuAlignment.start,
    this.offset = const Offset(0, 4),
    this.matchAnchorWidth = false,
    this.width,
    this.minWidth,
    this.maxWidth,
    this.maxHeight = 320.0,
    this.closeOnSelect = true,
    this.onOpen,
    this.onClose,
    this.style,
    this.semanticLabel,
    this.child,
  });

  /// Builder for the anchor widget that opens/closes this menu.
  final Widget Function(
    BuildContext context,
    MechanixMenuController controller,
    Widget? child,
  )
  anchorBuilder;

  /// The entries (items, groups, dividers, custom entries) displayed in the menu.
  final List<MechanixMenuEntry<T>> entries;

  /// Callback invoked when any item within this menu is selected.
  ///
  /// Order of precedence on activation:
  /// 1. [MechanixMenuItem.onTap] is called.
  /// 2. [onSelected] is called with the item's value.
  /// 3. The menu is closed if [closeOnSelect] is true.
  final ValueChanged<T>? onSelected;

  /// Optional controller to programmatically drive the menu open/closed state.
  final MechanixMenuController? controller;

  /// The size variant (regular or small) for menu item typography and spacing.
  final MechanixMenuSize size;

  /// Alignment strategy of the menu relative to the anchor widget.
  final MechanixMenuAlignment alignment;

  /// Additional pixel offset applied to the menu position relative to the anchor.
  final Offset offset;

  /// Whether the menu width should exactly match the width of the anchor widget.
  final bool matchAnchorWidth;

  /// Explicit fixed width for the menu panel.
  final double? width;

  /// Minimum width constraint for the menu panel when [width] is null.
  final double? minWidth;

  /// Maximum width constraint for the menu panel when [width] is null.
  final double? maxWidth;

  /// Maximum height constraint for the menu panel before scrolling occurs.
  final double maxHeight;

  /// Whether to automatically dismiss the menu when an item is selected.
  /// Defaults to true.
  final bool closeOnSelect;

  /// Callback when the menu is opened.
  final VoidCallback? onOpen;

  /// Callback when the menu is closed.
  final VoidCallback? onClose;

  /// Optional instance-level styling configuration merged over the inherited [MechanixMenuTheme].
  final MenuThemeDataConfig? style;

  /// Semantic label for accessibility announcement.
  final String? semanticLabel;

  /// Optional child passed to [anchorBuilder].
  final Widget? child;

  @override
  State<MechanixMenu<T>> createState() => _MechanixMenuState<T>();
}

class _MechanixMenuState<T> extends State<MechanixMenu<T>> {
  late final MenuController _nativeMenuController;
  late MechanixMenuController _effectiveController;
  final FocusNode _menuFocusNode = FocusNode();

  int _focusedItemIndex = 0;
  bool _showFocusHighlight = false;
  List<MechanixMenuItem<T>> _flattenedItems = [];
  FocusNode? _previousFocusNode;

  @override
  void initState() {
    super.initState();
    _nativeMenuController = MenuController();
    _effectiveController = widget.controller ?? MechanixMenuController();
    _effectiveController.attach(_nativeMenuController);
    _flattenItems();
  }

  @override
  void didUpdateWidget(covariant MechanixMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _effectiveController.detach();
      }
      _effectiveController = widget.controller ?? MechanixMenuController();
      _effectiveController.attach(_nativeMenuController);
    }
    _flattenItems();
  }

  @override
  void dispose() {
    _effectiveController.detach();
    _menuFocusNode.dispose();
    super.dispose();
  }

  void _flattenItems() {
    final items = <MechanixMenuItem<T>>[];
    void collect(List<MechanixMenuEntry<T>> list) {
      for (final entry in list) {
        if (entry is MechanixMenuItem<T>) {
          items.add(entry);
        } else if (entry is MechanixMenuGroup<T>) {
          collect(entry.entries);
        }
      }
    }

    collect(widget.entries);
    _flattenedItems = items;
    _resetFocusIndex();
  }

  void _resetFocusIndex() {
    // Default focused index to first enabled or selected item
    int initialFocus = -1;
    for (int i = 0; i < _flattenedItems.length; i++) {
      if (_flattenedItems[i].selected && _flattenedItems[i].enabled) {
        initialFocus = i;
        break;
      }
      if (_flattenedItems[i].enabled && initialFocus == -1) {
        initialFocus = i;
      }
    }
    _focusedItemIndex = initialFocus == -1 ? 0 : initialFocus;
  }

  void _handleMenuOpen() {
    _previousFocusNode = FocusManager.instance.primaryFocus;
    _showFocusHighlight = false;
    _resetFocusIndex();
  }

  void _handleMenuClose() {
    _showFocusHighlight = false;
    final prev = _previousFocusNode;
    _previousFocusNode = null;
    if (prev != null && prev.context != null && prev.canRequestFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (prev.context != null && prev.canRequestFocus) {
          prev.requestFocus();
        }
      });
    }
  }

  void _handleItemActivation(MechanixMenuItem<T> item) {
    // 1. Call item.onTap
    item.onTap?.call();
    // 2. Call menu.onSelected
    widget.onSelected?.call(item.value);
    // 3. Close if closeOnSelect
    if (widget.closeOnSelect) {
      _effectiveController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final inheritedTheme = MechanixMenuTheme.of(context);
    final effectiveTheme = widget.style != null
        ? inheritedTheme.merge(widget.style)
        : inheritedTheme;

    final keyboardHelper = MenuKeyboardHelper<T>(
      flattenedItems: _flattenedItems,
      initialFocusedIndex: _focusedItemIndex,
      onFocusChanged: (newIdx) {
        setState(() {
          _focusedItemIndex = newIdx;
          _showFocusHighlight = true;
        });
      },
      onActivate: _handleItemActivation,
      onClose: () => _effectiveController.close(),
    );

    return RawMenuAnchor(
      controller: _nativeMenuController,
      onOpen: () {
        _handleMenuOpen();
        widget.onOpen?.call();
      },
      onClose: () {
        _handleMenuClose();
        widget.onClose?.call();
      },
      overlayBuilder: (context, info) {
        final anchorRect = info.anchorRect;
        final mediaQuery = MediaQuery.of(context);
        final textDirection = Directionality.of(context);

        final double? resolvedWidth =
            widget.width ?? (widget.matchAnchorWidth ? anchorRect.width : null);

        final panelWidget = Focus(
          focusNode: _menuFocusNode,
          autofocus: true,
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent || event is KeyRepeatEvent) {
              final key = event.logicalKey;
              if (key == LogicalKeyboardKey.arrowDown ||
                  key == LogicalKeyboardKey.arrowUp ||
                  key == LogicalKeyboardKey.home ||
                  key == LogicalKeyboardKey.end) {
                if (!_showFocusHighlight) {
                  setState(() => _showFocusHighlight = true);
                }
              }
            }
            final handled = keyboardHelper.handleKeyEvent(event);
            return handled ? KeyEventResult.handled : KeyEventResult.ignored;
          },
          child: MenuPanel<T>(
            entries: widget.entries,
            size: widget.size,
            theme: effectiveTheme,
            maxHeight: widget.maxHeight,
            width: resolvedWidth,
            minWidth: widget.minWidth ?? 160.0,
            maxWidth: widget.maxWidth ?? 360.0,
            focusedIndex: _showFocusHighlight ? _focusedItemIndex : -1,
            onActivateItem: _handleItemActivation,
            onItemHovered: (idx) {
              if (_focusedItemIndex != idx || _showFocusHighlight) {
                setState(() {
                  _focusedItemIndex = idx;
                  _showFocusHighlight = false;
                });
              }
            },
          ),
        );

        return CustomSingleChildLayout(
          delegate: _MechanixMenuLayoutDelegate(
            anchorRect: anchorRect,
            alignment: widget.alignment,
            offset: widget.offset,
            matchAnchorWidth: widget.matchAnchorWidth,
            width: widget.width,
            minWidth: widget.minWidth,
            maxWidth: widget.maxWidth,
            maxHeight: widget.maxHeight,
            textDirection: textDirection,
            mediaQueryPadding: mediaQuery.padding,
            mediaQueryViewInsets: mediaQuery.viewInsets,
          ),
          child: Semantics(
            container: true,
            label: widget.semanticLabel ?? 'Menu',
            child: panelWidget,
          ),
        );
      },
      child: Semantics(
        expanded: _effectiveController.isOpen,
        child: widget.anchorBuilder(
          context,
          _effectiveController,
          widget.child,
        ),
      ),
    );
  }
}

/// A layout delegate that dynamically constrains and positions the menu overlay
/// within the visible viewport.
class _MechanixMenuLayoutDelegate extends SingleChildLayoutDelegate {
  const _MechanixMenuLayoutDelegate({
    required this.anchorRect,
    required this.alignment,
    required this.offset,
    required this.matchAnchorWidth,
    this.width,
    this.minWidth,
    this.maxWidth,
    required this.maxHeight,
    required this.textDirection,
    required this.mediaQueryPadding,
    required this.mediaQueryViewInsets,
  });

  static const EdgeInsets _screenPadding = EdgeInsets.all(8.0);

  final Rect anchorRect;
  final MechanixMenuAlignment alignment;
  final Offset offset;
  final bool matchAnchorWidth;
  final double? width;
  final double? minWidth;
  final double? maxWidth;
  final double maxHeight;
  final TextDirection textDirection;
  final EdgeInsets mediaQueryPadding;
  final EdgeInsets mediaQueryViewInsets;

  Rect _computeUsableRect(Size size) {
    final double left =
        mediaQueryPadding.left +
        mediaQueryViewInsets.left +
        _screenPadding.left;
    final double top =
        mediaQueryPadding.top + mediaQueryViewInsets.top + _screenPadding.top;
    final double right =
        size.width -
        (mediaQueryPadding.right +
            mediaQueryViewInsets.right +
            _screenPadding.right);
    final double bottom =
        size.height -
        (mediaQueryPadding.bottom +
            mediaQueryViewInsets.bottom +
            _screenPadding.bottom);

    final double effectiveRight = math.max(left, right);
    final double effectiveBottom = math.max(top, bottom);
    return Rect.fromLTRB(left, top, effectiveRight, effectiveBottom);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final usableRect = _computeUsableRect(constraints.biggest);
    final usableWidth = usableRect.width;

    // Available vertical space below and above the anchor
    final double spaceBelow = math.max(
      0.0,
      usableRect.bottom - (anchorRect.bottom + offset.dy),
    );
    final double spaceAbove = math.max(
      0.0,
      (anchorRect.top - offset.dy) - usableRect.top,
    );

    final double maxAvailableHeight = math.max(spaceBelow, spaceAbove);
    final double effectiveMaxHeight = math.max(
      0.0,
      math.min(maxHeight, maxAvailableHeight),
    );

    final double minWidth;
    final double maxWidth;
    if (width != null) {
      final double clamped = width!.clamp(0.0, usableWidth);
      minWidth = clamped;
      maxWidth = clamped;
    } else if (matchAnchorWidth) {
      final double anchorWidth = anchorRect.width.clamp(0.0, usableWidth);
      minWidth = anchorWidth;
      maxWidth = anchorWidth;
    } else {
      final double minW = (this.minWidth ?? 160.0).clamp(0.0, usableWidth);
      final double maxW = (this.maxWidth ?? 360.0).clamp(0.0, usableWidth);
      minWidth = math.min(minW, maxW);
      maxWidth = maxW;
    }

    final double effectiveMinWidth = math.min(minWidth, maxWidth);

    return BoxConstraints(
      minWidth: effectiveMinWidth,
      maxWidth: maxWidth,
      minHeight: 0.0,
      maxHeight: effectiveMaxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final usableRect = _computeUsableRect(size);
    final isRtl = textDirection == TextDirection.rtl;

    // Horizontal positioning
    double x;
    if (matchAnchorWidth && width == null) {
      x = anchorRect.left + offset.dx;
    } else {
      switch (alignment) {
        case MechanixMenuAlignment.start:
          x = isRtl
              ? anchorRect.right - childSize.width + offset.dx
              : anchorRect.left + offset.dx;
          break;
        case MechanixMenuAlignment.center:
          x = anchorRect.center.dx - (childSize.width / 2.0) + offset.dx;
          break;
        case MechanixMenuAlignment.end:
          x = isRtl
              ? anchorRect.left + offset.dx
              : anchorRect.right - childSize.width + offset.dx;
          break;
      }
    }

    // Keep horizontal position within usable viewport
    if (childSize.width >= usableRect.width) {
      x = usableRect.left;
    } else {
      if (x + childSize.width > usableRect.right) {
        x = usableRect.right - childSize.width;
      }
      if (x < usableRect.left) {
        x = usableRect.left;
      }
    }

    // Vertical positioning
    final double spaceBelow = math.max(
      0.0,
      usableRect.bottom - (anchorRect.bottom + offset.dy),
    );
    final double spaceAbove = math.max(
      0.0,
      (anchorRect.top - offset.dy) - usableRect.top,
    );

    final double preferredTop = anchorRect.bottom + offset.dy;
    final double aboveTop = anchorRect.top - offset.dy - childSize.height;

    double y;
    if (childSize.height <= spaceBelow) {
      // Preferred position below fits without overflow
      y = preferredTop;
    } else if (childSize.height <= spaceAbove) {
      // Bottom overflow, but enough space above -> flip above
      y = aboveTop;
    } else {
      // Insufficient space on either side -> use the side with more space
      if (spaceAbove > spaceBelow) {
        y = aboveTop;
      } else {
        y = preferredTop;
      }
    }

    final double maxY = math.max(
      usableRect.top,
      usableRect.bottom - childSize.height,
    );
    y = y.clamp(usableRect.top, maxY);

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_MechanixMenuLayoutDelegate oldDelegate) {
    return anchorRect != oldDelegate.anchorRect ||
        alignment != oldDelegate.alignment ||
        offset != oldDelegate.offset ||
        matchAnchorWidth != oldDelegate.matchAnchorWidth ||
        width != oldDelegate.width ||
        minWidth != oldDelegate.minWidth ||
        maxWidth != oldDelegate.maxWidth ||
        maxHeight != oldDelegate.maxHeight ||
        textDirection != oldDelegate.textDirection ||
        mediaQueryPadding != oldDelegate.mediaQueryPadding ||
        mediaQueryViewInsets != oldDelegate.mediaQueryViewInsets;
  }
}
