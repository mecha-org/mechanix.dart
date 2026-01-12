import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/widgets/bottom_sheet_modals/mechanix_bottom_sheet_theme.dart';

class MechanixBottomSheet extends StatelessWidget {
  const MechanixBottomSheet({
    super.key,
    required this.child,
    this.theme,
    this.topTabWidth,
    this.topTabRightSideShiftLength,
  });

  final Widget child;
  final double? topTabWidth;
  final double? topTabRightSideShiftLength;
  final MechanixBottomSheetThemeData? theme;

  static void show(
    BuildContext context, {
    required Widget child,
    double? topTabWidth,
    double? topTabRightSideShiftLength,
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
          child: SizedBox(
            width: double.infinity,
            child: ClipPath(
              clipper: _FolderTabClipper(
                topTabWidth: topTabWidth,
                topTabRightSideShiftLength: topTabRightSideShiftLength,
              ),
              child: Container(
                decoration: sheetTheme.decoration,
                padding: sheetTheme.padding,
                child: child,
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

class _FolderTabClipper extends CustomClipper<Path> {
  const _FolderTabClipper({
    this.topTabWidth,
    this.topTabRightSideShiftLength,
  });

  final double? topTabWidth;
  final double? topTabRightSideShiftLength;

  @override
  Path getClip(Size size) {
    const double radius = 8; // Outer rounded corners
    const double tabH = 12; // Tab height
    final double tabW = topTabWidth ?? 10; // Tab width
    const double tabSlope = 12; // Small sloped curve
    final double shift =
        topTabRightSideShiftLength ?? 450; // Shift tab right by this amount

    final Path p = Path();

    // ----- Bottom-left corner -----
    p.moveTo(radius, size.height);
    p.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // ----- Left side up to tab start -----
    p.lineTo(0, tabH + radius);

    // ----- Slope into the tab (shift applied) -----
    p.quadraticBezierTo(
      0,
      tabH,
      tabSlope,
      tabH,
    );

    // ----- Top of tab (shift applied) -----
    p.lineTo(shift + tabW, tabH);

    // ----- Tab end slope upward (shift applied) -----
    p.quadraticBezierTo(
      shift + tabW + tabSlope,
      tabH,
      shift + tabW + tabSlope,
      tabH - tabSlope,
    );

    // ----- Connect into top bar (shift applied) -----
    p.lineTo(shift + tabW + tabSlope, radius);
    p.quadraticBezierTo(
      shift + tabW + tabSlope,
      0,
      shift + tabW + tabSlope + radius,
      0,
    );

    // ----- Top-right corner (UNCHANGED) -----
    p.lineTo(size.width - radius, 0);
    p.quadraticBezierTo(size.width, 0, size.width, radius);

    // ----- Right side down (UNCHANGED) -----
    p.lineTo(size.width, size.height - radius);
    p.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    // ----- Bottom side (UNCHANGED) -----
    p.lineTo(radius, size.height);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
