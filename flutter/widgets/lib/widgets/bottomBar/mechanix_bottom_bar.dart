import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/widgets/bottomBar/bottom_bar_button_type.dart';
import 'package:widgets/widgets/bottomBar/mechanix_bottom_bar_theme.dart';

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
              children: leadingWidget
                  .map(
                    (button) => button.build(iconColor, barTheme),
                  )
                  .toList(),
            ),
          if (centerWidget.isNotEmpty)
            Row(
              spacing: centerWidgetSpacing,
              children: centerWidget
                  .map(
                    (button) => button.build(iconColor, barTheme),
                  )
                  .toList(),
            ),
          if (anchorWidget.isNotEmpty)
            Row(
              spacing: anchorWidgetSpacing,
              children: anchorWidget
                  .map(
                    (button) => button.build(iconColor, barTheme),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
