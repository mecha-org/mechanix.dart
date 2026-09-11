import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/widgets.dart';

export 'switch_style.dart';
export 'switch_theme.dart';

/// A customizable toggle switch following the Mechanix design system.
///
/// Features a fixed 88x40px track, 96x48px hug container & tap target area with
/// 96x48px focused border, 32x32px square sliding handle, state-aware handle & text colors,
/// and optional ON/OFF labels.
class MechanixSwitch extends StatefulWidget {
  const MechanixSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.showLabel = true,
    this.labelOn = 'ON',
    this.labelOff = 'OFF',
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.materialTapTargetSize,
    this.visualDensity,
    this.theme,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch.
  /// If null, the switch is disabled.
  final ValueChanged<bool>? onChanged;

  /// Controls whether internal ON/OFF text label is rendered inside the track.
  final bool showLabel;

  /// Custom text string displayed when active (defaults to 'ON').
  final String labelOn;

  /// Custom text string displayed when inactive (defaults to 'OFF').
  final String labelOff;

  /// Optional FocusNode.
  final FocusNode? focusNode;

  /// Whether this switch should auto focus on init.
  final bool autofocus;

  /// Toggle animation duration.
  final Duration duration;

  /// Toggle animation easing curve.
  final Curve curve;

  /// Configures the minimum size of the tap target area.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize] (or [MaterialTapTargetSize.padded]).
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Defines how compact the switch's layout will be.
  ///
  /// Defaults to [ThemeData.visualDensity].
  final VisualDensity? visualDensity;

  /// Custom theme override for this switch instance.
  final SwitchThemeDataConfig? theme;

  bool get isEnabled => onChanged != null;

  @override
  State<MechanixSwitch> createState() => _MechanixSwitchState();
}

class _MechanixSwitchState extends State<MechanixSwitch> {
  static const double _trackWidth = 88.0;
  static const double _trackHeight = 40.0;
  static const double _handleSize = 32.0;
  static const double _padding = 4.0;
  static const double _handleTravelDistance =
      _trackWidth - (2 * _padding) - _handleSize; // 48.0
  static const double _targetWidth = 96.0;
  static const double _targetHeight = 48.0;

  FocusNode? _internalFocusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;
  bool _isDragging = false;
  double _dragPosition = 0.0;

  void _initFocusNode() {
    _internalFocusNode = widget.focusNode == null ? FocusNode() : null;
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void initState() {
    super.initState();
    _initFocusNode();
    _dragPosition = widget.value ? _handleTravelDistance : 0.0;
  }

  @override
  void didUpdateWidget(MechanixSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)?.removeListener(
        _handleFocusChange,
      );
      if (widget.focusNode != null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      } else {
        _internalFocusNode ??= FocusNode();
      }
      _effectiveFocusNode.addListener(_handleFocusChange);
    }
    if (!widget.isEnabled && _effectiveFocusNode.hasFocus) {
      _effectiveFocusNode.unfocus();
    }
    if (widget.value != oldWidget.value && !_isDragging) {
      _dragPosition = widget.value ? _handleTravelDistance : 0.0;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus && widget.isEnabled;
      });
    }
  }

  void _handleTap() {
    if (!widget.isEnabled) return;
    widget.onChanged!(!widget.value);
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.isEnabled) return;
    setState(() {
      _isDragging = true;
      _isPressed = true;
      _dragPosition = widget.value ? _handleTravelDistance : 0.0;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.isEnabled) return;
    final delta = details.primaryDelta ?? 0.0;
    setState(() {
      _dragPosition = (_dragPosition + delta).clamp(0.0, _handleTravelDistance);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.isEnabled) return;
    setState(() {
      _isDragging = false;
      _isPressed = false;
    });

    final velocity = details.primaryVelocity ?? 0.0;
    final bool targetValue;

    if (velocity.abs() >= 150.0) {
      // Fast swipe / fling: velocity determines direction
      targetValue = velocity > 0;
    } else {
      // Deliberate drag: position relative to halfway mark determines direction
      targetValue = _dragPosition >= (_handleTravelDistance / 2);
    }

    if (targetValue != widget.value) {
      widget.onChanged!(targetValue);
    }
  }

  void _handleDragCancel() {
    if (!widget.isEnabled) return;
    setState(() {
      _isDragging = false;
      _isPressed = false;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.isEnabled) {
      return KeyEventResult.ignored;
    }

    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter)) {
      _handleTap();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final mergedTheme = MechanixSwitchTheme.of(context).merge(widget.theme);
    final resolvedStyle = SwitchStyleResolver.resolveStyle(
      context: context,
      value: widget.value,
      isEnabled: widget.isEnabled,
      isHovered: _isHovered,
      isPressed: _isPressed,
      isFocused: _isFocused,
      theme: mergedTheme,
    );

    final isDragActive = _isDragging
        ? (_dragPosition >= (_handleTravelDistance / 2))
        : widget.value;

    final currentText = isDragActive ? widget.labelOn : widget.labelOff;

    final handleLeft = _isDragging
        ? (_padding + _dragPosition)
        : (widget.value ? (_padding + _handleTravelDistance) : _padding);

    // Text style
    final baseTextStyle =
        resolvedStyle.textStyle ??
        Theme.of(context).textTheme.titleMedium ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        );

    Widget handle = Container(
      width: _handleSize,
      height: _handleSize,
      decoration: BoxDecoration(
        color: resolvedStyle.handleColor,
        border: Border.fromBorderSide(resolvedStyle.handleBorder),
      ),
    );

    if (_isDragging) {
      handle = Positioned(
        left: handleLeft,
        top: _padding,
        width: _handleSize,
        height: _handleSize,
        child: handle,
      );
    } else {
      handle = AnimatedPositioned(
        duration: widget.duration,
        curve: widget.curve,
        left: handleLeft,
        top: _padding,
        width: _handleSize,
        height: _handleSize,
        child: handle,
      );
    }

    Widget labelContent = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: AnimatedDefaultTextStyle(
            duration: widget.duration,
            curve: widget.curve,
            style: baseTextStyle.copyWith(color: resolvedStyle.textColor),
            child: Text(
              currentText.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );

    final double labelOpacity;
    final double labelLeft;

    if (_isDragging) {
      final half = _handleTravelDistance / 2;
      if (_dragPosition < half) {
        labelLeft = _padding + _handleSize;
        labelOpacity = (1.0 - (_dragPosition / half)).clamp(0.0, 1.0);
      } else {
        labelLeft = _padding;
        labelOpacity = ((_dragPosition - half) / half).clamp(0.0, 1.0);
      }
    } else {
      labelLeft = widget.value ? _padding : (_padding + _handleSize);
      labelOpacity = 1.0;
    }

    Widget labelLayer;
    if (_isDragging) {
      labelLayer = Positioned(
        left: labelLeft,
        top: _padding,
        width: _handleTravelDistance,
        height: _handleSize,
        child: Opacity(opacity: labelOpacity, child: labelContent),
      );
    } else {
      labelLayer = AnimatedPositioned(
        duration: widget.duration,
        curve: widget.curve,
        left: labelLeft,
        top: _padding,
        width: _handleTravelDistance,
        height: _handleSize,
        child: Opacity(opacity: labelOpacity, child: labelContent),
      );
    }

    Widget visualTrack = AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      width: _trackWidth,
      height: _trackHeight,
      decoration: BoxDecoration(color: resolvedStyle.trackColor),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 1. Text Label Layer
          if (widget.showLabel) labelLayer,

          // 2. Sliding Square Handle
          handle,
        ],
      ),
    );

    final focusBorder = resolvedStyle.focusBorder;
    final focusBorderWidth = mergedTheme.focusBorderWidth ?? 1.0;

    final effectiveTapTargetSize =
        widget.materialTapTargetSize ?? Theme.of(context).materialTapTargetSize;
    final effectiveVisualDensity =
        widget.visualDensity ?? Theme.of(context).visualDensity;

    final baseTargetWidth =
        effectiveTapTargetSize == MaterialTapTargetSize.shrinkWrap
        ? _trackWidth
        : _targetWidth;
    final baseTargetHeight =
        effectiveTapTargetSize == MaterialTapTargetSize.shrinkWrap
        ? _trackHeight
        : _targetHeight;

    final densityAdjustment = effectiveVisualDensity.baseSizeAdjustment;
    final targetWidth = (baseTargetWidth + densityAdjustment.dx).clamp(
      _trackWidth,
      double.infinity,
    );
    final targetHeight = (baseTargetHeight + densityAdjustment.dy).clamp(
      _trackHeight,
      double.infinity,
    );

    return Focus(
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      canRequestFocus: widget.isEnabled,
      skipTraversal: !widget.isEnabled,
      onKeyEvent: _handleKeyEvent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          final maxH = constraints.maxHeight;

          final resolvedWidth = maxW.isFinite
              ? targetWidth.clamp(0.0, maxW)
              : targetWidth;
          final resolvedHeight = maxH.isFinite
              ? targetHeight.clamp(0.0, maxH)
              : targetHeight;

          Widget switchBox = AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            width: resolvedWidth,
            height: resolvedHeight,
            decoration: BoxDecoration(
              border: focusBorder != null
                  ? Border.fromBorderSide(focusBorder)
                  : Border.all(
                      color: Colors.transparent,
                      width: focusBorderWidth,
                    ),
            ),
            child: Center(
              child: FittedBox(fit: BoxFit.scaleDown, child: visualTrack),
            ),
          );

          return Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: MouseRegion(
              cursor: widget.isEnabled
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              onEnter: (_) {
                if (widget.isEnabled) setState(() => _isHovered = true);
              },
              onExit: (_) {
                if (widget.isEnabled) setState(() => _isHovered = false);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _handleTap,
                onTapDown: (_) {
                  if (widget.isEnabled) setState(() => _isPressed = true);
                },
                onTapUp: (_) {
                  if (widget.isEnabled) setState(() => _isPressed = false);
                },
                onTapCancel: () {
                  if (widget.isEnabled && !_isDragging) {
                    setState(() => _isPressed = false);
                  }
                },
                onHorizontalDragStart: _handleDragStart,
                onHorizontalDragUpdate: _handleDragUpdate,
                onHorizontalDragEnd: _handleDragEnd,
                onHorizontalDragCancel: _handleDragCancel,
                child: switchBox,
              ),
            ),
          );
        },
      ),
    );
  }
}
