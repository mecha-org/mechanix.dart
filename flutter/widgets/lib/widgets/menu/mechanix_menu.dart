import 'package:flutter/material.dart';
import 'package:widgets/widgets/menu/mechanix_menu_item.dart';
import 'mechanix_menu_theme.dart';

enum MenuSelectionMode {
  single,
  multiple,
  none, // for actions like rename, delete etc.
}

class MechanixMenu extends StatefulWidget {
  const MechanixMenu({
    super.key,
    required this.items,
    this.selectionMode = MenuSelectionMode.none,
    this.selectedItems = const [],
    this.onSelectionChanged,
    this.backgroundColor,
    this.borderRadius,
    this.shadowColor,
    this.itemPadding,
  });

  final List<Widget> items; // Can include any widget (items, dividers, etc.)
  final MenuSelectionMode selectionMode;
  final List<String> selectedItems;
  final ValueChanged<List<String>>? onSelectionChanged;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? shadowColor;
  final EdgeInsetsGeometry? itemPadding;

  @override
  State<MechanixMenu> createState() => _MechanixMenuState();
}

class _MechanixMenuState extends State<MechanixMenu> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  void _onItemTapped(String label, VoidCallback? onTap) {
    setState(() {
      if (widget.selectionMode == MenuSelectionMode.single) {
        _selectedItems = [label];
      } else if (widget.selectionMode == MenuSelectionMode.multiple) {
        if (_selectedItems.contains(label)) {
          _selectedItems.remove(label);
        } else {
          _selectedItems.add(label);
        }
      }
    });

    onTap?.call();
    widget.onSelectionChanged?.call(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menuTheme = MechanixMenuTheme.of(context);

    // Resolve colors and radius from theme, widget override, or fallback
    final bg = widget.backgroundColor ??
        menuTheme.backgroundColor?.resolve({}) ??
        theme.colorScheme.surface;
    final borderRad = BorderRadius.circular(
        widget.borderRadius ?? menuTheme.borderRadius ?? 8);
    final shadow = widget.shadowColor ??
        menuTheme.shadowColor?.resolve({}) ??
        Colors.black26;

    return Material(
      color: Colors.transparent,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: borderRad,
            boxShadow: [
              BoxShadow(
                  color: shadow, blurRadius: 8, offset: const Offset(0, 2))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.items.map((child) {
              // Wrap only MechanixMenuItem for selection logic
              if (child is MechanixMenuItem) {
                final isSelected = _selectedItems.contains(child.label);
                return MechanixMenuItem(
                  itemPadding: widget.itemPadding,
                  key: ValueKey(child.label),
                  label: child.label,
                  leadingWidget: child.leadingWidget,
                  trailingWidget: child.trailingWidget,
                  layout: child.layout,
                  textStyle: child.textStyle,
                  selectable: widget.selectionMode != MenuSelectionMode.none,
                  checkValue: isSelected,
                  isRadio: widget.selectionMode == MenuSelectionMode.single,
                  onTap: () => _onItemTapped(child.label, child.onTap),
                  onCheckChanged: widget.selectionMode != MenuSelectionMode.none
                      ? (val) => _onItemTapped(child.label, child.onTap)
                      : child.onCheckChanged,
                );
              }
              // Leave other widgets as-is (e.g., Divider)
              return child;
            }).toList(),
          ),
        ),
      ),
    );
  }
}
