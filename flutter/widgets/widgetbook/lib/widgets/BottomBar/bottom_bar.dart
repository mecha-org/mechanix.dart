import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/bottomBar/bottom_bar_button_type.dart';
import 'package:widgets/widgets/bottomBar/mechanix_bottom_bar_theme.dart';
import 'package:widgets/widgets/floating_action_bar/mechanix_floating_action_bar_theme.dart';

@widgetbook.UseCase(name: 'Bottom Bar', type: MechanixBottomBar)
Widget buildMenuUseCase(BuildContext context) {
  return Scaffold(
    bottomSheet: MechanixBottomBar(
      theme: MechanixBottomBarThemeData(
        iconTheme: MechanixBottomBarIconThemeData(
          iconColor: Colors.amberAccent,
        ),
      ),
      leadingWidget: [
        BottomBarButton.extension(
          iconWidget: IconWidget.fromIconData(icon: Icon(Icons.more_vert)),
          floatingActionBarTheme: MechanixFloatingActionBarThemeData(
            barMainAxisAlignment: MainAxisAlignment.center,
            width: double.infinity,
          ),
          extensionWidgets: [
            BottomBarButton(
              iconPath: "assets/icons/tick_icon.png",
              onPressed: () {},
            ),
            BottomBarButton(
              iconWidget: IconWidget.fromIconData(icon: Icon(Icons.map_sharp)),
              onPressed: () {},
              iconTheme: MechanixBottomBarIconThemeData(
                iconSize: 30,
                iconColor: Colors.redAccent,
              ),
            ),
            BottomBarButton(
              iconWidget: IconWidget.fromIconData(icon: Icon(Icons.call)),
              onPressed: () {},
            ),
          ],
        ),
        BottomBarButton.widget(
          widget: IconWidget(iconPath: "assets/icons/tick_icon.png"),
        ),
      ],
      centerWidget: [
        BottomBarButton(
          iconWidget: IconWidget.fromIconData(
            icon: Icon(Icons.video_collection_outlined),
          ),
          onPressed: () {},
        ),
        BottomBarButton(
          iconWidget: IconWidget.fromIconData(
            icon: Icon(Icons.audio_file_outlined),
          ),
          onPressed: () {},
        ),
        BottomBarButton(
          iconWidget: IconWidget.fromIconData(icon: Icon(Icons.textsms)),
          onPressed: () {},
        ),
      ],
      anchorWidget: [
        BottomBarButton(
          iconWidget: IconWidget.fromIconData(
            icon: Icon(Icons.delete),
            iconColor: Colors.redAccent,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}
