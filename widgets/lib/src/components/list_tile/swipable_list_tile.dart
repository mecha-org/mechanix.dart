import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../icon_button/icon_button.dart';
import 'list_tile.dart';

export 'package:flutter_slidable/flutter_slidable.dart';

/// Visual swipe threshold indicator consisting of vertical pill bars.
class MechanixSwipeIndicator extends StatelessWidget {
  const MechanixSwipeIndicator({
    super.key,
    required this.count,
    this.activeColor,
    this.inactiveColor,
    this.barWidth = 4.0,
    this.barHeight = 24.0,
    this.gap = 4.0,
  });

  /// Number of bars to display (capped at 3).
  final int count;

  /// Color of the active (accent) bar.
  final Color? activeColor;

  /// Color of the inactive bars.
  final Color? inactiveColor;

  /// Width of each bar.
  final double barWidth;

  /// Height of each bar.
  final double barHeight;

  /// Spacing gap between bars.
  final double gap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedActive = activeColor ?? colorScheme.primary;
    final resolvedInactive =
        inactiveColor ?? colorScheme.surfaceContainerHighest;

    final effectiveCount = count.clamp(1, 3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(effectiveCount, (i) {
        final isRightmost = i == effectiveCount - 1;

        return Container(
          width: barWidth,
          height: barHeight,
          margin: EdgeInsets.only(left: i == 0 ? 0 : gap),
          decoration: BoxDecoration(
            color: isRightmost ? resolvedActive : resolvedInactive,
            borderRadius: BorderRadius.circular(barWidth / 2),
          ),
        );
      }),
    );
  }
}

/// A List Tile that supports horizontal swipe gestures using [flutter_slidable]
/// to reveal up to 3 action buttons matching the Mechanix UI specification.
///
/// The actions are supplied as widgets, allowing [MechanixIconButton] or any
/// other custom widget to be used directly.
class MechanixSwipableListTile extends StatefulWidget {
  const MechanixSwipableListTile({
    super.key,
    this.actions = const [],
    this.autoClose = true,
    this.endActionPane,
    this.startActionPane,
    this.motion,
    this.extentRatio,
    this.openThreshold,
    this.closeThreshold,
    this.controller,
    this.initiallyOpen = false,
    this.closeOnScroll = true,
    this.groupTag,
    this.variant = ListTileVariant.standard,
    this.label,
    this.labelText,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.leading,
    this.showLeading = true,
    this.trailingWidgets = const [],
    this.trailingText,
    this.showTrailing = true,
    this.enabled = true,
    this.selected = false,
    this.onTap,
    this.minHeight = 52.0,
    this.height,
    this.gap = 8.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.hoverColor,
    this.swipedBackgroundColor,
    this.theme,
  }) : assert(
         actions.length <= 3,
         'MechanixSwipableListTile supports a maximum of 3 reveal actions.',
       ),
       assert(
         trailingWidgets.length <= 2,
         'MechanixListTile supports a maximum of 2 trailing widgets.',
       );

  /// Factory constructor for a Segmented [MechanixSwipableListTile].
  const MechanixSwipableListTile.segmented({
    super.key,
    this.actions = const [],
    this.autoClose = true,
    this.endActionPane,
    this.startActionPane,
    this.motion,
    this.extentRatio,
    this.openThreshold,
    this.closeThreshold,
    this.controller,
    this.initiallyOpen = false,
    this.closeOnScroll = true,
    this.groupTag,
    this.label,
    this.labelText,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.leading,
    this.showLeading = true,
    this.trailingWidgets = const [],
    this.trailingText,
    this.showTrailing = true,
    this.enabled = true,
    this.selected = false,
    this.onTap,
    this.minHeight = 52.0,
    this.height,
    this.gap = 8.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.hoverColor,
    this.swipedBackgroundColor,
    this.theme,
  }) : variant = ListTileVariant.segmented,
       assert(
         actions.length <= 3,
         'MechanixSwipableListTile supports a maximum of 3 reveal actions.',
       ),
       assert(
         trailingWidgets.length <= 2,
         'MechanixListTile supports a maximum of 2 trailing widgets.',
       );

  /// Up to 3 widgets revealed when swiped from the end.
  ///
  /// [MechanixIconButton] can be used directly as an action.
  final List<Widget> actions;

  /// Whether tapping an action automatically closes the swiped action pane.
  ///
  /// Defaults to true.
  final bool autoClose;

  /// Custom end [ActionPane] override.
  ///
  /// If null and [actions] is not empty, a default [ActionPane] is created.
  final ActionPane? endActionPane;

  /// Custom start [ActionPane] for swiping to the right.
  final ActionPane? startActionPane;

  /// Motion widget for the default action pane.
  ///
  /// Defaults to [BehindMotion].
  final Widget? motion;

  /// Fraction of total width revealed when swiped.
  ///
  /// Defaults dynamically based on action count.
  final double? extentRatio;

  /// Threshold fraction required to open on drag end.
  final double? openThreshold;

  /// Threshold fraction required to close on drag end.
  final double? closeThreshold;

  /// Optional external [SlidableController].
  final SlidableController? controller;

  /// Whether this tile should initially render in the swiped-open state.
  final bool initiallyOpen;

  /// Whether to close the tile when the enclosing scrollable scrolls.
  final bool closeOnScroll;

  /// Tag used by [SlidableAutoCloseBehavior] to only keep one open at a time.
  final Object? groupTag;

  /// Visual styling variant.
  final ListTileVariant variant;

  /// Primary label text.
  final String? label;

  /// Custom widget for primary label.
  final Widget? labelText;

  /// Overline text.
  final String? overline;

  /// Whether to show the overline text.
  final bool showOverline;

  /// Supporting text.
  final String? supportingText;

  /// Whether to show the supporting text.
  final bool showSupportingText;

  /// Leading element widget.
  final Widget? leading;

  /// Whether to show the leading element.
  final bool showLeading;

  /// Custom trailing widgets. Supports a maximum of 2 widgets.
  final List<Widget> trailingWidgets;

  /// Trailing shortcut/status text (e.g., '⌘C').
  final String? trailingText;

  /// Whether to show trailing elements.
  final bool showTrailing;

  /// Whether the tile is enabled.
  final bool enabled;

  /// Whether the tile is selected.
  final bool selected;

  /// Callback when the tile is tapped.
  final VoidCallback? onTap;

  /// Minimum height of the tile.
  final double minHeight;

  /// Explicit height of the tile.
  final double? height;

  /// Spacing gap between elements inside the tile.
  final double gap;

  /// Internal padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Border radius of the tile.
  final BorderRadius? borderRadius;

  /// Background color override.
  final Color? backgroundColor;

  /// Background color tint when hovered.
  final Color? hoverColor;

  /// Background color override specifically for the swiped/open state.
  ///
  /// In standard variant, defaults to the hovered background color.
  final Color? swipedBackgroundColor;

  /// Custom theme override.
  final ListTileThemeDataConfig? theme;

  @override
  State<MechanixSwipableListTile> createState() =>
      MechanixSwipableListTileState();
}

class MechanixSwipableListTileState extends State<MechanixSwipableListTile>
    with SingleTickerProviderStateMixin {
  late SlidableController _controller;
  bool _createdController = false;
  late bool _wasInitiallyOpen;

  SlidableController get controller => _controller;

  @override
  void initState() {
    super.initState();

    _wasInitiallyOpen = widget.initiallyOpen;

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = SlidableController(this);
      _createdController = true;
    }

    if (widget.initiallyOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.openEndActionPane().then((_) {
            if (mounted) {
              setState(() {
                _wasInitiallyOpen = false;
              });
            }
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant MechanixSwipableListTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != null && widget.controller != _controller) {
      if (_createdController) {
        _controller.dispose();
        _createdController = false;
      }

      _controller = widget.controller!;
    }
  }

  @override
  void dispose() {
    if (_createdController) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Programmatically opens the action pane.
  void open() {
    _controller.openEndActionPane();
  }

  /// Programmatically closes the action pane.
  void close() {
    _controller.close();
  }

  double _resolveExtentRatio(int count) {
    switch (count) {
      case 1:
        return 0.20;
      case 2:
        return 0.32;
      case 3:
      default:
        return 0.42;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final scopedTheme = MechanixListTileTheme.of(context).merge(widget.theme);

    final effectiveRadius =
        widget.borderRadius ??
        scopedTheme.borderRadius ??
        (widget.variant == ListTileVariant.segmented
            ? BorderRadius.circular(4.0)
            : BorderRadius.zero);

    // Resolve hover color tint and the opaque hovered background on surface.
    final hovColor =
        widget.hoverColor ??
        scopedTheme.hoverColor ??
        colorScheme.onSurface.withValues(alpha: 0.08);

    final hoveredBg = Color.alphaBlend(hovColor, colorScheme.surface);

    return AnimatedBuilder(
      animation: _controller.animation,
      builder: (context, _) {
        final isSwiped =
            _wasInitiallyOpen || _controller.animation.value > 0.001;

        // In standard swipable list, the swiped tile background color
        // remains the same as hovered so it is opaque and matches the hover state.
        final effectiveBg =
            widget.backgroundColor ??
            (widget.variant == ListTileVariant.segmented
                ? colorScheme.secondaryContainer
                : (isSwiped
                      ? (widget.swipedBackgroundColor ?? hoveredBg)
                      : Colors.transparent));

        final effectiveHoverColor =
            (widget.variant == ListTileVariant.standard && isSwiped)
            ? Colors.transparent
            : (widget.hoverColor ?? scopedTheme.hoverColor);

        final tile = MechanixListTile(
          variant: widget.variant,
          label: widget.label,
          labelText: widget.labelText,
          overline: widget.overline,
          showOverline: widget.showOverline,
          supportingText: widget.supportingText,
          showSupportingText: widget.showSupportingText,
          leading: widget.leading,
          showLeading: widget.showLeading,
          trailingText: widget.trailingText,
          trailingWidgets: widget.trailingWidgets,
          showTrailing: widget.showTrailing,
          enabled: widget.enabled,
          selected: widget.selected,
          onTap: widget.onTap,
          minHeight: widget.minHeight,
          height: widget.height,
          gap: widget.gap,
          contentPadding: widget.contentPadding,
          borderRadius: widget.borderRadius,
          backgroundColor: effectiveBg,
          hoverColor: effectiveHoverColor,
          theme: widget.theme,
        );

        final effectiveEndPane =
            widget.endActionPane ??
            (widget.actions.isNotEmpty
                ? ActionPane(
                    motion: widget.motion ?? const BehindMotion(),
                    extentRatio:
                        widget.extentRatio ??
                        _resolveExtentRatio(widget.actions.length),
                    openThreshold: widget.openThreshold,
                    closeThreshold: widget.closeThreshold,
                    children: [
                      for (final action in widget.actions)
                        Expanded(
                          child: Center(
                            child: widget.autoClose
                                ? _AutoCloseSwipeAction(
                                    controller: _controller,
                                    child: action,
                                  )
                                : action,
                          ),
                        ),
                    ],
                  )
                : null);

        if (effectiveEndPane == null && widget.startActionPane == null) {
          return tile;
        }

        Widget result = Slidable(
          controller: _controller,
          enabled: widget.enabled,
          closeOnScroll: widget.closeOnScroll,
          groupTag: widget.groupTag,
          startActionPane: widget.startActionPane,
          endActionPane: effectiveEndPane,
          child: tile,
        );

        if (effectiveRadius != BorderRadius.zero) {
          return ClipRRect(
            borderRadius: effectiveRadius,
            clipBehavior: Clip.antiAlias,
            child: result,
          );
        }

        return ClipRect(clipBehavior: Clip.hardEdge, child: result);
      },
    );
  }
}

/// Internal wrapper that closes the [Slidable] when its action child is tapped.
class _AutoCloseSwipeAction extends StatefulWidget {
  const _AutoCloseSwipeAction({required this.controller, required this.child});

  final SlidableController controller;
  final Widget child;

  @override
  State<_AutoCloseSwipeAction> createState() => _AutoCloseSwipeActionState();
}

class _AutoCloseSwipeActionState extends State<_AutoCloseSwipeAction> {
  Offset? _pointerDownPosition;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        _pointerDownPosition = event.position;
      },
      onPointerUp: (event) {
        if (_pointerDownPosition != null) {
          final distance = (event.position - _pointerDownPosition!).distance;
          _pointerDownPosition = null;
          // Movement under 18 logical pixels indicates a tap gesture, not a drag.
          if (distance < 18.0) {
            final childWidget = widget.child;
            if (childWidget is MechanixIconButton && !childWidget.isEnabled) {
              return;
            }
            widget.controller.close();
          }
        }
      },
      onPointerCancel: (_) {
        _pointerDownPosition = null;
      },
      child: widget.child,
    );
  }
}

class MechanixSwipableList extends StatelessWidget {
  const MechanixSwipableList({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(child: Column(children: children));
  }
}
