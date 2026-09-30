import 'package:flutter/material.dart';

import '_menu_item_tile.dart';
import 'menu_entry.dart';
import 'menu_enums.dart';
import 'menu_theme.dart';

/// The rendered panel containing menu entries, handling scroll, groups,
/// headers, dividers, and surface styling.
class MenuPanel<T> extends StatelessWidget {
  const MenuPanel({
    super.key,
    required this.entries,
    required this.size,
    required this.theme,
    required this.maxHeight,
    this.width,
    this.minWidth = 160.0,
    this.maxWidth = 360.0,
    required this.focusedIndex,
    required this.onActivateItem,
    this.onItemHovered,
    this.scrollController,
  });

  /// The entries to display.
  final List<MechanixMenuEntry<T>> entries;

  /// The size variant.
  final MechanixMenuSize size;

  /// The active menu configuration.
  final MenuThemeDataConfig theme;

  /// Maximum height before scrolling occurs.
  final double maxHeight;

  /// Explicit fixed width (e.g. when matching anchor width).
  final double? width;

  /// Minimum width if not matching anchor.
  final double minWidth;

  /// Maximum width if not matching anchor.
  final double maxWidth;

  /// The index of the item that currently holds keyboard focus.
  final int focusedIndex;

  /// Callback when an item is selected/activated.
  final ValueChanged<MechanixMenuItem<T>> onActivateItem;

  /// Callback when an item is hovered by pointer.
  final ValueChanged<int>? onItemHovered;

  /// Optional scroll controller.
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final surfaceColor =
        theme.surfaceColor ??
        Theme.of(context).colorScheme.surfaceContainerHigh;
    final borderRadius = theme.borderRadius ?? BorderRadius.circular(8.0);
    final borderWidth = theme.borderWidth ?? 0.0;
    final borderColor =
        theme.borderColor ?? Theme.of(context).colorScheme.outline;
    final elevation = theme.elevation ?? 4.0;
    final shadowColor =
        theme.shadowColor ?? Theme.of(context).colorScheme.shadow;

    // Track sequential item index across entries
    int currentItemIndex = 0;

    List<Widget> buildEntryWidgets(
      List<MechanixMenuEntry<T>> entryList, {
      Color? inheritedGroupBg,
    }) {
      final widgets = <Widget>[];

      for (int i = 0; i < entryList.length; i++) {
        final entry = entryList[i];

        if (entry is MechanixMenuItem<T>) {
          final itemIdx = currentItemIndex++;
          widgets.add(
            MenuItemTile<T>(
              item: entry,
              size: size,
              theme: theme,
              isFocused: focusedIndex == itemIdx,
              onActivate: () => onActivateItem(entry),
              onHoverChanged: (hovered) {
                if (hovered) {
                  onItemHovered?.call(itemIdx);
                }
              },
            ),
          );
        } else if (entry is MechanixMenuDivider) {
          widgets.add(_buildDivider(context, entry));
        } else if (entry is MechanixMenuCustomEntry) {
          widgets.add(entry.builder(context));
        } else if (entry is MechanixMenuGroup<T>) {
          if (entry.showDivider && widgets.isNotEmpty) {
            widgets.add(_buildDivider(context, const MechanixMenuDivider()));
          }

          final groupWidgets = <Widget>[];

          // Header
          if (entry.header != null) {
            groupWidgets.add(entry.header!);
          } else if (entry.headerText != null) {
            groupWidgets.add(
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
                child: Text(
                  entry.headerText!,
                  style:
                      theme.headerTextStyle ??
                      Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                ),
              ),
            );
          }

          // Group children
          groupWidgets.addAll(
            buildEntryWidgets(
              entry.entries,
              inheritedGroupBg: entry.backgroundColor,
            ),
          );

          final groupContainer = Container(
            color: entry.backgroundColor ?? inheritedGroupBg,
            padding: entry.padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: groupWidgets,
            ),
          );

          widgets.add(groupContainer);
        }
      }

      return widgets;
    }

    final entryWidgets = buildEntryWidgets(entries);

    final border = borderWidth > 0
        ? Border.all(color: borderColor, width: borderWidth)
        : null;

    final panelContent = Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: borderRadius,
        border: border,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: shadowColor.withValues(alpha: 0.25),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: false,
          child: SingleChildScrollView(
            controller: scrollController,
            padding: theme.padding ?? const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: entryWidgets,
            ),
          ),
        ),
      ),
    );

    // Apply constraints
    final BoxConstraints constraints;
    if (width != null) {
      constraints = BoxConstraints(
        minWidth: width!,
        maxWidth: width!,
        maxHeight: maxHeight,
      );
    } else {
      constraints = BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );
    }

    return ConstrainedBox(constraints: constraints, child: panelContent);
  }

  Widget _buildDivider(BuildContext context, MechanixMenuDivider divider) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: divider.indent ?? 0.0,
        end: divider.endIndent ?? 0.0,
      ),
      child: Divider(
        height: divider.height ?? theme.dividerHeight ?? 1.0,
        thickness: divider.thickness ?? 1.0,
        color:
            divider.color ??
            theme.dividerColor ??
            Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}
