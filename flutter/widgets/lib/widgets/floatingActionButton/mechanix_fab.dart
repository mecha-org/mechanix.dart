import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';
import 'package:widgets/extension.dart';
import 'mechanix_fab_items.dart';
import 'mechanix_fab_theme.dart';

class MechanixFloatingActionMenu extends StatelessWidget {
  const MechanixFloatingActionMenu({
    super.key,
    required this.items,
    this.backgroundColor,
    this.borderRadius,
    this.height,
    this.shadowColor,
    this.onCancel,
  });

  final List<MechanixFabItem> items;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? height;
  final Color? shadowColor;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fabTheme = MechanixFabTheme.of(context);

    final resolvedBackgroundColor = backgroundColor ??
        fabTheme.backgroundColor?.resolve({}) ??
        theme.colorScheme.surface;

    final resolvedShadowColor =
        shadowColor ?? fabTheme.shadowColor?.resolve({}) ?? Colors.black26;

    final resolvedBorderRadius = borderRadius != null
        ? BorderRadius.circular(borderRadius!)
        : (fabTheme.borderRadius != null
            ? BorderRadius.circular(fabTheme.borderRadius!)
            : CircularRadius.circle);

    final resolvedHeight = height ?? fabTheme.size ?? 56;

    // Compute icon size as a proportion of container height
    final double minSize = 16.0;
    final double maxSize = resolvedHeight * 0.6;

    final resolvedIconSize = (resolvedHeight * 0.5)
        .clamp(minSize, maxSize >= minSize ? maxSize : minSize);

    return Container(
      height: resolvedHeight,
      decoration: BoxDecoration(
        color: resolvedBackgroundColor,
        borderRadius: resolvedBorderRadius,
        boxShadow: [
          BoxShadow(
            color: resolvedShadowColor,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return item.build(context, resolvedIconSize);
        }).toList(),
      ),
    ).padHorizontal(mechanixPaddingXl);
  }
}
