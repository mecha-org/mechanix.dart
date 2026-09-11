import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A Material 3 Radio component following the Mechanix design system.
///
/// Wraps Flutter's native [Radio] and provides consistent design system
/// styling, colors, borders, and state transitions according to the Mechanix
/// specifications.
///
/// Can be used either by providing [groupValue] and [onChanged] directly, or
/// by wrapping multiple [MechanixRadio] widgets in Flutter's native [RadioGroup].
class MechanixRadio<T> extends StatefulWidget {
  /// Creates a [MechanixRadio].
  const MechanixRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.side,
    this.innerRadius,
    this.backgroundColor,
    this.groupRegistry,
    this.isError = false,
    this.semanticLabel,
    this.label,
    this.labelText,
    this.labelStyle,
    this.labelSpacing,
    this.theme,
  }) : assert(
         semanticLabel == null || (label == null && labelText == null),
         'semanticLabel must not be provided when a visible label or labelText is present. '
         'MergeSemantics already combines and announces the visible label.',
       );

  /// Creates a [MechanixRadio] with an associated label.
  const MechanixRadio.labeled({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.labelText,
    this.label,
    this.labelStyle,
    this.labelSpacing,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.side,
    this.innerRadius,
    this.backgroundColor,
    this.groupRegistry,
    this.isError = false,
    this.semanticLabel,
    this.theme,
  }) : assert(
         labelText != null || label != null,
         'Either labelText or label must be provided when using MechanixRadio.labeled.',
       ),
       assert(
         semanticLabel == null,
         'Do not provide semanticLabel when using MechanixRadio.labeled. '
         'The label/labelText already provides the accessibility label.',
       );

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  ///
  /// Can be omitted when this radio is placed inside a [RadioGroup] ancestor.
  final T? groupValue;

  /// Called when the user selects this radio button.
  ///
  /// Can be omitted when this radio is placed inside a [RadioGroup] ancestor.
  final ValueChanged<T?>? onChanged;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  final MouseCursor? mouseCursor;

  /// Set to true if this radio button is allowed to be returned to an
  /// indeterminate state by selecting it again when selected.
  final bool toggleable;

  /// The color to use when this radio button is selected.
  final Color? activeColor;

  /// The color that fills the radio button.
  final WidgetStateProperty<Color?>? fillColor;

  /// The color for the radio's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the radio's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// The color for the radio's [Material].
  final WidgetStateProperty<Color?>? overlayColor;

  /// The splash radius of the native radio.
  final double? splashRadius;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Defines how compact the radio's layout will be.
  final VisualDensity? visualDensity;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other
  /// node in its scope is currently focused.
  final bool autofocus;

  /// Whether this radio button is interactive.
  ///
  /// If null, the enabled state is inferred:
  /// * When used standalone, it is enabled if [onChanged] is not null.
  /// * When placed inside a [RadioGroup] ancestor, it is enabled by default.
  ///   To disable an individual radio within a [RadioGroup], explicitly pass
  ///   `enabled: false`.
  final bool? enabled;

  /// The color and width of the radio's outer border.
  final BorderSide? side;

  /// The radius of the inner circle dot when selected.
  final WidgetStateProperty<double?>? innerRadius;

  /// The background color inside the radio's circle.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The registry this radio registers to when used inside a radio group.
  final RadioGroupRegistry<T>? groupRegistry;

  /// True if this radio button wants to show an error state.
  final bool isError;

  /// The semantic label for the radio that will be announced by screen readers.
  final String? semanticLabel;

  /// An optional custom widget label placed next to the radio.
  final Widget? label;

  /// An optional string label placed next to the radio.
  final String? labelText;

  /// The text style applied to [labelText].
  final TextStyle? labelStyle;

  /// The horizontal spacing between the radio and the label.
  final double? labelSpacing;

  /// Custom theme override for this radio instance.
  final RadioThemeDataConfig? theme;

  @override
  State<MechanixRadio<T>> createState() => _MechanixRadioState<T>();
}

class _MechanixRadioState<T> extends State<MechanixRadio<T>> {
  FocusNode? _internalFocusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  @override
  void dispose() {
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleLabelTap(
    ValueChanged<T?>? effectiveOnChanged,
    T? effectiveGroupValue,
  ) {
    if (effectiveOnChanged == null) return;
    _effectiveFocusNode.requestFocus();

    if (widget.toggleable && effectiveGroupValue == widget.value) {
      effectiveOnChanged(null);
    } else {
      effectiveOnChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mechanixTheme = MechanixTheme.maybeOf(context);
    final colorScheme =
        mechanixTheme?.colorScheme ?? Theme.of(context).colorScheme;
    final textTheme = mechanixTheme?.textTheme ?? Theme.of(context).textTheme;

    final config = MechanixRadioTheme.of(context).merge(widget.theme);

    // Support both direct groupValue/onChanged and ancestor RadioGroup
    final radioGroup = RadioGroup.maybeOf<T>(context);
    final isInteractive =
        widget.enabled ?? (widget.onChanged != null || radioGroup != null);
    final effectiveGroupValue = widget.groupValue ?? radioGroup?.groupValue;
    final effectiveOnChanged = isInteractive
        ? (widget.onChanged ?? radioGroup?.onChanged)
        : null;
    final isEnabled = isInteractive;

    // Resolve error color if isError is true and no explicit fillColor is set
    final effectiveFillColor =
        widget.fillColor ??
        (widget.isError
            ? WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return colorScheme.onSurface.withValues(alpha: 0.38);
                }
                return colorScheme.error;
              })
            : null);

    final effectiveSemanticLabel =
        (widget.label == null && widget.labelText == null)
            ? widget.semanticLabel
            : null;

    Widget radio = Radio<T>(
      value: widget.value,
      mouseCursor: widget.mouseCursor,
      toggleable: widget.toggleable,
      activeColor: widget.activeColor,
      fillColor: effectiveFillColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      overlayColor: widget.overlayColor,
      splashRadius: widget.splashRadius,
      materialTapTargetSize: widget.materialTapTargetSize,
      visualDensity: widget.visualDensity,
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      enabled: isEnabled,
      side: widget.side,
      innerRadius: widget.innerRadius,
      backgroundColor: widget.backgroundColor,
      groupRegistry: widget.groupRegistry,
    );

    Widget content;

    if (widget.label == null && widget.labelText == null) {
      content = effectiveSemanticLabel != null
          ? Semantics(label: effectiveSemanticLabel, child: radio)
          : radio;
    } else {
      final spacing = widget.labelSpacing ?? config.labelSpacing ?? 8.0;

      final TextStyle defaultLabelStyle =
          (config.labelStyle ?? textTheme.bodyMedium ?? const TextStyle())
              .copyWith(
                color: isEnabled
                    ? (widget.isError
                        ? colorScheme.error
                        : colorScheme.onSurface)
                    : colorScheme.onSurface.withValues(alpha: 0.38),
              );

      final resolvedLabelStyle = widget.labelStyle != null
          ? defaultLabelStyle.merge(widget.labelStyle)
          : defaultLabelStyle;

      final labelWidget = widget.label != null
          ? DefaultTextStyle(style: resolvedLabelStyle, child: widget.label!)
          : Text(widget.labelText!, style: resolvedLabelStyle);

      content = MergeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            radio,
            Flexible(
              child: MouseRegion(
                cursor: isEnabled
                    ? (widget.mouseCursor ?? SystemMouseCursors.click)
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  excludeFromSemantics: true,
                  onTap: isEnabled
                      ? () => _handleLabelTap(
                          effectiveOnChanged,
                          effectiveGroupValue,
                        )
                      : null,
                  child: Padding(
                    padding: EdgeInsets.only(left: spacing),
                    child: labelWidget,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If local parameters (groupValue or onChanged) are provided, or if there is no
    // ancestor RadioGroup, wrap in a local RadioGroup.
    // This shadows any ancestor RadioGroup and ensures both the native circle and the
    // label are bound to the exact same source of truth without deprecated APIs.
    final hasLocalGroup = widget.groupValue != null || widget.onChanged != null;
    if (hasLocalGroup || radioGroup == null) {
      if (effectiveGroupValue != null || effectiveOnChanged != null) {
        content = RadioGroup<T>(
          groupValue: effectiveGroupValue,
          onChanged: effectiveOnChanged ?? (_) {},
          child: content,
        );
      }
    }

    return content;
  }
}
