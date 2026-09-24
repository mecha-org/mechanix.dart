import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/src/extensions/shape_extension.dart';

import 'floating_action_button_enums.dart';
import 'floating_action_button_size.dart';
import 'floating_action_button_style.dart';
import 'floating_action_button_theme.dart';

export 'floating_action_button_enums.dart';
export 'floating_action_button_size.dart';
export 'floating_action_button_style.dart';
export 'floating_action_button_theme.dart';

class MechanixFloatingActionButton extends StatefulWidget {
  /// Creates a [MechanixFloatingActionButton].
  const MechanixFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = MechanixFloatingActionButtonSize.small,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.elevation,
    this.theme,
  });

  /// Factory constructor for a Medium [MechanixFloatingActionButton] (80x80 px).
  const MechanixFloatingActionButton.medium({
    super.key,
    required this.onPressed,
    required this.icon,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.elevation,
    this.theme,
  }) : size = MechanixFloatingActionButtonSize.medium;

  /// Factory constructor for a Large [MechanixFloatingActionButton] (96x96 px).
  const MechanixFloatingActionButton.large({
    super.key,
    required this.onPressed,
    required this.icon,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.elevation,
    this.theme,
  }) : size = MechanixFloatingActionButtonSize.large;

  /// Callback when the button is tapped. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Icon widget to display centered in the FAB.
  final Widget icon;

  /// Size variant of the FAB ([MechanixFloatingActionButtonSize.small], [medium], [large]).
  final MechanixFloatingActionButtonSize size;

  /// Whether to show the outer focus indicator ring when focused.
  final bool showFocusIndicator;

  /// Optional FocusNode to manage keyboard/accessibility focus.
  final FocusNode? focusNode;

  /// Whether this button should autofocus on initial build.
  final bool autofocus;

  /// Optional tooltip text displayed on long press or hover.
  final String? tooltip;

  /// Optional accessibility semantic label announced by screen readers.
  final String? semanticLabel;

  /// Animation duration for state transitions (hover, press, exit).
  final Duration duration;

  /// Animation easing curve for state transitions.
  final Curve curve;

  /// Background color override.
  final Color? backgroundColor;

  /// Hover background color override.
  final Color? hoverColor;

  /// Pressed background color override.
  final Color? pressedColor;

  /// Disabled background color override.
  final Color? disabledColor;

  /// Foreground / icon color override.
  final Color? foregroundColor;

  /// Hover foreground / icon color override.
  final Color? hoverForegroundColor;

  /// Pressed foreground / icon color override.
  final Color? pressedForegroundColor;

  /// Disabled foreground / icon color override.
  final Color? disabledForegroundColor;

  /// Focus indicator ring color override.
  final Color? focusBorderColor;

  /// Focus indicator ring stroke width override.
  final double? focusBorderWidth;

  /// Elevation override.
  final double? elevation;

  /// Custom theme override.
  final FloatingActionButtonThemeDataConfig? theme;

  /// Whether this button is currently enabled.
  bool get isEnabled => onPressed != null;

  @override
  State<MechanixFloatingActionButton> createState() =>
      _MechanixFloatingActionButtonState();
}

class _MechanixFloatingActionButtonState
    extends State<MechanixFloatingActionButton> {
  FocusNode? _internalFocusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ??
      (_internalFocusNode ??= FocusNode(
        debugLabel: 'MechanixFloatingActionButton',
      ));

  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant MechanixFloatingActionButton oldWidget) {
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
    (widget.focusNode ?? _internalFocusNode)?.removeListener(
      _handleFocusChange,
    );
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_isFocused != _effectiveFocusNode.hasFocus) {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    }
  }

  void _handleTap() {
    if (!widget.isEnabled) return;
    widget.onPressed?.call();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.isEnabled) return KeyEventResult.ignored;
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.space ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        _handleTap();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final mergedTheme = MechanixFloatingActionButtonTheme.of(context)
        .merge(widget.theme);
    final sizeSpec = widget.size.spec(context);

    final states = <WidgetState>{
      if (!widget.isEnabled) WidgetState.disabled,
      if (widget.isEnabled && _isHovered) WidgetState.hovered,
      if (widget.isEnabled && _isPressed) WidgetState.pressed,
      if (widget.isEnabled && _isFocused) WidgetState.focused,
    };

    final resolvedBg = FloatingActionButtonStyleResolver.resolveBackgroundColor(
      context: context,
      states: states,
      theme: mergedTheme,
      customBackgroundColor: widget.backgroundColor,
      customHoverColor: widget.hoverColor,
      customPressedColor: widget.pressedColor,
      customDisabledColor: widget.disabledColor,
    );

    final resolvedFg = FloatingActionButtonStyleResolver.resolveForegroundColor(
      context: context,
      states: states,
      theme: mergedTheme,
      customForegroundColor: widget.foregroundColor,
      customHoverForegroundColor: widget.hoverForegroundColor,
      customPressedForegroundColor: widget.pressedForegroundColor,
      customDisabledForegroundColor: widget.disabledForegroundColor,
    );

    final focusRingColor =
        FloatingActionButtonStyleResolver.resolveFocusBorderColor(
          context: context,
          theme: mergedTheme,
          customFocusBorderColor: widget.focusBorderColor,
        );

    final focusRingWidth =
        FloatingActionButtonStyleResolver.resolveFocusBorderWidth(
          theme: mergedTheme,
          customFocusBorderWidth: widget.focusBorderWidth,
        );

    final targetIconSize = mergedTheme.iconSize ?? sizeSpec.iconSize;

    final shapeTheme = context.shape;
    final borderRadius = mergedTheme.borderRadius ?? shapeTheme.full;

    final iconContent = _buildIcon(resolvedFg, targetIconSize);

    final showRing =
        widget.isEnabled && widget.showFocusIndicator && _isFocused;

    Widget buttonContent = AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      width: sizeSpec.dimension,
      height: sizeSpec.dimension,
      decoration: BoxDecoration(color: resolvedBg, borderRadius: borderRadius),
      child: Center(child: iconContent),
    );

    if (showRing) {
      buttonContent = MechanixFabFocusRing(
        color: focusRingColor,
        strokeWidth: focusRingWidth,
        radius: sizeSpec.dimension / 2,
        child: buttonContent,
      );
    }

    final mouseCursor = widget.isEnabled
        ? SystemMouseCursors.click
        : SystemMouseCursors.basic;

    Widget result = Focus(
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      canRequestFocus: widget.isEnabled,
      skipTraversal: !widget.isEnabled,
      onKeyEvent: _handleKeyEvent,
      child: MouseRegion(
        cursor: mouseCursor,
        onEnter: (_) {
          if (widget.isEnabled && !_isHovered) {
            setState(() => _isHovered = true);
          }
        },
        onExit: (_) {
          if (widget.isEnabled && _isHovered) {
            setState(() => _isHovered = false);
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.isEnabled ? _handleTap : null,
          onTapDown: widget.isEnabled
              ? (_) => setState(() => _isPressed = true)
              : null,
          onTapUp: widget.isEnabled
              ? (_) => setState(() => _isPressed = false)
              : null,
          onTapCancel: () {
            if (widget.isEnabled && _isPressed) {
              setState(() => _isPressed = false);
            }
          },
          child: SizedBox(
            width: sizeSpec.dimension,
            height: sizeSpec.dimension,
            child: buttonContent,
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      result = Tooltip(message: widget.tooltip!, child: result);
    }

    return Semantics(
      button: true,
      enabled: widget.isEnabled,
      label: widget.semanticLabel ?? widget.tooltip,
      tooltip: widget.tooltip,
      child: result,
    );
  }

  Widget _buildIcon(Color color, double size) {
    return IconTheme.merge(
      data: IconThemeData(color: color, size: size),
      child: widget.icon,
    );
  }
}

/// Circular outline focus indicator for [MechanixFloatingActionButton].
class MechanixFabFocusRing extends StatelessWidget {
  const MechanixFabFocusRing({
    super.key,
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.child,
  });

  final Color color;
  final double strokeWidth;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _FabFocusRingPainter(
        color: color,
        strokeWidth: strokeWidth,
        radius: radius,
      ),
      child: child,
    );
  }
}

/// Custom painter for drawing the circular outer focus indicator ring around the FAB.
class _FabFocusRingPainter extends CustomPainter {
  const _FabFocusRingPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    // Draw the focus ring right outside the perimeter of the FAB
    canvas.drawCircle(center, radius + strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _FabFocusRingPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        radius != oldDelegate.radius;
  }
}
