import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A Material 3 Checkbox component following the Mechanix design system.
///
/// Wraps Flutter's native [Checkbox] and provides consistent design system
/// styling, colors, borders, and state transitions according to the Mechanix
/// specifications.
class MechanixCheckbox extends StatefulWidget {
  /// Creates a [MechanixCheckbox].
  const MechanixCheckbox({
    super.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
    this.showFocusIndicator = true,
    this.focusRingColor,
    this.focusRingWidth,
    this.focusRingRadius,
    this.label,
    this.labelText,
    this.labelStyle,
    this.labelSpacing,
    this.theme,
  }) : assert(tristate || value != null),
       assert(
         semanticLabel == null || (label == null && labelText == null),
         'semanticLabel must not be provided when a visible label or labelText is present. '
         'MergeSemantics already combines and announces the visible label.',
       );

  /// Creates a [MechanixCheckbox] with an associated label.
  const MechanixCheckbox.labeled({
    super.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.labelText,
    this.label,
    this.labelStyle,
    this.labelSpacing,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
    this.showFocusIndicator = true,
    this.focusRingColor,
    this.focusRingWidth,
    this.focusRingRadius,
    this.theme,
  }) : assert(tristate || value != null),
       assert(
         labelText != null || label != null,
         'Either labelText or label must be provided when using MechanixCheckbox.labeled.',
       ),
       assert(
         semanticLabel == null,
         'Do not provide semanticLabel when using MechanixCheckbox.labeled. '
         'The label/labelText already provides the accessibility label.',
       );

  /// Whether this checkbox is checked.
  final bool? value;

  /// If true, [value] can be true, false, or null (indeterminate).
  final bool tristate;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?>? onChanged;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  final MouseCursor? mouseCursor;

  /// The color to use when this checkbox is checked.
  final Color? activeColor;

  /// The color that fills the checkbox container.
  final WidgetStateProperty<Color?>? fillColor;

  /// The color to use for the check icon when this checkbox is checked.
  final Color? checkColor;

  /// The color for the checkbox's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the checkbox's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// The color for the checkbox's [Material].
  final WidgetStateProperty<Color?>? overlayColor;

  /// The splash radius of the native checkbox.
  final double? splashRadius;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Defines how compact the checkbox's layout will be.
  final VisualDensity? visualDensity;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other
  /// node in its scope is currently focused.
  final bool autofocus;

  /// The shape of the checkbox's [Material].
  final OutlinedBorder? shape;

  /// The color and width of the checkbox's border.
  final BorderSide? side;

  /// True if this checkbox wants to show an error state.
  final bool isError;

  /// The semantic label for the checkbox that will be announced by screen readers.
  final String? semanticLabel;

  /// Whether to show the Mechanix circular focus indicator ring when focused.
  final bool showFocusIndicator;

  /// The color of the focus indicator ring.
  final Color? focusRingColor;

  /// The line width of the focus indicator ring.
  final double? focusRingWidth;

  /// The radius of the focus indicator ring.
  final double? focusRingRadius;

  /// An optional custom widget label placed next to the checkbox.
  final Widget? label;

  /// An optional string label placed next to the checkbox.
  final String? labelText;

  /// The text style applied to [labelText].
  final TextStyle? labelStyle;

  /// The horizontal spacing between the checkbox and the label.
  final double? labelSpacing;

  /// Custom theme override for this checkbox instance.
  final CheckboxThemeDataConfig? theme;

  /// Whether the checkbox is interactive.
  bool get isEnabled => onChanged != null;

  @override
  State<MechanixCheckbox> createState() => _MechanixCheckboxState();
}

class _MechanixCheckboxState extends State<MechanixCheckbox> {
  FocusNode? _internalFocusNode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncFocusNode();
  }

  @override
  void didUpdateWidget(MechanixCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode ||
        widget.showFocusIndicator != oldWidget.showFocusIndicator ||
        widget.theme != oldWidget.theme) {
      _syncFocusNode();
    }
  }

  void _syncFocusNode() {
    final config = MechanixCheckboxTheme.of(context).merge(widget.theme);
    final showRing =
        widget.showFocusIndicator && (config.showFocusIndicator ?? true);

    if (widget.focusNode == null && showRing) {
      _internalFocusNode ??= FocusNode(debugLabel: 'MechanixCheckbox');
    } else if (_internalFocusNode != null) {
      _internalFocusNode!.dispose();
      _internalFocusNode = null;
    }
  }

  @override
  void dispose() {
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleLabelTap() {
    if (widget.onChanged == null) return;
    if (widget.tristate) {
      final nextValue = switch (widget.value) {
        false => true,
        true => widget.tristate ? null : false,
        null => false,
      };
      widget.onChanged!(nextValue);
    } else {
      widget.onChanged!(!(widget.value ?? false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MechanixTheme.maybeOf(context);
    final colorScheme = theme?.colorScheme ?? Theme.of(context).colorScheme;
    final textTheme = theme?.textTheme ?? Theme.of(context).textTheme;

    final config = MechanixCheckboxTheme.of(context).merge(widget.theme);

    final ringColor =
        widget.focusRingColor ?? config.focusRingColor ?? colorScheme.outline;
    final ringWidth = widget.focusRingWidth ?? config.focusRingWidth ?? 2.0;
    final ringRadius = widget.focusRingRadius ?? config.focusRingRadius ?? 24.0;
    final showRing =
        widget.showFocusIndicator && (config.showFocusIndicator ?? true);

    final effectiveFocusNode = widget.focusNode ?? _internalFocusNode;

    Widget checkbox = Checkbox(
      value: widget.value,
      tristate: widget.tristate,
      onChanged: widget.onChanged,
      mouseCursor: widget.mouseCursor,
      activeColor: widget.activeColor,
      fillColor: widget.fillColor,
      checkColor: widget.checkColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      overlayColor: widget.overlayColor,
      splashRadius: widget.splashRadius,
      materialTapTargetSize: widget.materialTapTargetSize,
      visualDensity: widget.visualDensity,
      focusNode: effectiveFocusNode,
      autofocus: widget.autofocus,
      shape: widget.shape,
      side: widget.side,
      isError: widget.isError,
      semanticLabel: widget.semanticLabel,
    );

    if (showRing) {
      final ringDimension = (ringRadius + ringWidth / 2) * 2;
      checkbox = SizedBox(
        width: ringDimension,
        height: ringDimension,
        child: effectiveFocusNode != null
            ? ListenableBuilder(
                listenable: effectiveFocusNode,
                builder: (context, child) {
                  if (!effectiveFocusNode.hasFocus) return child!;
                  return MechanixFocusRing(
                    color: ringColor,
                    strokeWidth: ringWidth,
                    radius: ringRadius,
                    child: child!,
                  );
                },
                child: Center(child: checkbox),
              )
            : Center(child: checkbox),
      );
    }

    if (widget.label == null && widget.labelText == null) {
      return checkbox;
    }

    final spacing = widget.labelSpacing ?? config.labelSpacing ?? 8.0;

    final TextStyle defaultLabelStyle =
        (config.labelStyle ?? textTheme.bodyMedium ?? const TextStyle())
            .copyWith(
              color: widget.isEnabled
                  ? (widget.isError ? colorScheme.error : colorScheme.onSurface)
                  : colorScheme.onSurface.withValues(alpha: 0.38),
            );

    final resolvedLabelStyle = widget.labelStyle != null
        ? defaultLabelStyle.merge(widget.labelStyle)
        : defaultLabelStyle;

    final labelWidget =
        widget.label ?? Text(widget.labelText!, style: resolvedLabelStyle);

    return MergeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkbox,
          Flexible(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: widget.isEnabled ? _handleLabelTap : null,
              child: Padding(
                padding: EdgeInsets.only(left: spacing),
                child: labelWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Circular outline focus indicator for Mechanix components.
class MechanixFocusRing extends StatelessWidget {
  const MechanixFocusRing({
    super.key,
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.child,
  });

  /// Creates a [MechanixFocusRing] with an explicit [diameter].
  const MechanixFocusRing.fromDiameter({
    super.key,
    required this.color,
    required this.strokeWidth,
    required double diameter,
    required this.child,
  }) : radius = diameter / 2;

  final Color color;
  final double strokeWidth;
  final double radius;
  final Widget child;

  /// The diameter of the focus ring.
  double get diameter => radius * 2;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _FocusRingPainter(
        color: color,
        strokeWidth: strokeWidth,
        radius: radius,
      ),
      child: child,
    );
  }
}

/// Custom painter for drawing the circular outer focus indicator ring.
class _FocusRingPainter extends CustomPainter {
  const _FocusRingPainter({
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

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _FocusRingPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        radius != oldDelegate.radius;
  }
}
