import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/filled_button/mechanix_filled_button_theme.dart';

// Import the widget from your app

@widgetbook.UseCase(name: 'Filled Button', type: MechanixElevatedButton)
Widget buildFilledButtonUseCase(BuildContext context) {
  return Center(
    child: MechanixFilledButton(
      onPressed: () {
        print("Clicked");
      },
      theme: MechanixFilledButtonThemeData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(170, 100, 0, 1),
        ),
      ),
      label: "Cancel",
    ),
  );
}
