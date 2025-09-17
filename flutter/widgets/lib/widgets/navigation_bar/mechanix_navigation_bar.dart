import 'package:flutter/material.dart';
import 'package:widgets/mechanix.dart';

import 'mechanix_navigation_bar_theme.dart';

class MechanixNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingWidget;
  final Widget? backIcon;
  final List<Widget>? actionWidgets;

  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final double? leadingWidth;
  final double? height;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final IconThemeData? actionsIconTheme;
  final double? titleSpacing;
  final double? scrolledUnderElevation;

  const MechanixNavigationBar(
      {super.key,
      this.backIcon,
      this.title,
      this.height,
      this.automaticallyImplyLeading,
      this.centerTitle,
      this.titleStyle,
      this.leadingWidget,
      this.leadingWidth,
      this.titleSpacing,
      this.elevation,
      this.foregroundColor,
      this.actionsIconTheme,
      this.actionWidgets,
      this.backgroundColor,
      this.scrolledUnderElevation});

  @override
  Widget build(BuildContext context) {
    final barTheme = MechanixNavigationBarTheme.of(context);
    final theme = Theme.of(context);
    final resolvedCenterTitle = centerTitle ?? barTheme.centerTitle ?? false;
    final resolvedScrolledUnderElevation =
        scrolledUnderElevation ?? barTheme.scrolledUnderElevation ?? 0;

    final resolvedAutomaticallyImplyLeading =
        automaticallyImplyLeading ?? barTheme.automaticallyImplyLeading;

    final resolvedLeadingWidth = leadingWidth ?? barTheme.leadingWidth ?? 44;

    final resolvedHeight = height ?? barTheme.height ?? kToolbarHeight;

    final resolvedBackgroundColor =
        backgroundColor ?? barTheme.backgroundColor ?? Colors.transparent;

    final resolvedForegroundColor = foregroundColor ??
        barTheme.foregroundColor ??
        theme.colorScheme.surfaceContainer;

    final resolvedElevation = elevation ?? barTheme.elevation ?? 0;

    final resolvedActionsIconTheme =
        actionsIconTheme ?? barTheme.actionsIconTheme ?? theme.iconTheme;

    final resolvedTitleSpacing = titleSpacing ?? barTheme.titleSpacing ?? 2;

    // Resolve title text style with proper merging
    final defaultTitleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );

    final themedTitleStyle = barTheme.titleStyle;

    final resolvedtitleStyle =
        defaultTitleStyle.merge(themedTitleStyle).merge(titleStyle);

    return AppBar(
      toolbarHeight: resolvedHeight,
      scrolledUnderElevation: resolvedScrolledUnderElevation,
      automaticallyImplyLeading: resolvedAutomaticallyImplyLeading,
      backgroundColor: resolvedBackgroundColor,
      leadingWidth: resolvedLeadingWidth,
      centerTitle: resolvedCenterTitle,
      actionsIconTheme: resolvedActionsIconTheme,
      titleSpacing: resolvedTitleSpacing,
      foregroundColor: resolvedForegroundColor,
      leading: leadingWidget ??
          (resolvedAutomaticallyImplyLeading && Navigator.canPop(context)
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: SizedBox(
                      height: 16,
                      width: 8,
                      child: backIcon ??
                          Image.asset(
                            MechanixIconImages.backIcon,
                            package: 'widgets',
                          )),
                )
              : null),
      elevation: resolvedElevation,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title ?? '',
              style: resolvedtitleStyle,
            )
        ],
      ),
      actionsPadding: Spacing.symmetric(h: 2, v: 5),
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 50.0);
}
