import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/widgets/bottom_bar/bottom_bar_button_type.dart';
import 'package:widgets/widgets/bottom_bar/mechanix_bottom_bar_theme.dart';

class MechanixBottomBar extends StatelessWidget {
  const MechanixBottomBar({
    super.key,
    this.leadingWidget = const [],
    this.leadingWidgetSpacing = 16,
    this.centerWidget = const [],
    this.centerWidgetSpacing = 16,
    this.anchorWidget = const [],
    this.anchorWidgetSpacing = 16,
    this.theme,
    this.iconColor = const Color(0xFFD2D2D2),
  });

  final List<BottomBarButton> leadingWidget;
  final double leadingWidgetSpacing;
  final List<BottomBarButton> centerWidget;
  final double centerWidgetSpacing;
  final List<BottomBarButton> anchorWidget;
  final double anchorWidgetSpacing;
  final MechanixBottomBarThemeData? theme;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final barTheme = MechanixBottomBarTheme.of(context).merge(theme, context);

    return Container(
      height: barTheme.height,
      width: barTheme.width,
      decoration: barTheme.decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: leadingWidgetSpacing,
        children: [
          if (leadingWidget.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: leadingWidgetSpacing,
              children: leadingWidget
                  .map(
                    (button) => button.build(context, iconColor, barTheme),
                  )
                  .toList(),
            )
          else
            SizedBox.shrink(),
          if (centerWidget.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: centerWidgetSpacing,
              children: centerWidget
                  .map(
                    (button) => button.build(context, iconColor, barTheme),
                  )
                  .toList(),
            )
          else
            SizedBox.shrink(),
          if (anchorWidget.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: anchorWidgetSpacing,
              children: anchorWidget
                  .map(
                    (button) => button.build(context, iconColor, barTheme),
                  )
                  .toList(),
            )
          else
            SizedBox.shrink(),
        ],
      ),
    );
  }
}
