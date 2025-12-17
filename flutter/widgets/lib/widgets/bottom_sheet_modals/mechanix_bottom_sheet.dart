import 'package:flutter/material.dart';
import 'package:widgets/widgets/bottom_sheet_modals/mechanix_bottom_sheet_theme.dart';

class MechanixBottomSheet extends StatelessWidget {
  const MechanixBottomSheet({
    super.key,
    required this.child,
  });

  final Widget child;

  static void show(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final sheetTheme = theme.extension<MechanixBottomSheetThemeData>() ??
        const MechanixBottomSheetThemeData();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return SafeArea(
          child: Container(
            width: sheetTheme.width,
            decoration: sheetTheme.decoration,
            child: child,
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
