import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/menu/constants/menu_positions.dart';
import 'package:widgets/widgets/menu/models/mechanix_menu_item.dart';

// Import the widget from your app

@widgetbook.UseCase(name: 'Menu', type: MechanixMenu)
Widget buildMenuUseCase(BuildContext context) {
  return Center(
    child: MechanixMenu(
      dropdownPosition: context.knobs.object.dropdown(
        label: 'Dropdown Position',
        labelBuilder: (value) => value.name,
        options: [
          DropdownPosition.topCenter,
          DropdownPosition.topRight,
          DropdownPosition.topLeft,
          DropdownPosition.center,
          DropdownPosition.centerRight,
          DropdownPosition.centerLeft,
          DropdownPosition.bottomCenter,
          DropdownPosition.bottomRight,
          DropdownPosition.bottomLeft,
        ],
      ),
      animationDuration: Duration(
        milliseconds: context.knobs.int.slider(
          label: 'Duration',
          max: 3000,
          min: 0,
          divisions: 100,
        ),
      ),
      items: [
        MechanixMenuItemsType(title: 'Custom Menu 1'),
        MechanixMenuItemsType(title: 'Custom Menu 2'),
        MechanixMenuItemsType(title: 'Custom Menu 3'),
        MechanixMenuItemsType(title: 'Custom Menu 4'),
      ],
    ),
  );
}

class SvgCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Original SVG viewBox: 0 0 300 374
    const double originalWidth = 300;
    const double originalHeight = 374;

    // Scale to fit current size while keeping aspect ratio
    final double scale = min(
      size.width / originalWidth,
      size.height / originalHeight,
    );

    // Center the drawing in the available space
    final double dx = (size.width - originalWidth * scale) / 2;
    final double dy = (size.height - originalHeight * scale) / 2;

    canvas.save();
    canvas.translate(dx, dy);
    canvas.scale(scale);

    // === PATH (converted from your SVG) ===
    final Path path = Path()
      ..moveTo(18, 358)
      ..lineTo(18, 38)
      ..cubicTo(18, 33.5817, 21.5817, 30, 26, 30)
      ..lineTo(167.858, 30)
      ..cubicTo(170.51, 30, 173.054, 28.9464, 174.929, 27.0711)
      ..lineTo(181.071, 20.9289)
      ..cubicTo(182.946, 19.0536, 185.49, 18, 188.142, 18)
      ..lineTo(280, 18)
      ..cubicTo(284.418, 18, 288, 21.5817, 288, 26)
      ..lineTo(288, 358)
      ..cubicTo(288, 362.418, 284.418, 366, 280, 366)
      ..lineTo(26, 366)
      ..cubicTo(21.5817, 366, 18, 362.418, 18, 358)
      ..close();

    // === DROP SHADOWS (approximation of the SVG filter) ===
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.35)
      ..style = PaintingStyle.fill
      // stdDeviation=4 in SVG corresponds roughly to sigma=4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // First shadow: offset dx=-10, dy=-10
    canvas.save();
    canvas.translate(-10, -10);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // Second shadow: offset dx=10, dy=0
    canvas.save();
    canvas.translate(10, 0);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // === MAIN FILL ===
    final Paint fillPaint = Paint()
      ..color = const Color(0xFF2E2E2E)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // === STROKE (inner outline) ===
    final Paint strokePaint = Paint()
      ..color = const Color(0xFF3A3A3A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Using same path for stroke – visually almost identical to the SVG’s 0.25 offset version
    canvas.drawPath(path, strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyCustomMenuShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Draw a custom shape using Path commands
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 20);
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(size.width / 2, size.height, 0, size.height - 20);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
