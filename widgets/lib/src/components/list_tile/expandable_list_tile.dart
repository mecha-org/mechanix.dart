import 'package:flutter/material.dart';

import 'list_tile.dart';

/// A circular accordion toggle button displaying an animated chevron or custom icon widgets.
///
/// Corresponds to `Type="Accordion button"` in the Mechanix design specifications.
class MechanixAccordionButton extends StatelessWidget {
  const MechanixAccordionButton({
    super.key,
    required this.isExpanded,
    this.onTap,
    this.icon,
    this.expandedIcon,
    this.size = 32.0,
    this.iconSize = 20.0,
    this.backgroundColor,
    this.iconColor,
  });

  /// Whether the accordion is currently in the expanded state.
  final bool isExpanded;

  /// Callback when tapped.
  final VoidCallback? onTap;

  /// Custom icon or widget displayed inside the button when collapsed.
  final Widget? icon;

  /// Custom icon or widget displayed inside the button when expanded.
  final Widget? expandedIcon;

  /// Diameter of the circular button container. Defaults to 32.0.
  final double size;

  /// Size of the icon. Defaults to 20.0.
  final double iconSize;

  /// Button circle background color.
  final Color? backgroundColor;

  /// Icon color.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedBg =
        backgroundColor ??
        (isExpanded
            ? colorScheme.surfaceContainer
            : colorScheme.surfaceContainerHighest);
    final resolvedIconColor = iconColor ?? colorScheme.onSurfaceVariant;

    final Widget iconWidget;
    if (expandedIcon != null) {
      final activeChild = isExpanded
          ? expandedIcon!
          : (icon ??
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: iconSize,
                  color: resolvedIconColor,
                ));

      iconWidget = AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: const Cubic(0.2, 0.0, 0.0, 1.0),
        switchOutCurve: const Cubic(0.2, 0.0, 0.0, 1.0),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.25, end: 0.0).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<bool>(isExpanded),
          child: IconTheme(
            data: IconThemeData(size: iconSize, color: resolvedIconColor),
            child: activeChild,
          ),
        ),
      );
    } else {
      final baseChild =
          icon ??
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: iconSize,
            color: resolvedIconColor,
          );

      iconWidget = AnimatedRotation(
        turns: isExpanded ? 0.5 : 0.0,
        duration: const Duration(milliseconds: 250),
        curve: const Cubic(0.2, 0.0, 0.0, 1.0),
        child: IconTheme(
          data: IconThemeData(size: iconSize, color: resolvedIconColor),
          child: baseChild,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: const Cubic(0.2, 0.0, 0.0, 1.0),
        width: size,
        height: size,
        decoration: BoxDecoration(color: resolvedBg, shape: BoxShape.circle),
        child: Center(child: iconWidget),
      ),
    );
  }
}

/// Signature for building a custom accordion button with access to expansion state and toggle callback.
typedef AccordionButtonBuilder = Widget Function(
  BuildContext context,
  bool isExpanded,
  VoidCallback toggleExpansion,
);

/// An expandable List Tile that animates open to reveal child content,
/// controlled by an Accordion button.
class MechanixExpandableListTile extends StatefulWidget {
  const MechanixExpandableListTile({
    super.key,
    this.variant = ListTileVariant.standard,
    this.labelText,
    this.label,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.leading,
    this.showLeading = true,
    this.trailingText,
    this.showAccordionButton = true,
    this.accordionIcon,
    this.accordionExpandedIcon,
    this.accordionButtonBuilder,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.child,
    this.headerTapExpands = true,
    this.enabled = true,
    this.minHeight = 52.0,
    this.height,
    this.gap = 8.0,
    this.expandedContentGap = 2.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.childrenPadding,
    this.duration = const Duration(milliseconds: 250),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.theme,
    this.overlineLabelGap = 4.0,
    this.labelSupportingGap = 4.0,
  });

  /// Factory constructor for a Segmented Filled [MechanixExpandableListTile].
  const MechanixExpandableListTile.segmented({
    super.key,
    this.labelText,
    this.label,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.leading,
    this.showLeading = true,
    this.trailingText,
    this.showAccordionButton = true,
    this.accordionIcon,
    this.accordionExpandedIcon,
    this.accordionButtonBuilder,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.child,
    this.headerTapExpands = true,
    this.enabled = true,
    this.minHeight = 52.0,
    this.height,
    this.gap = 8.0,
    this.expandedContentGap = 2.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.childrenPadding,
    this.duration = const Duration(milliseconds: 250),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.theme,
    this.overlineLabelGap = 4.0,
    this.labelSupportingGap = 4.0,
  }) : variant = ListTileVariant.segmented;

  /// Visual styling variant.
  final ListTileVariant variant;

  /// Primary label text.
  final String? labelText;

  /// Custom widget for primary label.
  final Widget? label;

  /// Overline text.
  final String? overline;

  /// Whether to show the overline text.
  final bool showOverline;

  /// Supporting text.
  final String? supportingText;

  /// Whether to show the supporting text.
  final bool showSupportingText;

  /// Leading element widget (e.g. icon).
  final Widget? leading;

  /// Whether to show the leading element.
  final bool showLeading;

  /// Trailing shortcut text preceding the accordion button.
  final String? trailingText;

  /// Whether to show the accordion toggle button. Defaults to true.
  final bool showAccordionButton;

  /// Custom collapsed icon (or base icon) for the accordion button.
  final Widget? accordionIcon;

  /// Custom expanded icon for the accordion button (e.g. for `+` / `-` toggle icons).
  final Widget? accordionExpandedIcon;

  /// Builder for a custom accordion button with access to [isExpanded] and [toggleExpansion].
  final AccordionButtonBuilder? accordionButtonBuilder;

  /// Whether the tile is initially expanded.
  final bool initiallyExpanded;

  /// Callback when expansion state changes.
  final ValueChanged<bool>? onExpansionChanged;

  /// Child widgets displayed when expanded.
  final List<Widget> children;

  /// Single child widget displayed when expanded (overrides [children] if non-null).
  final Widget? child;

  /// Whether tapping the header tile toggles expansion. Defaults to true.
  final bool headerTapExpands;

  /// Whether the tile is enabled.
  final bool enabled;

  /// Minimum height of the tile.
  final double minHeight;

  /// Explicit height of the tile.
  final double? height;

  /// Spacing gap between elements.
  final double gap;

  /// Spacing between the header tile and the expanded content.
  final double expandedContentGap;

  /// Internal padding of the header tile.
  final EdgeInsetsGeometry? contentPadding;

  /// Border radius of the tile.
  final BorderRadius? borderRadius;

  /// Header background color override when collapsed.
  final Color? backgroundColor;

  /// Background color override when expanded.
  final Color? expandedBackgroundColor;

  /// Padding applied to the expanded children container.
  final EdgeInsetsGeometry? childrenPadding;

  /// Expansion animation duration.
  final Duration duration;

  /// Expansion animation curve.
  final Curve curve;

  /// Theme override.
  final ListTileThemeDataConfig? theme;

  /// Vertical spacing between the overline and label.
  final double overlineLabelGap;

  /// Vertical spacing between the label and supporting text.
  final double labelSupportingGap;

  @override
  State<MechanixExpandableListTile> createState() =>
      _MechanixExpandableListTileState();
}

class _MechanixExpandableListTileState extends State<MechanixExpandableListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: widget.curve));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MechanixExpandableListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    if (!widget.enabled) return;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    // Resolve header background color when expanded
    Color? headerBg = widget.backgroundColor;
    if (_isExpanded) {
      headerBg =
          widget.expandedBackgroundColor ??
          widget.backgroundColor ??
          (widget.variant == ListTileVariant.segmented
              ? colorScheme.surfaceContainerHigh
              : colorScheme.surfaceContainer);
    }

    Widget? accordionButton;
    if (widget.showAccordionButton) {
      if (widget.accordionButtonBuilder != null) {
        accordionButton = widget.accordionButtonBuilder!(
          context,
          _isExpanded,
          _toggleExpansion,
        );
      } else {
        accordionButton = MechanixAccordionButton(
          isExpanded: _isExpanded,
          icon: widget.accordionIcon,
          expandedIcon: widget.accordionExpandedIcon,
          onTap: _toggleExpansion,
        );
      }
    }

    final header = MechanixListTile(
      variant: widget.variant,
      labelText: widget.labelText,
      label: widget.label,
      overline: widget.overline,
      showOverline: widget.showOverline,
      supportingText: widget.supportingText,
      showSupportingText: widget.showSupportingText,
      leading: widget.leading,
      showLeading: widget.showLeading,
      trailingText: widget.trailingText,
      trailingWidgets: accordionButton != null ? [accordionButton] : const [],
      showTrailing: true,
      enabled: widget.enabled,
      minHeight: widget.minHeight,
      height: widget.height,
      gap: widget.gap,
      contentPadding: widget.contentPadding,
      borderRadius: widget.borderRadius,
      backgroundColor: headerBg,
      onTap: widget.headerTapExpands ? _toggleExpansion : null,
      theme: widget.theme,
      overlineLabelGap: widget.overlineLabelGap,
      labelSupportingGap: widget.labelSupportingGap,
    );

    final expandedContent =
        widget.child ??
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widget.children,
        );

    final animatedExpandedContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: widget.expandedContentGap),
        Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: expandedContent,
        ),
      ],
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                heightFactor: _heightFactor.value,
                child: child,
              ),
            ),
          ],
        );
      },
      child: animatedExpandedContent,
    );
  }
}
