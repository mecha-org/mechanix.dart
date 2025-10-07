import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';

import 'mechanix_navigation_bar_theme.dart';

class MechanixNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingWidget;
  final Widget? backIcon;
  final List<Widget>? actionWidgets;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final MechanixNavigationBarThemeData? theme;
  final double height;

  const MechanixNavigationBar({
    super.key,
    this.backIcon,
    this.title,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.leadingWidget,
    this.actionWidgets,
    this.theme,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final barTheme =
        MechanixNavigationBarTheme.of(context).merge(theme, context);

    return AppBar(
      toolbarHeight: height,
      scrolledUnderElevation: barTheme.scrolledUnderElevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: barTheme.backgroundColor,
      leadingWidth: barTheme.leadingWidth,
      centerTitle: centerTitle,
      actionsIconTheme: barTheme.actionsIconTheme,
      titleSpacing: barTheme.titleSpacing,
      foregroundColor: barTheme.foregroundColor,
      leading: leadingWidget ??
          (automaticallyImplyLeading && Navigator.canPop(context)
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
      elevation: barTheme.elevation,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title ?? '',
              style: barTheme.titleStyle?.merge(context.textTheme.bodySmall),
            )
        ],
      ),
      actionsPadding: barTheme.actionsPadding,
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
