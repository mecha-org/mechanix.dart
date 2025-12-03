import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/bottomBar/bottom_bar_button_type.dart';

@widgetbook.UseCase(name: 'Bottom Bar', type: MechanixBottomBar)
Widget buildMenuUseCase(BuildContext context) {
  return Scaffold(
    bottomSheet: MechanixBottomBar(
      leadingWidget: [
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
      ],
      centerWidget: [
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
      ],
      anchorWidget: [
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomBarButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
      ],
    ),
  );
}
