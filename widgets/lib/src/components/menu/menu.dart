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
        final screenSize = mediaQuery.size;
        final isRtl = Directionality.of(context) == TextDirection.rtl;

        // Positioning calculations
        final double? resolvedWidth = widget.matchAnchorWidth
            ? anchorRect.width
            : null;

        // Horizontal positioning
        double left = 0;
        if (widget.matchAnchorWidth) {
          left = anchorRect.left;
        } else {
          switch (widget.alignment) {
            case MechanixMenuAlignment.start:
              left = isRtl
                  ? anchorRect.right -
                        (resolvedWidth ?? 200.0) +
                        widget.offset.dx
                  : anchorRect.left + widget.offset.dx;
              break;
            case MechanixMenuAlignment.center:
              left =
                  anchorRect.center.dx -
                  ((resolvedWidth ?? 200.0) / 2) +
                  widget.offset.dx;
              break;
            case MechanixMenuAlignment.end:
              left = isRtl
                  ? anchorRect.left + widget.offset.dx
                  : anchorRect.right -
                        (resolvedWidth ?? 200.0) +
                        widget.offset.dx;
              break;
          }
        }

        // Clamp to screen bounds horizontally
        final maxLeft = screenSize.width - (resolvedWidth ?? 200.0) - 8.0;
        if (maxLeft >= 8.0) {
          left = left.clamp(8.0, maxLeft);
        } else {
          left = 8.0;
        }

        // Vertical positioning
        final spaceBelow =
            (screenSize.height -
                    anchorRect.bottom -
                    mediaQuery.padding.bottom -
                    16)
                .clamp(0.0, screenSize.height);
        final spaceAbove = (anchorRect.top - mediaQuery.padding.top - 16).clamp(
          0.0,
          screenSize.height,
        );
        final shouldFlipAbove = spaceBelow < 120 && spaceAbove > spaceBelow;

        final double top;
        final double effectiveMaxHeight;

        if (shouldFlipAbove) {
          effectiveMaxHeight = widget.maxHeight.clamp(
            0.0,
            spaceAbove > 0 ? spaceAbove : widget.maxHeight,
          );
          final minTop = mediaQuery.padding.top + 8.0;
          final computedTop =
              anchorRect.top - widget.offset.dy - effectiveMaxHeight;
          top = computedTop < minTop ? minTop : computedTop;
        } else {
          effectiveMaxHeight = widget.maxHeight.clamp(
            0.0,
            spaceBelow > 0 ? spaceBelow : widget.maxHeight,
          );
          top = anchorRect.bottom + widget.offset.dy;
        }

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
            maxHeight: effectiveMaxHeight,
            width: resolvedWidth,
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

        final positioned = Positioned(
          left: left,
          top: top,
          child: Semantics(
            container: true,
            label: widget.semanticLabel ?? 'Menu',
            child: panelWidget,
          ),
        );

        return Stack(children: [positioned]);
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
