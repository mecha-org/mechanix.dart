import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';

@widgetbook.UseCase(name: 'Bottom Sheet', type: MechanixBottomSheet)
Widget buildMenuUseCase(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () => MechanixBottomSheet.show(
        context,
        child: Container(width: 400, height: 100),
      ),
      child: const Text("Press Me"),
    ),
  );
}
