import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';

@widgetbook.UseCase(name: 'Bottom Bar', type: MechanixBottomBar)
Widget buildMenuUseCase(BuildContext context) {
  return Scaffold(
    bottomSheet: MechanixBottomBar(
      leadingWidget: [
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
      ],
      centerWidget: [
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
      ],
      anchorWidget: [
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
        BottomSheetButton(
          iconPath: "assets/icons/tick_icon.png",
          onPressed: () {},
        ),
      ],
    ),
    // bottomSheet: Container(
    //   height: 60,
    //   color: Colors.blueAccent,
    //   width: double.infinity,
    // ),
  );
}
