import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/list_items/mechanix_simple_list_theme.dart';
import 'package:widgets/widgets/list_items/simple_list_items_type.dart';

class MechanixSimpleList extends StatelessWidget {
  const MechanixSimpleList({
    super.key,
    this.isDividerRequired = false,
    this.divider,
    this.padding,
    this.physics,
    this.controller,
    this.theme,
    required this.listItems,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
  })  : itemBuilder = null,
        prototypeItem = null,
        itemCount = null,
        separatorBuilder = null;

  const MechanixSimpleList.builder({
    super.key,
    this.prototypeItem,
    required this.itemCount,
    required this.itemBuilder,
    this.isDividerRequired = false,
    this.divider,
    this.padding,
    this.physics,
    this.theme,
    this.controller,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
  })  : listItems = const [],
        separatorBuilder = null;

  const MechanixSimpleList.separated({
    super.key,
    required this.listItems,
    required this.separatorBuilder,
    this.padding,
    this.physics,
    this.theme,
    this.controller,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent = 500,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.primary,
    this.restorationId,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.findChildIndexCallback,
    this.shrinkWrap = true,
  })  : isDividerRequired = false,
        prototypeItem = null,
        divider = null,
        itemBuilder = null,
        itemCount = null;

  final List<SimpleListItems> listItems;

  final bool isDividerRequired;

  final Widget? divider;

  final EdgeInsets? padding;

  final ScrollPhysics? physics;

  final ScrollController? controller;

  final int? itemCount;

  final MechanixSimpleListThemeData? theme;

  final Widget? Function(BuildContext context, int index)? itemBuilder;

  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final double? cacheExtent;

  final Clip clipBehavior;

  final DragStartBehavior dragStartBehavior;

  final HitTestBehavior hitTestBehavior;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final bool? primary;

  final String? restorationId;

  final bool reverse;

  final Axis scrollDirection;

  final int? Function(Key key)? findChildIndexCallback;

  final bool shrinkWrap;

  final Widget? prototypeItem;

  Widget _buildDefaultSeparator(BuildContext context, int index) {
    final theme = MechanixSimpleListTheme.of(context);

    if (divider != null) {
      return divider!;
    }
    return Divider(
      thickness: theme.dividerThickness,
      height: theme.dividerHeight,
      color: theme.dividerColor ?? context.colorScheme.outline,
    ).padHorizontal(16);
  }

  Widget _buildListView({
    required MechanixSimpleListThemeData theme,
    required BuildContext context,
    required bool useSeparator,
    required bool themeRequiresDivider,
  }) {
    if (useSeparator) {
      return ListView.separated(
        physics: physics,
        itemCount: listItems.length,
        itemBuilder: itemBuilder ??
            (context, index) =>
                _buildListItem(context, listItems[index], theme, index),
        separatorBuilder: separatorBuilder!,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        hitTestBehavior: hitTestBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        padding: padding,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        findChildIndexCallback: findChildIndexCallback,
        shrinkWrap: shrinkWrap,
      );
    } else if (themeRequiresDivider) {
      return ListView.separated(
        physics: physics,
        itemCount: itemCount ?? listItems.length,
        itemBuilder: itemBuilder ??
            (context, index) =>
                _buildListItem(context, listItems[index], theme, index),
        separatorBuilder: _buildDefaultSeparator,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        hitTestBehavior: hitTestBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        padding: padding,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        findChildIndexCallback: findChildIndexCallback,
        shrinkWrap: shrinkWrap,
      );
    } else {
      return ListView.builder(
        physics: physics,
        itemCount: itemCount ?? listItems.length,
        itemBuilder: itemBuilder ??
            (context, index) =>
                _buildListItem(context, listItems[index], theme, index),
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        hitTestBehavior: hitTestBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        padding: padding,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        findChildIndexCallback: findChildIndexCallback,
        shrinkWrap: shrinkWrap,
        prototypeItem: prototypeItem,
      );
    }
  }

  Widget _buildListItem(BuildContext context, SimpleListItems item,
      MechanixSimpleListThemeData theme, int index) {
    final itemTheme = MechanixSimpleListTheme.of(context);
    final bool isDisabled = item.disabled;

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: isDisabled ? null : item.onTap,
          onTapUp: isDisabled ? null : item.onTapUp,
          onTapDown: isDisabled ? null : item.onTapDown,
          onDoubleTap: isDisabled ? null : item.onDoubleTap,
          child: Container(
            height: theme.height,
            padding: theme.itemPadding,
            decoration: BoxDecoration(
                borderRadius: itemTheme.itemRadius ??
                    (index == 0
                        ? CircularRadius.topAll(4)
                        : index == (listItems.length - 1)
                            ? CircularRadius.bottomAll(4)
                            : BorderRadius.zero)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (item.leading != null) item.leading!.padRight(),
                      Text(
                        item.title,
                        style: item.titleTextStyle ??
                            context.textTheme.labelMedium,
                      )
                    ],
                  ),
                  if (item.trailing != null) item.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // final itemTheme = MechanixSimpleListTheme.of(context);
    final itemTheme = MechanixSimpleListTheme.of(context).merge(context, theme);
    final bool useSeparator = separatorBuilder != null;
    final bool themeRequiresDivider = isDividerRequired && !useSeparator;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        margin: itemTheme.widgetMargin,
        decoration: BoxDecoration(
          borderRadius: itemTheme.widgetRadius,
          color: itemTheme.backgroundColor ?? context.colorScheme.secondary,
        ),
        child: _buildListView(
            theme: itemTheme,
            context: context,
            useSeparator: useSeparator,
            themeRequiresDivider: themeRequiresDivider),
      ),
    );
  }
}
