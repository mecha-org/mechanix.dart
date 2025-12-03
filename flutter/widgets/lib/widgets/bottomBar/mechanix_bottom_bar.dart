import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/widgets/bottomBar/mechanix_bottom_bar_theme.dart';
import 'package:widgets/widgets/icon_widget.dart';

class BottomSheetButton {
  const BottomSheetButton({
    required this.onPressed,
    this.iconPath = '',
    this.iconWidget,
  });

  final String iconPath;
  final void Function() onPressed;
  final IconWidget? iconWidget;
}

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

  final List<BottomSheetButton> leadingWidget;
  final double leadingWidgetSpacing;
  final List<BottomSheetButton> centerWidget;
  final double centerWidgetSpacing;
  final List<BottomSheetButton> anchorWidget;
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
                    (button) => IconButton(
                      onPressed: button.onPressed,
                      icon: button.iconWidget ??
                          IconWidget(
                            iconPath: button.iconPath,
                            iconColor: iconColor,
                          ),
                    ),
                  )
                  .toList(),
            ),
          if (centerWidget.isNotEmpty)
            Row(
              spacing: centerWidgetSpacing,
              children: centerWidget
                  .map(
                    (button) => IconButton(
                      onPressed: button.onPressed,
                      icon: button.iconWidget ??
                          IconWidget(
                            iconPath: button.iconPath,
                            iconColor: iconColor,
                          ),
                    ),
                  )
                  .toList(),
            ),
          if (anchorWidget.isNotEmpty)
            Row(
              spacing: anchorWidgetSpacing,
              children: anchorWidget
                  .map(
                    (button) => IconButton(
                      onPressed: button.onPressed,
                      icon: button.iconWidget ??
                          IconWidget(
                            iconPath: button.iconPath,
                            iconColor: iconColor,
                          ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
