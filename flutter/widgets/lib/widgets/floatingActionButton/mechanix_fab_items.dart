import 'package:flutter/material.dart';
import 'mechanix_fab_item_theme.dart';

class MechanixFabItem {
  final Widget? iconWidget;
  final String? label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final TextStyle? labelTextStyle;
  final LayerLink? anchorLink;
  final double? iconSize;

  const MechanixFabItem(
      {required this.iconWidget,
      this.label,
      this.onTap,
      this.backgroundColor,
      this.labelTextStyle,
      this.anchorLink,
      this.iconSize});

  // Modified to accept icon size
  Widget build(BuildContext context, double computedIconSize) {
    final itemTheme = MechanixFabItemTheme.of(context);
    final resolvedIconSize = iconSize ?? itemTheme.iconSize ?? computedIconSize;

    return anchorLink != null
        ? CompositedTransformTarget(
            link: anchorLink!,
            child: _buildButton(context, resolvedIconSize),
          )
        : _buildButton(context, resolvedIconSize);
  }

  Widget _buildButton(BuildContext context, double computedIconSize) {
    final itemTheme = MechanixFabItemTheme.of(context);

    final resolvedIconSize = iconSize ?? itemTheme.iconSize ?? computedIconSize;

    return IconButton(
      tooltip: label,
      icon: iconWidget ?? const Icon(Icons.help_outline),
      iconSize: resolvedIconSize,
      onPressed: onTap,
    );
  }
}

/// A custom FAB menu with multiple items.
class MechanixFabMenu extends StatelessWidget {
  const MechanixFabMenu({
    super.key,
    required this.items,
    this.mainIcon = Icons.add,
    this.mainBackgroundColor = Colors.blue,
    this.mainIconColor = Colors.white,
  });

  final List<MechanixFabItem> items;
  final IconData mainIcon;
  final Color mainBackgroundColor;
  final Color mainIconColor;

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      mainIcon: mainIcon,
      mainBackgroundColor: mainBackgroundColor,
      mainIconColor: mainIconColor,
      items: items,
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    required this.items,
    required this.mainIcon,
    required this.mainBackgroundColor,
    required this.mainIconColor,
  });

  final List<MechanixFabItem> items;
  final IconData mainIcon;
  final Color mainBackgroundColor;
  final Color mainIconColor;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final itemTheme = MechanixFabItemTheme.of(context);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_expanded)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.items.map((item) {
              final resolvedBackground = item.backgroundColor ??
                  itemTheme.backgroundColor?.resolve({}) ??
                  Theme.of(context).primaryColor;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: FloatingActionButton.extended(
                  heroTag: null,
                  backgroundColor: resolvedBackground,
                  onPressed: item.onTap,
                  icon: item.iconWidget,
                  label: Text(
                    item.label ?? '',
                  ),
                ),
              );
            }).toList(),
          ),
        FloatingActionButton(
          backgroundColor: widget.mainBackgroundColor,
          onPressed: () {
            setState(() => _expanded = !_expanded);
          },
          child: Icon(
            _expanded ? Icons.close : widget.mainIcon,
            color: widget.mainIconColor,
          ),
        ),
      ],
    );
  }
}
