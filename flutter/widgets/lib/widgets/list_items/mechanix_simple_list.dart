import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/list_items/mechanix_simple_list_theme.dart';
import 'package:widgets/widgets/list_items/simple_list_items_type.dart';

class MechanixSimpleList extends StatefulWidget {
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

  @override
  State<MechanixSimpleList> createState() => _MechanixSimpleListState();
}

class _MechanixSimpleListState extends State<MechanixSimpleList> {
  Widget _buildDefaultSeparator(BuildContext context, int index) {
    final theme = MechanixSimpleListTheme.of(context);

    if (widget.divider != null) {
      return widget.divider!;
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
        physics: widget.physics,
        itemCount: widget.listItems.length,
        itemBuilder: widget.itemBuilder ??
            (context, index) =>
                _buildListItem(context, widget.listItems[index], theme, index),
        separatorBuilder: widget.separatorBuilder!,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        shrinkWrap: widget.shrinkWrap,
      );
    } else if (themeRequiresDivider) {
      return ListView.separated(
        physics: widget.physics,
        itemCount: widget.itemCount ?? widget.listItems.length,
        itemBuilder: widget.itemBuilder ??
            (context, index) =>
                _buildListItem(context, widget.listItems[index], theme, index),
        separatorBuilder: _buildDefaultSeparator,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        shrinkWrap: widget.shrinkWrap,
      );
    } else {
      return ListView.builder(
        physics: widget.physics,
        itemCount: widget.itemCount ?? widget.listItems.length,
        itemBuilder: widget.itemBuilder ??
            (context, index) =>
                _buildListItem(context, widget.listItems[index], theme, index),
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        hitTestBehavior: widget.hitTestBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        padding: widget.padding,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        findChildIndexCallback: widget.findChildIndexCallback,
        shrinkWrap: widget.shrinkWrap,
        prototypeItem: widget.prototypeItem,
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
        child: Material(
          color: itemTheme.backgroundColor ?? context.colorScheme.secondary,
          child: InkWell(
            // behavior: HitTestBehavior.translucent,
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
                          : index == (widget.listItems.length - 1)
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
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // final itemTheme = MechanixSimpleListTheme.of(context);
    final itemTheme =
        MechanixSimpleListTheme.of(context).merge(context, widget.theme);
    final bool useSeparator = widget.separatorBuilder != null;
    final bool themeRequiresDivider = widget.isDividerRequired && !useSeparator;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Container(
        margin: itemTheme.widgetMargin,
        decoration: BoxDecoration(
          borderRadius: itemTheme.widgetRadius,
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
