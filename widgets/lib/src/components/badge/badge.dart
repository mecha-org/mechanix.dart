import 'package:flutter/material.dart';

import 'badge_enums.dart';

class MechanixBadge extends StatelessWidget {
  /// Creates a Mechanix badge.
  ///
  /// If [label] is null, renders a small dot indicator of diameter [smallSize].
  /// Otherwise, renders a large badge of height [largeSize] shaped with a stadium border.
  const MechanixBadge({
    super.key,
    this.variant = MechanixBadgeVariant.error,
    this.backgroundColor,
    this.textColor,
    this.smallSize,
    this.largeSize,
    this.textStyle,
    this.padding,
    this.alignment,
    this.offset,
    this.label,
    this.isLabelVisible = true,
    this.semanticLabel,
    this.child,
  });

  /// Convenience constructor for creating a badge with a numeric count.
  ///
  /// Formats [count] into a label:
  /// - If [count] <= [maxCount], displays the count (e.g. '5').
  /// - Otherwise, displays '[maxCount]+' (e.g. '99+' or '999+').
  MechanixBadge.count({
    super.key,
    required int count,
    int maxCount = 999,
    this.variant = MechanixBadgeVariant.error,
    this.backgroundColor,
    this.textColor,
    this.smallSize,
    this.largeSize,
    this.textStyle,
    this.padding,
    this.alignment,
    this.offset,
    this.isLabelVisible = true,
    this.semanticLabel,
    this.child,
  }) : assert(count >= 0, 'count must be non-negative'),
       assert(maxCount > 0, 'maxCount must be positive'),
       label = Text(count > maxCount ? '$maxCount+' : '$count');

  /// Convenience constructor for a small dot indicator badge without text.
  const MechanixBadge.small({
    super.key,
    this.variant = MechanixBadgeVariant.error,
    this.backgroundColor,
    this.smallSize,
    this.alignment,
    this.offset,
    this.isLabelVisible = true,
    this.semanticLabel,
    this.child,
  }) : label = null,
       textColor = null,
       largeSize = null,
       textStyle = null,
       padding = null;

  /// The semantic color variant of the badge.
  ///
  /// Defaults to [MechanixBadgeVariant.error].
  final MechanixBadgeVariant variant;

  /// The background fill color of the badge.
  ///
  /// If null, resolves from the active [variant] and ambient [BadgeThemeData].
  final Color? backgroundColor;

  /// The color of the badge's [label] text.
  ///
  /// If null, resolves from the active [variant] and ambient [BadgeThemeData].
  final Color? textColor;

  /// The diameter of the badge when [label] is null.
  ///
  /// Defaults to [BadgeThemeData.smallSize] or 6.0.
  final double? smallSize;

  /// The height of the badge when [label] is non-null.
  ///
  /// Defaults to [BadgeThemeData.largeSize] or 16.0.
  final double? largeSize;

  /// The text style for the badge's [label].
  ///
  /// Defaults to [BadgeThemeData.textStyle] or [TextTheme.labelSmall].
  final TextStyle? textStyle;

  /// The padding around the badge's [label].
  ///
  /// Defaults to [BadgeThemeData.padding] or `EdgeInsets.symmetric(horizontal: 4)`.
  final EdgeInsetsGeometry? padding;

  /// Combined with [offset] to position the badge relative to [child].
  ///
  /// Defaults to [BadgeThemeData.alignment] or [AlignmentDirectional.topEnd].
  final AlignmentGeometry? alignment;

  /// The offset added to [alignment] to position the badge relative to [child].
  final Offset? offset;

  /// The badge content, typically a [Text] widget.
  ///
  /// If null, a small dot indicator is displayed.
  final Widget? label;

  /// Whether the badge is visible. Defaults to true.
  final bool isLabelVisible;

  /// Optional accessibility label for screen readers.
  final String? semanticLabel;

  /// The widget that the badge is stacked on top of.
  ///
  /// If null, the badge is rendered as a standalone widget.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Resolve variant color defaults
    final (Color variantBg, Color variantFg) = switch (variant) {
      MechanixBadgeVariant.error => (colorScheme.error, colorScheme.onError),
      MechanixBadgeVariant.primary => (
        colorScheme.primary,
        colorScheme.onPrimary,
      ),
      MechanixBadgeVariant.neutral => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
      ),
      MechanixBadgeVariant.surface => (
        colorScheme.surfaceContainerHigh,
        colorScheme.onSurface,
      ),
    };

    final effectiveBackgroundColor = backgroundColor ?? variantBg;
    final effectiveTextColor = textColor ?? variantFg;

    final effectiveLabel = (label != null && semanticLabel != null)
        ? ExcludeSemantics(child: label)
        : label;

    final badgeWidget = Badge(
      backgroundColor: effectiveBackgroundColor,
      textColor: effectiveTextColor,
      smallSize: smallSize,
      largeSize: largeSize,
      textStyle: textStyle,
      padding: padding,
      alignment: alignment,
      offset: offset,
      label: effectiveLabel,
      isLabelVisible: isLabelVisible,
      child: child,
    );

    if (semanticLabel != null) {
      if (child == null) {
        return Semantics(
          label: semanticLabel,
          container: true,
          child: badgeWidget,
        );
      }
      return Semantics(label: semanticLabel, child: badgeWidget);
    }

    return badgeWidget;
  }
}
