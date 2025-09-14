import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';
import 'package:widgets/widgets/bottomSheetModals/mechanix_bottom_sheet_theme.dart';

class MechanixBottomSheet extends StatelessWidget {
  const MechanixBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.shadowColor,
    this.padding = const EdgeInsets.all(mechanixPaddingXl),
  });

  final Widget child;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? shadowColor;
  final EdgeInsetsGeometry padding;
  static void show(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final sheetTheme = theme.extension<MechanixBottomSheetThemeData>() ??
        const MechanixBottomSheetThemeData();

    final backgroundColor =
        sheetTheme.backgroundColor?.resolve({}) ?? theme.colorScheme.surface;
    final borderRadius = sheetTheme.borderRadius ?? 12;
    final shadowColor = sheetTheme.shadowColor?.resolve({}) ?? Colors.black26;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(mechanixPaddingXl),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
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
