import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/sectionList/mechanix_section_list_theme.dart';
import 'package:widgets/widgets/sectionList/section_list_items_type.dart';

class MechanixSectionList extends StatelessWidget {
  const MechanixSectionList({
    super.key,
    this.title,
    required this.sectionListItems,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.itemBuilder,
    this.separatorBuilder,
    this.physics,
    this.controller,
    this.theme,
  }) : itemCount = null;

  const MechanixSectionList.builder({
    super.key,
    this.title,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.theme,
    this.controller,
  })  : separatorBuilder = null,
        sectionListItems = const [];

  const MechanixSectionList.separated({
    super.key,
    this.title,
    required this.sectionListItems,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.itemBuilder,
    required this.separatorBuilder,
    this.physics,
    this.controller,
    this.theme,
  }) : itemCount = null;

  final String? title;

  final int? itemCount;

  final List<SectionListItems> sectionListItems;

  final GestureTapCallback? onTap;

  final GestureTapUpCallback? onTapUp;

  final GestureTapDownCallback? onTapDown;

  final GestureTapCallback? onDoubleTap;

  final Widget? Function(BuildContext, int)? itemBuilder;

  final Widget Function(BuildContext, int)? separatorBuilder;

  final ScrollPhysics? physics;

  final ScrollController? controller;

  final MechanixSectionListThemeData? theme;

  Widget _buildSectionList(BuildContext context, SectionListItems item,
      MechanixSectionListThemeData listTheme) {
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
            height: listTheme.height,
            padding: listTheme.itemPadding,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (item.leading != null) item.leading!.padRight(),
                      Text(
                        item.title,
                        style: context.textTheme.labelMedium
                            ?.merge(item.titleTextStyle),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      if (item.trailing != null) item.trailing!,
                      if (item.defaultTrailingIcon)
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: SizedBox(
                              width: 10,
                              height: 17,
                              child: Image.asset(
                                MechanixIconImages.rightCaret,
                                package: 'widgets',
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultSeparator(BuildContext context, int index) {
    final listTheme = MechanixSectionListTheme.of(context).merge(theme);
    if (listTheme.divider != null) {
      return listTheme.divider!;
    } else {
      return Padding(
        padding: listTheme.dividerPadding,
        child: Divider(
          thickness: listTheme.dividerThickness,
          height: listTheme.dividerHeight,
          color: listTheme.dividerColor,
        ),
      );
    }
  }

  Widget _buildListView({
    required BuildContext context,
    required bool useSeparator,
    required bool themeRequiresDivider,
  }) {
    final listTheme = MechanixSectionListTheme.of(context).merge(theme);

    if (useSeparator) {
      return ListView.separated(
        shrinkWrap: true,
        physics: physics,
        controller: controller,
        itemCount: sectionListItems.length,
        itemBuilder: itemBuilder ??
            (context, index) =>
                _buildSectionList(context, sectionListItems[index], listTheme),
        separatorBuilder: separatorBuilder!,
      );
    } else if (themeRequiresDivider) {
      return ListView.separated(
        shrinkWrap: true,
        physics: physics,
        controller: controller,
        itemCount: itemCount ?? sectionListItems.length,
        itemBuilder: itemBuilder ??
            (context, index) =>
                _buildSectionList(context, sectionListItems[index], listTheme),
        separatorBuilder: _buildDefaultSeparator,
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: physics,
        controller: controller,
        itemCount: sectionListItems.length,
        itemBuilder: itemBuilder ??
            (context, index) =>
                _buildSectionList(context, sectionListItems[index], listTheme),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listTheme = MechanixSectionListTheme.of(context).merge(theme);
    final bool useSeparator = separatorBuilder != null;
    final bool themeRequiresDivider =
        listTheme.isDividerRequired && !useSeparator;

    return Container(
      padding: listTheme.widgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: listTheme.titlePadding,
              child: Text(
                title!,
                style: context.textTheme.labelMedium
                    ?.copyWith(color: context.colorScheme.surfaceDim)
                    .merge(listTheme.titleTextStyle),
              ),
            ),
          Container(
              decoration: BoxDecoration(
                borderRadius: listTheme.widgetRadius,
                color: listTheme.backgroundColor?.resolve({}) ??
                    context.colorScheme.secondary,
              ),
              child: _buildListView(
                  context: context,
                  useSeparator: useSeparator,
                  themeRequiresDivider: themeRequiresDivider)),
        ],
      ),
    );
  }
}
