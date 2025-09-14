import 'package:flutter/material.dart';
import 'package:widgets/extensions/icon_size.dart';
import 'mechanix_menu_item_theme.dart';

enum MenuItemLayout {
  iconLeft,
  iconRight,
  bothSides,
  checkLeft,
  checkRight,
}

class MechanixMenuItem extends StatefulWidget {
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final String label;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final MenuItemLayout layout;

  final bool? checkValue; // controlled externally
  final ValueChanged<bool>? onCheckChanged;
  final bool selectable; // Whether this item supports selection
  final bool isRadio; // true for single-select, false for multi-select
  final EdgeInsetsGeometry? itemPadding;

  const MechanixMenuItem({
    super.key,
    required this.label,
    this.onTap,
    this.leadingWidget,
    this.trailingWidget,
    this.textStyle,
    this.layout = MenuItemLayout.iconLeft,
    this.checkValue,
    this.onCheckChanged,
    this.selectable = false,
    this.isRadio = false,
    this.itemPadding,
  });

  @override
  State<MechanixMenuItem> createState() => _MechanixMenuItemState();
}

class _MechanixMenuItemState extends State<MechanixMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = MechanixMenuItemTheme.of(context);

    final resolvedPadding = widget.itemPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    final resolvedTextStyle = widget.textStyle ??
        theme.textStyle ??
        Theme.of(context).textTheme.bodyMedium;

    final resolvedIconColor =
        theme.iconColor?.resolve({}) ?? Theme.of(context).colorScheme.onSurface;

    final resolvedCheckColor =
        theme.checkColor?.resolve({}) ?? Theme.of(context).colorScheme.primary;
    final resolvedUncheckColor = theme.uncheckColor?.resolve({}) ??
        Theme.of(context).colorScheme.onSurface.withOpacity(0.6);

    final baseColor = Colors.transparent;
    final hoverColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.1);

    final labelWidget = Text(widget.label, style: resolvedTextStyle);

    final checkWidget = Icon(
      widget.checkValue == true
          ? (widget.isRadio ? Icons.radio_button_checked : Icons.check_box)
          : (widget.isRadio
              ? Icons.radio_button_unchecked
              : Icons.check_box_outline_blank),
      size: IconSize.xl,
      color:
          widget.checkValue == true ? resolvedCheckColor : resolvedUncheckColor,
    );

    List<Widget> children;

    switch (widget.layout) {
      case MenuItemLayout.iconLeft:
        children = [
          if (widget.leadingWidget != null)
            IconTheme(
              data: IconThemeData(color: resolvedIconColor, size: IconSize.xl),
              child: widget.leadingWidget!,
            ),
          if (widget.leadingWidget != null) const SizedBox(width: 12),
          Expanded(child: labelWidget),
        ];
        break;
      case MenuItemLayout.iconRight:
        children = [
          Expanded(child: labelWidget),
          if (widget.trailingWidget != null) ...[
            const SizedBox(width: 12),
            IconTheme(
              data: IconThemeData(color: resolvedIconColor, size: IconSize.xl),
              child: widget.trailingWidget!,
            ),
          ],
        ];
        break;
      case MenuItemLayout.bothSides:
        children = [
          if (widget.leadingWidget != null) ...[
            IconTheme(
              data: IconThemeData(color: resolvedIconColor, size: IconSize.xl),
              child: widget.leadingWidget!,
            ),
            const SizedBox(width: 12),
          ] else if (widget.selectable && widget.onCheckChanged != null) ...[
            GestureDetector(
              onTap: toggleCheck,

              // onTap: () =>
              //     widget.onCheckChanged!(!(widget.checkValue ?? false)),
              child: checkWidget,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(child: labelWidget),
          if (widget.trailingWidget != null) ...[
            const SizedBox(width: 12),
            IconTheme(
              data: IconThemeData(color: resolvedIconColor, size: IconSize.xl),
              child: widget.trailingWidget!,
            ),
          ],
        ];
        break;

      case MenuItemLayout.checkLeft:
        children = [
          if (widget.selectable && widget.onCheckChanged != null)
            GestureDetector(
              onTap: () =>
                  widget.onCheckChanged!(!(widget.checkValue ?? false)),
              child: checkWidget,
            ),
          const SizedBox(width: 12),
          Expanded(child: labelWidget),
          if (widget.trailingWidget != null) ...[
            const SizedBox(width: 12),
            widget.trailingWidget!,
          ],
        ];
        break;
      case MenuItemLayout.checkRight:
        children = [
          Expanded(child: labelWidget),
          const SizedBox(width: 12),
          if (widget.selectable && widget.onCheckChanged != null)
            GestureDetector(
              onTap: () =>
                  widget.onCheckChanged!(!(widget.checkValue ?? false)),
              child: checkWidget,
            ),
        ];
        break;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        color: _isHovered ? hoverColor : baseColor,
        child: InkWell(
          onTap: () {
            widget.onTap?.call();
            toggleCheck();
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: resolvedPadding,
            child: Row(children: children),
          ),
        ),
      ),
    );
  }

  void toggleCheck() {
    if (widget.selectable && widget.onCheckChanged != null) {
      widget.onCheckChanged!(!(widget.checkValue ?? false));
    }
  }
}
