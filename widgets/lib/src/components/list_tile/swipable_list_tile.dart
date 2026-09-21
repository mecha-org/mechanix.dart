import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../icon_button/icon_button.dart';
import 'list_tile.dart';

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

/// Motion indicator for actions revealed during swipe.
class BehindMotion extends StatelessWidget {
  const BehindMotion({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// Configuration pane for swipe actions.
class ActionPane extends StatelessWidget {
  const ActionPane({
    super.key,
    this.motion = const BehindMotion(),
    this.extentRatio = 0.4,
    this.openThreshold,
    this.closeThreshold,
    required this.children,
  });

  /// Motion widget (e.g. [BehindMotion]).
  final Widget motion;

  /// The total extent ratio of the pane relative to the tile's width.
  final double extentRatio;

  /// Threshold fraction required to open on drag end.
  final double? openThreshold;

  /// Threshold fraction required to close on drag end.
  final double? closeThreshold;

  /// The action widgets displayed in the pane.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

/// Controller to programmatically control opening and closing of swipeable tiles.
class MechanixSwipeController extends ChangeNotifier {
  MechanixSwipeController([TickerProvider? vsync]) {
    if (vsync != null) {
      _animController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 250),
      )..addListener(notifyListeners);
      _curvedAnimation = CurvedAnimation(
        parent: _animController!,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
    }
  }

  AnimationController? _animController;
  CurvedAnimation? _curvedAnimation;
  bool _isInternalController = false;

  void _attach(AnimationController animController) {
    if (_animController == animController) return;
    _animController?.removeListener(notifyListeners);
    _animController = animController;
    _curvedAnimation = CurvedAnimation(
      parent: _animController!,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _animController!.addListener(notifyListeners);
  }

  /// The underlying animation controller.
  AnimationController? get animController => _animController;

  /// The animation driving the swipe transition.
  Animation<double> get animation =>
      _curvedAnimation ?? _animController?.view ?? kAlwaysDismissedAnimation;

  /// Current open progress between 0.0 (closed) and 1.0 (fully open).
  double get value => _animController?.value ?? 0.0;

  /// Current open progress ratio.
  double get ratio => value;

  /// Whether the tile is completely open.
  bool get isOpen => value >= 0.999;

  /// Whether the tile is completely closed.
  bool get isClosed => value <= 0.001;

  /// Programmatically opens the end action pane.
  Future<void> openEndActionPane({Duration? duration, Curve? curve}) async {
    if (_animController == null) return;
    if (duration != null) {
      _animController!.duration = duration;
    }
    await _animController!.animateTo(1.0, curve: curve ?? Curves.easeOutCubic);
  }

  /// Programmatically opens the start action pane.
  Future<void> openStartActionPane({Duration? duration, Curve? curve}) async {
    await openEndActionPane(duration: duration, curve: curve);
  }

  /// Programmatically opens the tile.
  Future<void> open({Duration? duration, Curve? curve}) =>
      openEndActionPane(duration: duration, curve: curve);

  /// Programmatically closes the tile.
  Future<void> close({Duration? duration, Curve? curve}) async {
    if (_animController == null) return;
    if (duration != null) {
      _animController!.duration = duration;
    }
    await _animController!.animateTo(0.0, curve: curve ?? Curves.easeOutCubic);
  }

  @override
  void dispose() {
    if (_isInternalController) {
      _animController?.removeListener(notifyListeners);
      _curvedAnimation?.dispose();
    }
    super.dispose();
  }
}

/// Type alias for backwards-compatibility.
typedef SlidableController = MechanixSwipeController;

/// Scope for coordinating auto-closing behavior across sibling swipeable list tiles.
class MechanixSwipableList extends StatefulWidget {
  const MechanixSwipableList({
    super.key,
    required this.children,
    this.closeOnScroll = true,
  });

  final List<Widget> children;
  final bool closeOnScroll;

  @override
  State<MechanixSwipableList> createState() => _MechanixSwipableListState();
}

class _MechanixSwipableListState extends State<MechanixSwipableList> {
  final Set<MechanixSwipableListTileState> _registeredTiles = {};

  void _register(MechanixSwipableListTileState tile) {
    _registeredTiles.add(tile);
  }

  void _unregister(MechanixSwipableListTileState tile) {
    _registeredTiles.remove(tile);
  }

  void _onTileOpened(MechanixSwipableListTileState activeTile) {
    for (final tile in _registeredTiles) {
      if (tile != activeTile &&
          tile.mounted &&
          (activeTile.widget.groupTag == null ||
              activeTile.widget.groupTag == tile.widget.groupTag)) {
        tile.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _MechanixSwipeScope(
      state: this,
      child: Column(children: widget.children),
    );
  }
}

/// Backwards-compatible alias for [MechanixSwipableList].
class SlidableAutoCloseBehavior extends StatelessWidget {
  const SlidableAutoCloseBehavior({
    super.key,
    required this.child,
    this.closeWhenOpened = true,
    this.closeWhenTapped = true,
  });

  final Widget child;
  final bool closeWhenOpened;
  final bool closeWhenTapped;

  @override
  Widget build(BuildContext context) {
    return _MechanixSwipeScope(state: null, child: child);
  }
}

class _MechanixSwipeScope extends InheritedWidget {
  const _MechanixSwipeScope({required this.state, required super.child});

  final _MechanixSwipableListState? state;

  static _MechanixSwipableListState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_MechanixSwipeScope>()
        ?.state;
  }

  @override
  bool updateShouldNotify(_MechanixSwipeScope oldWidget) =>
      state != oldWidget.state;
}

/// A List Tile that supports horizontal swipe gestures to reveal up to 3 action
/// buttons matching the Mechanix UI specification.
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

  /// Optional external [MechanixSwipeController].
  final MechanixSwipeController? controller;

  /// Whether this tile should initially render in the swiped-open state.
  final bool initiallyOpen;

  /// Whether to close the tile when the enclosing scrollable scrolls.
  final bool closeOnScroll;

  /// Tag used to group tiles so that only one is open at a time in the group.
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
  late AnimationController _animController;
  late MechanixSwipeController _controller;
  bool _createdController = false;
  late bool _wasInitiallyOpen;
  _MechanixSwipableListState? _swipeScope;
  ScrollPosition? _scrollPosition;
  double _dragStartValue = 0.0;

  MechanixSwipeController get controller => _controller;

  @override
  void initState() {
    super.initState();

    _wasInitiallyOpen = widget.initiallyOpen;

    _animController = AnimationController(
      vsync: this,
      value: widget.initiallyOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
    );

    if (widget.controller != null) {
      _controller = widget.controller!;
      _controller._attach(_animController);
    } else {
      _controller = MechanixSwipeController();
      _controller._isInternalController = true;
      _controller._attach(_animController);
      _createdController = true;
    }

    _animController.addStatusListener(_handleStatusChange);

    if (widget.initiallyOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _wasInitiallyOpen = false;
          });
          _notifyScopeOpened();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newScope = _MechanixSwipeScope.maybeOf(context);
    if (_swipeScope != newScope) {
      _swipeScope?._unregister(this);
      _swipeScope = newScope;
      _swipeScope?._register(this);
    }

    if (widget.closeOnScroll) {
      final newScrollPosition = Scrollable.maybeOf(context)?.position;
      if (_scrollPosition != newScrollPosition) {
        _scrollPosition?.removeListener(_handleScroll);
        _scrollPosition = newScrollPosition;
        _scrollPosition?.addListener(_handleScroll);
      }
    } else {
      _scrollPosition?.removeListener(_handleScroll);
      _scrollPosition = null;
    }
  }

  void _handleStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _notifyScopeOpened();
    }
  }

  void _handleScroll() {
    if (controller.value > 0.001) {
      close();
    }
  }

  void _notifyScopeOpened() {
    _swipeScope?._onTileOpened(this);
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
      _controller._attach(_animController);
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_handleScroll);
    _swipeScope?._unregister(this);
    _animController.removeStatusListener(_handleStatusChange);
    if (_createdController) {
      _controller.dispose();
    }
    _animController.dispose();
    super.dispose();
  }

  /// Opens the action pane.
  Future<void> open() {
    return _animController.animateTo(1.0, curve: Curves.easeOutCubic);
  }

  /// Closes the action pane.
  Future<void> close() {
    return _animController.animateTo(0.0, curve: Curves.easeOutCubic);
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

  void _onHorizontalDragStart(DragStartDetails details) {
    if (!widget.enabled) return;
    _dragStartValue = _animController.value;
    _notifyScopeOpened();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details, double maxExtent) {
    if (!widget.enabled || maxExtent <= 0) return;
    // Swiping left (negative primaryDelta) increases the open ratio
    final delta = -(details.primaryDelta ?? 0.0) / maxExtent;
    _animController.value = (_animController.value + delta).clamp(0.0, 1.0);
  }

  void _onHorizontalDragEnd(
    DragEndDetails details,
    double maxExtent,
    double openThreshold,
    double closeThreshold,
  ) {
    if (!widget.enabled) return;
    final velocity = details.primaryVelocity ?? 0.0;

    // Fling left (negative velocity) -> open
    if (velocity < -300) {
      _animController.animateTo(1.0, curve: Curves.easeOutCubic);
      return;
    }

    // Fling right (positive velocity) -> close
    if (velocity > 300) {
      _animController.animateTo(0.0, curve: Curves.easeOutCubic);
      return;
    }

    // Drag past threshold
    final isOpening = _animController.value > _dragStartValue;
    if (isOpening) {
      if (_animController.value >= openThreshold) {
        _animController.animateTo(1.0, curve: Curves.easeOutCubic);
      } else {
        _animController.animateTo(0.0, curve: Curves.easeOutCubic);
      }
    } else {
      if (_animController.value <= (1.0 - closeThreshold)) {
        _animController.animateTo(0.0, curve: Curves.easeOutCubic);
      } else {
        _animController.animateTo(1.0, curve: Curves.easeOutCubic);
      }
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

    final hovColor =
        widget.hoverColor ??
        scopedTheme.hoverColor ??
        colorScheme.onSurface.withValues(alpha: 0.08);

    final hoveredBg = Color.alphaBlend(hovColor, colorScheme.surface);

    final hasActions =
        widget.actions.isNotEmpty ||
        widget.endActionPane != null ||
        widget.startActionPane != null;

    final effectiveExtentRatio =
        widget.extentRatio ??
        widget.endActionPane?.extentRatio ??
        _resolveExtentRatio(
          widget.endActionPane?.children.length ?? widget.actions.length,
        );

    final effectiveOpenThreshold =
        widget.openThreshold ?? widget.endActionPane?.openThreshold ?? 0.35;

    final effectiveCloseThreshold =
        widget.closeThreshold ?? widget.endActionPane?.closeThreshold ?? 0.35;

    final actionWidgets = widget.endActionPane?.children ?? widget.actions;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final maxExtent = totalWidth * effectiveExtentRatio;

        return AnimatedBuilder(
          animation: _animController,
          builder: (context, _) {
            final isSwiped = _wasInitiallyOpen || _animController.value > 0.001;

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
              onTap: isSwiped ? close : widget.onTap,
              minHeight: widget.minHeight,
              height: widget.height,
              gap: widget.gap,
              contentPadding: widget.contentPadding,
              borderRadius: widget.borderRadius,
              backgroundColor: effectiveBg,
              hoverColor: effectiveHoverColor,
              theme: widget.theme,
            );

            if (!hasActions) {
              return tile;
            }

            final slideOffset = _animController.value * maxExtent;

            final actionsPane = Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              width: maxExtent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final action in actionWidgets)
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
              ),
            );

            final slidingTile = Transform.translate(
              offset: Offset(-slideOffset, 0),
              child: tile,
            );

            Widget content = Stack(
              clipBehavior: Clip.hardEdge,
              children: [if (isSwiped) actionsPane, slidingTile],
            );

            if (widget.enabled) {
              content = RawGestureDetector(
                gestures: <Type, GestureRecognizerFactory>{
                  HorizontalDragGestureRecognizer:
                      GestureRecognizerFactoryWithHandlers<
                        HorizontalDragGestureRecognizer
                      >(
                        () => HorizontalDragGestureRecognizer(debugOwner: this),
                        (HorizontalDragGestureRecognizer instance) {
                          instance.onStart = _onHorizontalDragStart;
                          instance.onUpdate = (DragUpdateDetails details) {
                            _onHorizontalDragUpdate(details, maxExtent);
                          };
                          instance.onEnd = (DragEndDetails details) {
                            _onHorizontalDragEnd(
                              details,
                              maxExtent,
                              effectiveOpenThreshold,
                              effectiveCloseThreshold,
                            );
                          };
                          instance.dragStartBehavior = DragStartBehavior.down;
                        },
                      ),
                },
                child: content,
              );
            }

            if (effectiveRadius != BorderRadius.zero) {
              return ClipRRect(
                borderRadius: effectiveRadius,
                clipBehavior: Clip.antiAlias,
                child: content,
              );
            }

            return ClipRect(clipBehavior: Clip.hardEdge, child: content);
          },
        );
      },
    );
  }
}

/// Internal wrapper that closes the swipe action when its action child is tapped.
class _AutoCloseSwipeAction extends StatefulWidget {
  const _AutoCloseSwipeAction({required this.controller, required this.child});

  final MechanixSwipeController controller;
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
