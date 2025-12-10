import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/filled_button/mechanix_filled_button_theme.dart';

// Import the widget from your app

@widgetbook.UseCase(name: 'Elevated Button', type: MechanixElevatedButton)
Widget buildMenuUseCase(BuildContext context) {
  return Center(
    child: MechanixFilledButton(
      onPressed: () {
        print("Clicked");
      },
      theme: MechanixFilledButtonThemeData(
        decoration: BoxDecoration(color: Color.fromRGBO(170, 100, 0, 1)),
      ),
      label: "Cancel",
    ),
  );
}
