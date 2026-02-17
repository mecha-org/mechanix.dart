import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/bottom_sheet_modals/mechanix_bottom_sheet_theme.dart';
import 'package:widgets/widgets/wing/mechanix_wing.dart';

class MechanixBottomSheet extends StatelessWidget {
  const MechanixBottomSheet({
    super.key,
  });

  static void show(
    BuildContext context, {
    required Widget child,
    double wingWidth = 125,
    double? sheetHeight,
    bool withCloseButton = false,
    MechanixBottomSheetThemeData? theme,
  }) {
    final sheetTheme =
        MechanixBottomSheetTheme.of(context).merge(theme, context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return SafeArea(
          child: MechanixWing(
            wingWidth: wingWidth,
            size: Size(double.infinity, sheetHeight ?? double.infinity),
            child: Container(
              decoration: sheetTheme.decoration,
              padding: sheetTheme.padding,
              child: Stack(
                children: [
                  if (withCloseButton)
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              context.surfaceContainerHigh),
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                            vertical: 8,
                          )),
                        ),
                        child: const Text("Close"),
                      ).padRight(16),
                    ),
                  child.padTop(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
