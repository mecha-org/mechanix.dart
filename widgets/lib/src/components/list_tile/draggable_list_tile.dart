import 'package:flutter/material.dart';

import '../../extensions/shape_extension.dart';
import 'list_tile.dart';

/// Scope notifying descendants whether they are currently being dragged in a reorderable list.
class MechanixDragScope extends InheritedWidget {
  const MechanixDragScope({
    super.key,
    required this.isDragging,
    required super.child,
  });

  /// Whether the enclosed child is currently being dragged.
  final bool isDragging;

  /// Retrieves whether the nearest enclosing [MechanixDragScope] is dragging.
  static bool of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<MechanixDragScope>();
    return scope?.isDragging ?? false;
  }

  @override
  bool updateShouldNotify(MechanixDragScope oldWidget) =>
      isDragging != oldWidget.isDragging;
}

/// A proxy decorator widget conforming to Mechanix design specifications
/// for reorderable and draggable list tiles.
///
/// Applies the required double box shadows and background:
/// - `box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.3)`
/// - `box-shadow: 0px 8px 12px 6px rgba(0, 0, 0, 0.15)`
class MechanixReorderableProxyDecorator extends StatelessWidget {
  const MechanixReorderableProxyDecorator({
    super.key,
    required this.child,
    this.borderRadius,
    this.backgroundColor,
  });

  /// The child widget being dragged.
  final Widget child;

  /// Corner radius of the dragged tile.
  final BorderRadius? borderRadius;

  /// Custom background override when dragging.
  final Color? backgroundColor;

  /// The standard Mechanix dragging shadows.
  static const List<BoxShadow> dragShadows = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      offset: Offset(0, 4),
      blurRadius: 4,
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 8),
      blurRadius: 12,
      spreadRadius: 6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedBg = backgroundColor ?? colorScheme.onPrimaryFixedVariant;
    final resolvedRadius = borderRadius ?? context.shape.small;

    return MechanixDragScope(
      isDragging: true,
      child: Material(
        color: Colors.transparent,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: resolvedBg,
            borderRadius: resolvedRadius,
            boxShadow: dragShadows,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// A list tile designed for draggable and reorderable lists.
///
/// On long-press, dragging begins and the trailing icon automatically switches
/// to the drag handle icon (`=`) during the drag gesture, as specified in the Mechanix design.
class MechanixDraggableListTile extends StatelessWidget {
  const MechanixDraggableListTile({
    super.key,
    required this.index,
    this.variant = ListTileVariant.standard,
    this.label,
    this.labelText,
    this.overline,
    this.showOverline = true,
    this.supportingText,
    this.showSupportingText = true,
    this.leading,
    this.showLeading = true,
    this.trailingText,
    this.trailingWidgets = const [],
    this.dragHandleIcon = Icons.drag_handle_rounded,
    this.startDragOnLongPress = true,
    this.onTap,
    this.enabled = true,
    this.selected = false,
    this.isDragging = false,
    this.minHeight = 52.0,
    this.height,
    this.width,
    this.margin,
    this.gap = 8.0,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.theme,
  }) : assert(
         trailingWidgets.length <= 2,
         'MechanixListTile supports a maximum of 2 trailing widgets.',
       );

  /// Index of the item in the reorderable list.
  final int index;

  /// Visual styling variant.
  final ListTileVariant variant;

  /// Primary label text.
  final String? label;

  /// Custom widget for primary label.
  final Widget? labelText;

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

  /// Trailing shortcut or descriptive text (e.g. '⌘C').
  final String? trailingText;

  /// Custom trailing widgets. Supports a maximum of 2 widgets.
  final List<Widget> trailingWidgets;

  /// Drag handle icon displayed while dragging. Defaults to [Icons.drag_handle_rounded] (`=`).
  final dynamic dragHandleIcon;

  /// Whether long-pressing anywhere on the tile initiates dragging. Defaults to true.
  final bool startDragOnLongPress;

  /// Callback when the tile is tapped.
  final VoidCallback? onTap;

  /// Whether the tile is enabled.
  final bool enabled;

  /// Whether the tile is selected.
  final bool selected;

  /// Explicit flag to force dragging state.
  final bool isDragging;

  /// Minimum height of the tile.
  final double minHeight;

  /// Explicit height of the tile.
  final double? height;

  /// Explicit width of the tile.
  final double? width;

  /// Outer margin around the tile container.
  final EdgeInsetsGeometry? margin;

  /// Spacing gap between elements.
  final double gap;

  /// Internal padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Corner radius of the tile.
  final BorderRadius? borderRadius;

  /// Background color override.
  final Color? backgroundColor;

  /// Custom theme override.
  final ListTileThemeDataConfig? theme;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final isCurrentlyDragging = isDragging || MechanixDragScope.of(context);

    final effectiveTrailingWidgets = isCurrentlyDragging
        ? <Widget>[Icon(dragHandleIcon, size: 20, color: colorScheme.onSurface)]
        : trailingWidgets;

    final tile = MechanixListTile(
      variant: variant,
      label: label,
      labelText: labelText,
      overline: overline,
      showOverline: showOverline,
      supportingText: supportingText,
      showSupportingText: showSupportingText,
      leading: leading,
      showLeading: showLeading,
      trailingText: trailingText,
      trailingWidgets: effectiveTrailingWidgets,
      showTrailing: true,
      enabled: enabled,
      selected: selected,
      onTap: onTap,
      minHeight: minHeight,
      height: height,
      width: width,
      margin: margin,
      gap: gap,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      theme: theme,
    );

    Widget result = tile;
    // If dragging was explicitly enabled on the tile itself without proxy decorator
    if (isDragging && !MechanixDragScope.of(context)) {
      result = MechanixReorderableProxyDecorator(
        borderRadius: borderRadius,
        child: tile,
      );
    }

    if (startDragOnLongPress) {
      return ReorderableDelayedDragStartListener(
        index: index,
        enabled: enabled,
        child: result,
      );
    }

    return result;
  }
}

/// A convenience wrapper around Flutter's [ReorderableListView] configured with
/// [MechanixReorderableProxyDecorator] by default and long-press drag behavior.
class MechanixReorderableListView extends StatelessWidget {
  const MechanixReorderableListView({
    super.key,
    required this.children,
    required this.onReorder,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.proxyDecorator,
    this.buildDefaultDragHandles = false,
  });

  /// The list items to display.
  final List<Widget> children;

  /// Callback when an item is moved to a new index.
  final ReorderCallback onReorder;

  /// Optional padding around the list.
  final EdgeInsets? padding;

  /// Whether to shrink wrap the list. Defaults to false.
  final bool shrinkWrap;

  /// Optional scroll physics.
  final ScrollPhysics? physics;

  /// Custom proxy decorator. Defaults to [MechanixReorderableProxyDecorator].
  final ReorderItemProxyDecorator? proxyDecorator;

  /// Whether to show default drag handles on desktop. Defaults to false (uses long press).
  final bool buildDefaultDragHandles;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      buildDefaultDragHandles: buildDefaultDragHandles,
      onReorderItem: onReorder,
      proxyDecorator:
          proxyDecorator ??
          (child, index, animation) {
            return MechanixReorderableProxyDecorator(child: child);
          },
      children: children,
    );
  }
}
