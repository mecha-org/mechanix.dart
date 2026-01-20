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
  });

  final List<BottomBarButton> leadingWidget;
  final double leadingWidgetSpacing;
  final List<BottomBarButton> centerWidget;
  final double centerWidgetSpacing;
  final List<BottomBarButton> anchorWidget;
  final double anchorWidgetSpacing;
  final MechanixBottomBarThemeData? theme;

  Widget buildButtons(
      BuildContext context, List<BottomBarButton> buttons, double spacing) {
    final barTheme = MechanixBottomBarTheme.of(context).merge(theme, context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing,
      children:
          buttons.map((button) => button.build(context, barTheme)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final barTheme = MechanixBottomBarTheme.of(context).merge(theme, context);

    return Container(
      height: barTheme.height,
      width: barTheme.width,
      decoration: barTheme.decoration,
      padding: barTheme.widgetPadding,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: leadingWidget.isNotEmpty
                ? buildButtons(context, leadingWidget, leadingWidgetSpacing)
                : const SizedBox.shrink(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: centerWidget.isNotEmpty
                ? buildButtons(context, centerWidget, centerWidgetSpacing)
                : const SizedBox.shrink(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: anchorWidget.isNotEmpty
                ? buildButtons(context, anchorWidget, anchorWidgetSpacing)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
