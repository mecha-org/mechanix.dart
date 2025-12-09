import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/search_bar/mechanix_search_bar.dart';

// Import the widget from your app

@widgetbook.UseCase(name: 'Search Bar', type: MechanixSearchBar)
Widget buildMenuUseCase(BuildContext context) {
  return Center(
    child: MechanixTextInput.search(
      onChanged: (value) {},
      // theme: MechanixTextInputThemeData(
      //   fillColor: Color.fromRGBO(21, 21, 21, 1),
      // ),
      // suffixIcon: Container(
      //   child: IconWidget.fromIconData(icon: Icon(Icons.cancel)),
      // ),
      // prefixIcon: Container(
      //   child: IconWidget.fromIconData(icon: Icon(Icons.search)),
      // ),
      isClearButtonRequired: false,
      anchorWidgetIconPath: "assets/icons/tick_icon.png",
      onClear: () {},
    ),
  );
}
